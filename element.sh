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
    echo -e "$ELEMENT"
  fi
}

GET_ELEMENT_INFORMATION