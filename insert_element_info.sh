#!/bin/bash
PSQL="psql -X --username=kvothe_snow --dbname=periodic_table -t --no-align -c"
cat elements_data.csv | while IFS="," read ATOMIC_NUMBER ATOMIC_MASS SYMBOL SYMBOL_NAME MELTING_POINT BOILING_POINT TYPE_ID
do
	if [[  $ATOMIC_NUMBER != "atomic_number" ]]
	then
		# Check if elemetns is already on table 
    ELEMENT="$($PSQL "
    SELECT * FROM properties WHERE atomic_number=$ATOMIC_NUMBER
    ")"

		if [[ -z $ELEMENT ]]
		then
			# insert element infromation into table 
			INSERT_ELEMENT_INFO="$($PSQL "
      INSERT INTO properties VALUES
      ($ATOMIC_NUMBER, $ATOMIC_MASS, $MELTING_POINT, $BOILING_POINT, $TYPE_ID);
      ")"
      echo $INSERT_ELEMENT_INFO
		fi
	fi
done

cat elements_data.csv | while IFS="," read ATOMIC_NUMBER ATOMIC_MASS SYMBOL SYMBOL_NAME MELTING_POINT BOILING_POINT TYPE_ID
do 
  if [[ $ATOMIC_NUMBER != 'atomic_number' ]]
  then
    #Insert info into elements table 
  INSERT_ELEMENT_INFO="$($PSQL "
  INSERT INTO elements VALUES
  ($ATOMIC_NUMBER, '$SYMBOL', '$SYMBOL_NAME');
  ")"
  fi
  
done