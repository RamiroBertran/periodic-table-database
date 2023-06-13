#!/bin/bash
PSQL="psql -X --username=kvothe_snow --dbname=periodic_table --no-align -t -c"
echo "Please provide an element as an argument"

GET_ELEMENT_INFORMATION() {
  if [[ $1 ]]
  then 
    echo "$1"
  fi
  read ELEMENT
  if [[ -z $ELEMENT ]] 
  then
    GET_ELEMENT_INFORMATION "Please provide an element as an argument"
  else 
    # check if input is a number or a string
    if [[ $ELEMENT =~ [0-9]+ ]]
    then 
      # Since element is a number: 
      # check if the element is in database 
      # get atomic_number
      ATOMIC_NUMBER="$($PSQL "SELECT atomic_number FROM properties JOIN elements USING(atomic_number) WHERE (atomic_number=$ELEMENT)")"
      if [[ -z ATOMIC_NUMBER ]]
      then
        GET_ELEMENT_INFORMATION "Sorry, we don't find any ralation in our database"
        else 
      # get name 
      NAME="$($PSQL "SELECT name FROM elements JOIN properties USING(atomic_number) WHERE (atomic_number=$ELEMENT)")"
      # get type 
      TYPE="$($PSQL "SELECT type FROM properties JOIN types USING(type_id) WHERE (atomic_number=$ELEMENT)")"
      # get atomic_mass
      ATOMIC_MASS="$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ELEMENT")"
      # get melting_point_celsius
      MELTING_POINT="$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ELEMENT")"
      # get boiling_point_celsius
      BOILING_POINT="$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ELEMENT")"
      fi
      else 
      # Since element is not a number:
      # get atomic_number
      ATOMIC_NUMBER="$($PSQL "SELECT atomic_number FROM properties JOIN elements USING(atomic_number) WHERE (symbol='$ELEMENT' OR name='$ELEMENT')")"
      if [[ -z $ATOMIC_NUMBER ]]
      then 
        GET_ELEMENT_INFORMATION "Sorry we do not find any relation in our database"
        else
      #get type 
      TYPE="$($PSQL "SELECT type FROM properties JOIN types USING(type_id) JOIN elements USING(atomic_number) WHERE (symbol='$ELEMENT' OR name='$ELEMENT')")"
      #get atomic_mass 
      ATOMIC_MASS="$($PSQL "SELECT atomic_mass FROM properties JOIN elements USING(atomic_number) WHERE (symbol='$ELEMENT' OR name='$ELEMENT')")"
      #get melting_point_celsius
      MELTING_POINT="$($PSQL "SELECT melting_point_celsius FROM properties JOIN elements USING(atomic_number) WHERE (symbol='$ELEMENT' OR name='$ELEMENT')")"
      #get boliling_point_celsius 
      BOILING_POINT="$($PSQL "SELECT boiling_point_celsius FROM properties JOIN elements USING(atomic_number) WHERE (symbol='$ELEMENT' OR name='$ELEMENT')")"
      #get length of string
      ELEMENT_LENGHT=$(echo -n "$ELEMENT" | wc -m)
      if [[ $ELEMENT_LENGHT -gt 2 ]] 
      then 
      # Because the variable $ELEMENT is greater than 2 we are guessing that the input is the name of the element not the symbol 
      # set $ELEMENT to NAME variable 
      NAME=$ELEMENT
      else 
      # In the case the variable is less or equal than 2 we get the name of the element quering it. 
      # query to get the name
      NAME="$($PSQL "SELECT name FROM elements JOIN properties USING(atomic_number) WHERE (symbol='$ELEMENT')")"
      fi
      fi
    fi
  fi
}

GET_ELEMENT_INFORMATION