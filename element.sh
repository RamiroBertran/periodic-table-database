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

      # get atomic_number
      ATOMIC_NUMBER="$($PSQL "SELECT atomic_number FROM properties JOIN elements USING(atomic_number) WHERE (atomic_number=$ELEMENT)")"
      # get name 
      NAME="$($PSQL "SELECT name FROM elements JOIN properites USING(atomic_number) WHERE (atomic_number=$ELEMENT)")"
      else 
      echo "It's a string"
      # Since element is not a number
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
      # get atomic_number
      ATOMIC_NUMBER="$($PSQL "SELECT atomic_number FROM properties JOIN elements USING(atomic_number) WHERE (symbol='$ELEMENT' OR name='$ELEMENT')")"
    fi
  fi
}

GET_ELEMENT_INFORMATION