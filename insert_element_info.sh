#!/bin/bash
PSQL="psql -X --username=kvothe_snow --dbname=periodic_table -t --no-align -c"
TRUNCATE="$($PSQL "TRUNCATE properties")"
cat elements_data.csv | while IFS="," read ATOMIC_NUMBER ATOMIC_MASS SYMBOL MELTING_POINT BOILING_POINT TYPE_ID
do
	if [[  $ATOMIC_NUMBER != "atomic_number" ]]
	then
		# Check if elemetns is already on table 
		ATOMIC_ON_TABLE="$($PSQL "SELECT atomic_number FROM properties WHERE atomic_number = $ATOMIC_NUMBER")"
		if [[ -z $ATOMIC_ON_TABLE ]]
		then
			# insert element infromation into table 
			INSERT_ELEMENT_INFO="$($PSQL "INSERT INTO properties(atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES($ATOMIC_NUMBER, $ATOMIC_MASS, $MELTING_POINT, $BOILING_POINT, $TYPE_ID)")"
		fi
	fi
done

cat elements_data.csv | while IFS="," read ATOMIC_NUMBER ATOMIC_MASS SYMBOL SYMBOL_NAME MELTING_POINT BOILING_POINT TYPE_ID
do 
  if [[ $ATOMIC_NUMBER != 'atomic_number' ]]
  then
    echo $ATOMIC_NUMBER
  fi
  
done