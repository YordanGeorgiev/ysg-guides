#!/bin/bash

# Detect environment to set output file path
if grep -q Microsoft /proc/version; then
  # Running on WSL
  OUTPUT_DIR="/mnt/c/Temp/var/log"
  OUTPUT_FILE="/mnt/c/Temp/var/log/log.log"
  # Create directory if it doesn't exist
  mkdir -p "$OUTPUT_DIR"
else
  # Running on Unix/Linux
  OUTPUT_DIR=~/var/log
  OUTPUT_FILE=~/var/log/log.log
  # Create directory if it doesn't exist
  mkdir -p "$OUTPUT_DIR"
fi

# Good practice: Rotate the previous log file if it exists.
test -f "$OUTPUT_FILE" && mv -v "$OUTPUT_FILE" "${OUTPUT_DIR}/log.$(date +%Y-%m-%d_%H-%M-%S).log"

# Get a list of all panes in the current session.
ALL_PANES=$(tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}')

# --- STAGE 1: CAPTURE CURRENT STATE ---

# Create or truncate the output file to start fresh for this capture session.
>"$OUTPUT_FILE"

echo "Capturing all tmux panes to $OUTPUT_FILE..."

# Temporary file for capturing pane content
TEMP_FILE=$(mktemp)

# Loop through each pane and capture its full scrollback history.
for pane in $ALL_PANES; do
  # Write a header to the file to identify the pane.
  echo "--- START PANE: $pane ---" >> "$TEMP_FILE"
  echo "" >> "$TEMP_FILE"

  # FIX: Changed '-S -' to '-S -99999'.
  # The '-S -' flag only captures the visible part of the pane.
  # Using a large negative number like '-S -99999' tells tmux to capture
  # the entire scrollback history buffer.
  tmux capture-pane -S -99999 -p -t "$pane" >> "$TEMP_FILE"

  # Write a footer for better separation.
  echo "" >> "$TEMP_FILE"
  echo "--- STOP  PANE: $pane ---" >> "$TEMP_FILE"
  echo "" >> "$TEMP_FILE"
done

# Replace blocks of more than one empty line with a single empty line
awk 'BEGIN {prev_empty=0} /^\s*$/ {if (!prev_empty) {print; prev_empty=1} next} {print; prev_empty=0}' "$TEMP_FILE" > "$OUTPUT_FILE"

# Clean up temporary file
rm "$TEMP_FILE"

echo "Successfully captured all panes."

# --- STAGE 2: CLEAR PANES FOR NEXT SESSION ---
echo "Clearing all panes for the next session..."

for pane in $ALL_PANES; do
  # Clear the scrollback history buffer.
  tmux clear-history -t "$pane"
  
  # Also clear the visible screen by sending a Ctrl-L keystroke.
  tmux send-keys -t "$pane" 'C-l'
done

# Detect environment and copy to clipboard
if grep -q Microsoft /proc/version; then
  # Running on WSL
  cat "${OUTPUT_FILE}" | clip.exe
else
  # Running on native Linux
  cat "${OUTPUT_FILE}" | xclip -selection clipboard
fi

echo "All panes cleared. Ready for next capture."
echo "produced: "
echo "$OUTPUT_FILE"
