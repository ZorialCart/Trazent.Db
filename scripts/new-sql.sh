#!/bin/bash
set -e

echo "What type of file do you want to create?"
echo "1) Migration"
echo "2) Function or stored procedure"
read -p "Select an option [1-2]: " TYPE

if [ "$TYPE" != "1" ] && [ "$TYPE" != "2" ]; then
  echo "❌ Invalid option."
  exit 1
fi

if [ "$TYPE" == "1" ]; then
  echo "What action type is the migration?"
  echo "1) create"
  echo "2) update"
  echo "3) insert"
  echo "4) alter"
  echo "5) drop"
  read -p "Select an action [1-5]: " ACTION

  case $ACTION in
    1) ACTION_STR="create";;
    2) ACTION_STR="update";;
    3) ACTION_STR="insert";;
    4) ACTION_STR="alter";;
    5) ACTION_STR="drop";;
    *)
      echo "❌ Invalid action."
      exit 1
      ;;
  esac

  FOLDER="migrations"
  read -p "Enter a descriptive name (lowercase, no accents): " NAME
  SAFE_NAME=$(echo "$NAME" | xargs | tr '[:space:]' '_' | tr '[:upper:]' '[:lower:]' | sed 's/_*$//')
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
  FILENAME="${FOLDER}/${TIMESTAMP}_${ACTION_STR}_${SAFE_NAME}.sql"

else
  FOLDER="functions"
  read -p "Enter a descriptive name (lowercase, no accents): " NAME
  SAFE_NAME=$(echo "$NAME" | xargs | tr '[:space:]' '_' | tr '[:upper:]' '[:lower:]' | sed 's/_*$//')
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
  FILENAME="${FOLDER}/${TIMESTAMP}_${SAFE_NAME}.sql"
fi

touch "$FILENAME"

echo "-- $FILENAME" > "$FILENAME"
echo "-- Author: $(git config user.name)" >> "$FILENAME"
echo "-- Date: $(date)" >> "$FILENAME"
echo "--" >> "$FILENAME"
echo "-- Write your SQL below" >> "$FILENAME"

echo "✅ File created: $FILENAME"