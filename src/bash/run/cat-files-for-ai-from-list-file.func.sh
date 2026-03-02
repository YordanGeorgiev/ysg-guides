#!/bin/bash

# Usage:
# on a win wsl box
# LST_FLE="/mnt/c/Temp/var/lst.txt" COMMENT="#" ./run -a do_cat_files_for_ai_from_list_file
# on a nix box
# LST_FLE=~/var/lst.txt COMMENT="#" ./run -a do_cat_files_for_ai_from_list_file

do_cat_files_for_ai_from_list_file() {
  # Detect environment to set default LST_FLE and OUTPUT_FILE
  if grep -q Microsoft /proc/version; then
    # Running on WSL
    LST_FLE="${LST_FLE:-/mnt/c/Temp/var/lst.txt}"
    OUTPUT_DIR="/mnt/c/Temp/var/log"
    OUTPUT_FILE="/mnt/c/Temp/var/log/log.log"
    # Create directory if it doesn't exist
    mkdir -p "$OUTPUT_DIR"
  else
    # Running on Unix/Linux
    LST_FLE="${LST_FLE:-~/var/lst.txt}"
    OUTPUT_DIR=~/var/log
    OUTPUT_FILE=~/var/log/log.log
    # Create directory if it doesn't exist
    mkdir -p "$OUTPUT_DIR"
  fi

  COMMENT="${COMMENT:-\#}"  # Default comment character if not set
  echo "COMMENT: $COMMENT"

  # Check if LST_FLE is set and the file exists
  if [ -z "${LST_FLE}" ]; then
    do_log "ERROR: LST_FLE environment variable is not set."
    return 1
  fi
  if [ ! -f "${LST_FLE}" ]; then
    do_log "ERROR: File specified by LST_FLE (${LST_FLE}) does not exist."
    return 1
  fi

  # Remove existing log file if it exists
  [ -f "${OUTPUT_FILE}" ] && rm -f "${OUTPUT_FILE}"

  # Process each file path from the list file
  do_log "INFO Processing list file: ${LST_FLE}"
  while IFS= read -r file_path; do
    # Skip empty lines and commented out lines 
    [[ -z "$file_path" || "$file_path" =~ ^# ]] && continue

    echo "wip: ${file_path}"

    # Verify the file exists
    if [ ! -f "${file_path}" ]; then
      echo "Warning: File does not exist: ${file_path}"
      continue
    fi

    # Log START marker and file path
    echo "${COMMENT} START ::: file : ${file_path}" >>"${OUTPUT_FILE}"

    # Append file content to log
    cat "${file_path}" >>"${OUTPUT_FILE}"

    # Log STOP marker and file path
    echo "${COMMENT} STOP   ::: file : ${file_path}" >>"${OUTPUT_FILE}"
  done < <(cat "${LST_FLE}")

  # Log completion
  do_log "INFO: Generated log file: ${OUTPUT_FILE}"
  do_log "INFO: Paste that to the AI prompt and enjoy the magic!"

  # Detect environment and copy to clipboard
  if grep -q Microsoft /proc/version; then
    # Running on WSL
    cat "${OUTPUT_FILE}" | clip.exe
  else
    # Running on native Linux
    cat "${OUTPUT_FILE}" | xclip -selection clipboard
  fi

}
