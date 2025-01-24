#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

RANDOM_NUMBER=$((1 + $RANDOM % 1000))

echo -e "Please enter your username\n"
read USERNAME

SET_USERNAME=$($PSQL "INSERT INTO users(username) VALUES($USERNAME)")