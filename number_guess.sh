#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

RANDOM_NUMBER=$((1 + $RANDOM % 1000))

echo Enter your username:
read USERNAME

SET_USERNAME=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
USER_EXISTS=$($PSQL "SELECT username FROM users WHERE username = '$USERNAME'")

# If the user doesn't exist, print a message
if [[ -z "$USER_EXISTS" ]]
then
echo Welcome, $USERNAME! It looks like this is your first time here.
fi