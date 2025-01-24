#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

RANDOM_NUMBER=$((1 + $RANDOM % 1000))

echo "Enter your username:"
read USERNAME

USER_EXISTS=$($PSQL "SELECT username FROM users WHERE username = '$USERNAME'")

if [[ -z "$USER_EXISTS" ]]
then
  INSERT_USER=$($PSQL "INSERT INTO users(username, games_played) VALUES('$USERNAME', 0)")
  
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  
else
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username = '$USERNAME'")
  BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username = '$USERNAME'")

  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

echo Guess the secret number between 1 and 1000:
read USER_GUESS
GUESS_COUNT=1

while [[ $USER_GUESS -ne $RANDOM_NUMBER ]]
do
  if [[ ! "$USER_GUESS" =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
  elif [[ $USER_GUESS -gt $RANDOM_NUMBER ]]
  then
    echo "It's lower than that, guess again:"
  elif [[ $USER_GUESS -lt $RANDOM_NUMBER ]]
  then
    echo "It's higher than that, guess again:"
fi

  # Read the user's new guess
  read USER_GUESS
  ((GUESS_COUNT++))  # Increment the guess count
done

echo "You guessed it in $GUESS_COUNT tries. The secret number was $RANDOM_NUMBER. Nice job!"

if [[ $GUESS_COUNT -lt $BEST_GAME || $BEST_GAME -eq 0 ]]
then
UPDATE_BEST_GUESS=$($PSQL "UPDATE users SET best_game=$GUESS_COUNT WHERE username='$USERNAME'")
fi
UPDATE_GAME_NUMBER=$($PSQL "UPDATE users SET games_played=games_played+1 WHERE username='$USERNAME'")