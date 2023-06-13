#!/bin/bash
PSQL="psql -X --username=kvothe_snow --dbname=periodic_table --no-align -t -c"
PROVIDE_ARGUMENT() {
  if [[ $1 ]]
  then 
    echo -e "\nPlease provide an element as an argument"
  else 
    echo $1
  fi
}

PROVIDE_ARGUMENT