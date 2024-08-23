#!/bin/bash

# Function to find all Firefox profile directories
find_all_profiles() {
  # Locate the profiles.ini file
  PROFILES_INI="$HOME/.mozilla/firefox/profiles.ini"
  
  # Check if profiles.ini exists
  if [ ! -f "$PROFILES_INI" ]; then
    echo "profiles.ini not found. Exiting."
    exit 1
  fi

  # Extract all profile paths
  awk -F= '/^Path/ {print $2}' "$PROFILES_INI"
}

# Get all profile directories
PROFILE_DIRS=$(find_all_profiles)

# Preference to set
PREFERENCE='user_pref("gnomeTheme.hideSingleTab", true);'

# Iterate over each profile directory
for PROFILE_DIR in $PROFILE_DIRS; do
  FULL_PROFILE_DIR="$HOME/.mozilla/firefox/$PROFILE_DIR"
  USER_JS="$FULL_PROFILE_DIR/user.js"

  # Create user.js if it doesn't exist
  if [ ! -f "$USER_JS" ]; then
    touch "$USER_JS"
  fi

  # Check if the preference is already set
  if ! grep -q "$PREFERENCE" "$USER_JS"; then
    echo "$PREFERENCE" >> "$USER_JS"
    echo "Preference gnomeTheme.hideSingleTab set to true in profile $PROFILE_DIR."
  else
    echo "Preference gnomeTheme.hideSingleTab is already set to true in profile $PROFILE_DIR."
  fi
done
