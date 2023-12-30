# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

# cleanup /Tmp directory on quit
clean_dirs=("$TEMP/dl/" "$TEMP/unzipped/" "$TEMP/playground/")
echo "Cleaning temporary directory..."
for dir in "${clean_dirs[@]}"
do
  if [[ -d "$dir" ]]; then
    rm -rf "$dir"
    mkdir "$dir"
  fi
done

