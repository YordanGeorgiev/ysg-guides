#!/usr/bin/bash
#
# install by:
# wget https://github.com/csitea/run.sh/archive/refs/tags/current.zip && unzip -o current.zip -d . && mv -v run.sh-current my-app
# usage: ./run --help

set -E  # Ensure ERR trap is inherited by functions

# Global Error Handler
error_handler() {
  local exit_code=$?
  local line_no=$1
  local cmd="$2"
  if [ $exit_code -ne 0 ]; then
    echo "[FATAL] Command '$cmd' failed at line $line_no with status $exit_code."
    exit $exit_code
  fi
}

# Execution Wrapper
execute_step() {
  local func_name=$1
  do_log "INFO START ::: running action :: $func_name"
  "$func_name"
  local status=$?
  if [ $status -eq 0 ]; then
    do_log "INFO STOP ::: running function :: $func_name"
  else
    do_log "FATAL failed to run action: $func_name with status $status !!!"
    exit $status
  fi
}

trap 'error_handler ${LINENO} "$BASH_COMMAND"' ERR


main() {
  do_flush_screen
  do_set_vars_v205 "$@" # is inside, unless --help flag is present
  ts=$(date "+%Y%m%d_%H%M%S")
  main_log_dir=~/var/log/run.sh/
  mkdir -p $main_log_dir
  main_exec "$@" \
    > >(tee $main_log_dir/run.sh.$ts.out.log) \
    2> >(tee $main_log_dir/run.sh.$ts.err.log)
}

main_exec() {
  local args=("$@")
  do_load_functions
  test -z "${actions:-}" && actions=' do_print_usage '
  do_run_actions "$actions" "${args[@]:2}"
  do_finalize
}

get_function_list() {
  env -i PATH=/bin:/usr/bin:/usr/local/bin bash --noprofile --norc -c '
      source "'"$1"'"
      typeset -f |
      grep '\''^[^{} ].* () $'\'' |
      awk "{print \$1}" |
      while read -r fnc_name; do
         type "$fnc_name" | head -n 1 | grep -q "is a function$" || continue
            echo "$fnc_name"
            done
            '
}

do_read_cmd_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
    -a | --actions) shift && actions="${actions:-}${1:-} " && shift ;;
    -h | --help) actions=' do_print_usage ' && ENV='dev' && shift ;;
    *) shift ;;  # Pass unrecognized arguments to the functions
    esac
  done
}

do_run_actions() {
  actions=$1
  local args=("${@:2}")
  actions_found=0
  cd ${PROJ_PATH:-}
  actions="$(echo -e "${actions}" | sed -e 's/^[[:space:]]*//')"
  run_funcs=''
  do_log "DEBUG do_run_actions: actions=$actions, args=${args[*]}"
  while read -d ' ' arg_action; do
    while read -r fnc_file; do
      # Skip files that don't match the action name BEFORE spawning subprocess
      action_name=$(basename "$fnc_file" .func.sh)
      action_name="do_${action_name//-/_}"
      test "$action_name" != "$arg_action" && continue

      # Only call get_function_list for matching files
      while read -r fnc_name; do
        do_log "DEBUG Sourcing $fnc_file for action $arg_action"
        source $fnc_file
        actions_found=$((actions_found + 1))
        run_funcs="$(echo -e "${run_funcs}\n$fnc_name")"
      done < <(get_function_list "$fnc_file")
    done < <(find "src/bash/run/" "lib/bash/funcs" -type f -name '*.func.sh' | sort)
  done < <(echo "$actions")

  do_log "DEBUG actions_found=$actions_found"
  test $actions_found -eq 0 && {
    do_log "FATAL action(s) requested: \"$actions\" NOT found !!!"
    do_log "FATAL 1. check the spelling of your action"
    do_log "FATAL 2. check the available actions by: ENV=lde ./run --help"
    do_log "FATAL the run failed !"
    exit 1
  }

  run_funcs="$(echo -e "${run_funcs}" | sed -e 's/^[[:space:]]*//;/^$/d')"
  while read -r run_func; do
    cd ${PROJ_PATH:-}
    execute_step "$run_func"
  done < <(echo "$run_funcs")
}

do_flush_screen() {
  printf "\033[2J"
  printf "\033[0;0H"
}

do_log() {
  print_ok() {
    GREEN_COLOR="\033[0;32m"
    DEFAULT_COLOR="\033[0m"
    echo -e "${GREEN_COLOR} ✔ ${1:-} ${DEFAULT_COLOR}"
  }

  print_warning() {
    YELLOW_COLOR="\033[33m"
    DEFAULT_COLOR="\033[0m"
    echo -e "${YELLOW_COLOR} ⚠ ${1:-} ${DEFAULT_COLOR}"
  }

  print_info() {
    BLUE_COLOR="\033[0;34m"
    DEFAULT_COLOR="\033[0m"
    echo -e "${BLUE_COLOR} ℹ ${1:-} ${DEFAULT_COLOR}"
  }

  print_fail() {
    RED_COLOR="\033[0;31m"
    DEFAULT_COLOR="\033[0m"
    echo -e "${RED_COLOR} ✘ ${1:-}${DEFAULT_COLOR}"
  }

  print_debug() {
    GRAY_COLOR="\033[0;37m"
    DEFAULT_COLOR="\033[0m"
    echo -e "${GRAY_COLOR} ⚙ ${1:-}${DEFAULT_COLOR}"
  }

  type_of_msg=$(echo $* | cut -d" " -f1)
  action=$(echo $* | cut -d" " -f2)
  rest_of_msg=$(echo $* | cut -d" " -f3-)
  test -z ${HOST_NAME:-} && export HOST_NAME=$(hostname -s)
  [ -z "${PROJ_PATH}" ] &&
    export PROJ_PATH=$(cd $(dirname $(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path($ARGV[0]))' -- "$0"))/../../.. && pwd)
  [ -z "${PROJ}" ] && export PROJ=$(basename $PROJ_PATH)

  # Pad [TYPE] to 9 chars (longest is [WARNING]) so dates align vertically
  local padded_type
  [[ "$type_of_msg" == "WARNING" ]] && type_of_msg="WARN"
  padded_type=$(printf "%-7s" "[$type_of_msg]")

  # Check if the action is START or STOP and adjust the length
  if [[ "$action" == "START" || "$action" == "STOP" ]]; then
    # Adjust the length of 'START' or 'STOP' token for alignment
    formatted_action=$(printf "%-5s" "$action") # 5 characters wide, adjust as needed
    msg="${padded_type} $(date "+%Y-%m-%d %H:%M:%S %Z") [${PROJ:-}][@${HOST_NAME:-}] [$$] $formatted_action $rest_of_msg"
  else
    # Handle other types of messages without formatting the action
    msg="${padded_type} $(date "+%Y-%m-%d %H:%M:%S %Z") [${PROJ:-}][@${HOST_NAME:-}] [$$] $action $rest_of_msg"
  fi

  log_dir="${PROJ_PATH:-}/dat/log/bash"
  mkdir -p $log_dir || mkdir -p $HOME/var/log/$PROJ && log_dir=$HOME/var/log/$PROJ
  log_file="$log_dir/${PROJ:-}."$(date "+%Y%m%d")'.log'

  case "$type_of_msg" in
  'FATAL') print_fail "$msg" | tee -a $log_file ;;
  'ERROR') print_fail "$msg" | tee -a $log_file ;;
  'WARNING'|'WARN') print_warning "$msg" | tee -a $log_file ;;
  'INFO') print_info "$msg" | tee -a $log_file ;;
  'OK') print_ok "$msg" | tee -a $log_file ;;
  'DEBUG') print_debug "$msg" | tee -a $log_file ;;
  *) echo " · $msg" | tee -a $log_file ;;
  esac
}

do_set_vars_v205() {
  set -u -o pipefail
  do_read_cmd_args "$@"
  unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
  declare -gx RUN_UNIT="$(cd "${unit_run_dir:-}" && basename "$(pwd)").sh" && export RUN_UNIT
  declare -gx PROJ_PATH="$(cd "${unit_run_dir:-}/../../.." && pwd)" && export PROJ_PATH
  declare -gx APP_PATH="$(cd "${unit_run_dir:-}/../../../.." && pwd)" && export APP_PATH
  declare -gx ORG_PATH="$(cd "${unit_run_dir:-}/../../../../.." && pwd)" && export ORG_PATH
  declare -gx BASE_PATH="$(cd "${unit_run_dir:-}/../../../../../.." && pwd)" && export BASE_PATH
  do_ensure_logical_link
  declare -gx PROJ="$(basename "${PROJ_PATH:-}")" && export PROJ
  declare -gx ENV="${ENV:-lde}" && export ENV
  declare -gx LOG_DIR="${PROJ_PATH:-}/dat/log/bash" && export LOG_DIR
  mkdir -p "$LOG_DIR"
  declare -gx LOG_FILE="$LOG_DIR/${PROJ:-}.$(date "+%Y%m%d").log" && export LOG_FILE
  cd "${PROJ_PATH:-}"
  do_resolve_os
  do_log "INFO using: BASE_PATH: $BASE_PATH"
  do_log "INFO using: ORG_PATH: $ORG_PATH"
  do_log "INFO using: APP_PATH: $APP_PATH"
  do_log "INFO using: PROJ_PATH: ${PROJ_PATH:-}"
  do_log "INFO using: LOG_DIR: $LOG_DIR"
  do_log "INFO using: LOG_FILE: $LOG_FILE"
  do_log "INFO using: HOST_NAME: ${HOST_NAME:-}"
  declare_variable "GID" "${GID:-$(id -g)}"
  declare_variable "USER" "${USER:-$(id -un)}"
  declare_variable "GROUP" "${GROUP:-$(id -gn 2>/dev/null || ps -o group,supgrp $$ | tail -n 1 | awk '{print $1}')}"
  echo "Declared variables:"
  compgen -A variable | grep -E '^(HOST_NAME|RUN_UNIT|PROJ_PATH|APP_PATH|ORG_PATH|BASE_PATH|PROJ|ENV|GROUP|USER|UID|GID|OS|LOG_DIR|LOG_FILE)=' | while read -r var; do
    echo "$var: ${!var}"
  done
  REQUIRED_VARS=(HOST_NAME RUN_UNIT PROJ_PATH APP_PATH ORG_PATH BASE_PATH PROJ ENV GROUP USER UID GID OS LOG_DIR LOG_FILE)
  echo "REQUIRED_VARS: ${REQUIRED_VARS[*]}"
  echo PROJ_PATH: ${PROJ_PATH:-} in set_vars
}

do_ensure_logical_link() {
  if [[ "${unit_run_dir:-}" != */src/bash/run ]]; then
    echo "
         you probably unzipped into a new app/tool and forgot to run the following cmd:
         rm -v run; ln -sfn src/bash/run/run.sh run
         so that ls -al run should look like:
         lrwx------  1 osuser  osgroup 2022-01-01 20:40 run -> src/bash/run/run.sh
         !!!
         or you are running within a Dockerfile and calling directly PROJ_PATH/run
         which MIGHT work, but better to call PROJ_PATH/src/bash/run/run.sh
      "
    export PROJ_PATH=$(
      cd $unit_run_dir
      echo $(pwd)
    )
    export ORG_DIR=$(echo ${PROJ_PATH:-} | xargs dirname | xargs basename)
    export BASE_PATH=$(cd $unit_run_dir/../.. && echo $(pwd))
    echo PROJ_PATH: ${PROJ_PATH:-} in do_ensure_logical_link
    echo ORG_DIR: $ORG_DIR
    echo BASE_PATH: $BASE_PATH
  fi
}

do_finalize() {
  do_log "INFO OK $RUN_UNIT's run completed"
  cat <<EOF_FIN_MSG 
  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
         $RUN_UNIT run completed
  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
EOF_FIN_MSG
  exit 0
}

do_load_functions() {
  while read -r f; do
    # do_log "DEBUG Loading function file: $f"
    source $f
  done < <(ls -1 ${PROJ_PATH:-}/lib/bash/funcs/*.func.sh ${PROJ_PATH:-}/src/bash/run/*.func.sh 2>/dev/null)
}

do_resolve_os() {
  if [[ $(uname -s) == *"Linux"* ]]; then
    distro=$(grep '^ID=' /etc/os-release 2>/dev/null | cut -d= -f2 | tr -d '"')
    case "$distro" in
    ubuntu | pop) export OS='ubuntu' ;;
    alpine) export OS='alpine' ;;
    manjaro) export OS='manjaro' ;;
    fedora) export OS='fedora' ;;
    debian) export OS='debian' ;;
    opensuse-tumbleweed | opensuse-leap | suse)
      export OS='suse'
      echo "your Linux distro has limited support !!!"
      ;;
    *) export OS='unknown' ;;
    esac
  elif [[ $(uname -s) == *"SunOS"* ]]; then
    export OS='solaris'
  elif [[ $(uname -s) == *"Darwin"* ]]; then
    export OS='mac'
  elif [[ $(uname -s) == *"MINGW64_NT"* ]]; then
    export OS='windows'
  elif [[ $(uname -s) == *"CYGWIN_NT"* ]]; then
    export OS='cygwin'
  elif [[ $(uname -s) == *"AIX"* ]]; then
    export OS='AIX'
  else
    echo "your OS distro is not supported !!!"
    exit 1
  fi
  do_log "DEBUG OS detected: $OS"
  source "${PROJ_PATH:-}/lib/bash/funcs/set-vars-on-$OS.func.sh" 2>/dev/null || true
  do_set_vars_on_$OS 2>/dev/null || true
}

declare_variable() {
  var_name="$1"
  var_value="$2"
  if readonly | grep -q "^declare -r $var_name="; then
    echo "WARNING: The variable '$var_name' is readonly and cannot be redeclared."
  else
    declare "$var_name=$var_value" && export "$var_name"
    echo "Declared and exported variable: $var_name=$var_value"
  fi
}

# do_ds_run_initial_load function
do_ds_run_initial_load() {
  do_log "DEBUG Entered do_ds_run_initial_load with args: $@"
  do_log "INFO Command: nohup bash run -a do_ds_run_initial_load $1 $2 $3 $4 $5 $6"
  if [ $# -lt 6 ]; then
    do_log "ERROR Not Enough Arguments"
    do_log "ERROR Usage: bash run -a do_ds_run_initial_load IterationNumber JobsListFile DatastageProject AuthFileName StartDate StreamKey"
    exit 1
  fi

  local count=$1
  local jobListfile=$2
  local dsProject=$3
  local authfile=$4
  local start_date=$5
  local STREAM_KEY="${6:-1720}"

  # Validate inputs
  if ! [[ $count =~ ^[0-9]+$ ]] || [ $count -lt 1 ] || [ $count -gt 200 ]; then
    do_log "ERROR IterationNumber must be an integer between 1 and 200"
    exit 1
  fi

  # Validate start_date format (YYYY-MM-DD) and components
  if ! [[ $start_date =~ ^([0-9]{4})-([0-9]{2})-([0-9]{2})$ ]]; then
    do_log "ERROR Invalid StartDate format. Use YYYY-MM-DD."
    exit 1
  fi
  local year=${BASH_REMATCH[1]}
  local month=${BASH_REMATCH[2]}
  local day=${BASH_REMATCH[3]}
  if [ $year -lt 1970 ] || [ $year -gt 2105 ]; then
    do_log "ERROR Invalid StartDate: Year ($year) must be 1970-2105"
    exit 1
  fi
  if [ $month -lt 1 ] || [ $month -gt 12 ]; then
    do_log "ERROR Invalid StartDate: Month ($month) must be 01-12"
    exit 1
  fi
  if [ $day -lt 1 ] || [ $day -gt 31 ]; then
    do_log "ERROR Invalid StartDate: Day ($day) must be 01-31"
    exit 1
  fi
  local test_date="${month}${day}0000${year}"
  do_log "DEBUG Validating date: $test_date"
  if ! date "${test_date}" >/dev/null 2>&1; then
    do_log "ERROR Invalid StartDate: $start_date is not a valid date"
    exit 1
  fi

  # Validate jobListfile existence
  if [ ! -f "$jobListfile" ]; then
    do_log "ERROR Job list file $jobListfile does not exist"
    exit 1
  fi

  # Hardcoded values
  local RUN_SCRIPT="$HOME/opt/osp/osp-edw/osp-edw-utl/src/bash/run/run.sh"

  # Display the job list
  do_log "INFO Jobs to be executed from $jobListfile:"
  cat "$jobListfile"

  local a=1
  while [ $a -le $count ]; do
    # Date calculation: Hardcoded start date with manual day increment
    local current_date
    # Parse start_date and increment day
    local current_year=$year
    local current_month=$month
    local current_day=$((day + a - 1))
    # Simple day overflow handling (not perfect, but sufficient for small increments)
    while [ $current_day -gt 28 ]; do
      # Approximate month-end handling
      if [ $current_month -eq 2 ] && [ $current_day -gt 28 ]; then
        current_day=$((current_day - 28))
        current_month=$((current_month + 1))
      elif [ $current_month -eq 4 ] || [ $current_month -eq 6 ] || [ $current_month -eq 9 ] || [ $current_month -eq 11 ]; then
        if [ $current_day -gt 30 ]; then
          current_day=$((current_day - 30))
          current_month=$((current_month + 1))
        else
          break
        fi
      else
        if [ $current_day -gt 31 ]; then
          current_day=$((current_day - 31))
          current_month=$((current_month + 1))
        else
          break
        fi
      fi
      if [ $current_month -gt 12 ]; then
        current_month=$((current_month - 12))
        current_year=$((current_year + 1))
      fi
    done
    # Format current_date as YYYY-MM-DD
    current_date=$(printf "%04d-%02d-%02d" $current_year $current_month $current_day)
    # Validate the calculated date
    local test_current_date=$(printf "%02d%02d0000%04d" $current_month $current_day $current_year)
    do_log "DEBUG Validating calculated date: $test_current_date"
    if ! date "${test_current_date}" >/dev/null 2>&1; then
      do_log "ERROR Invalid calculated date: $current_date for iteration $a"
      exit 1
    fi
    do_log "INFO Starting iteration $a of $count for date: $current_date"

    # Always copy job list each iteration (by design)
    cp "${jobListfile}" "${jobListfile}.run"
    if [ $? -ne 0 ]; then
      do_log "ERROR Copy of ${jobListfile} to ${jobListfile}.run failed!"
      exit 1
    fi
    chmod 600 "${jobListfile}.run"

    while [ $(wc -l < "${jobListfile}.run") -ne 0 ]; do
      local jobName=$(head -1 "${jobListfile}.run")
      local params=""

      # Determine parameters based on job name
      if [[ "$jobName" == *"BusDate_Start"* ]]; then
        params="\"STREAM_KEY=$STREAM_KEY\" \"NEXT_BUSINESS_DATE=$current_date\""
      elif [[ "$jobName" == *"GCFRLOAD_STG_ALL_Jobs_Start"* ]]; then
        params="\"Configuration file=\$PROJDEF\" \"STREAM_KEY=$STREAM_KEY\" \"NEXT_BUSINESS_DATE=$current_date\""
      fi

      # Run the command
      local cmd="bash \"${RUN_SCRIPT}\" -a do_ds_start_job -p \"${dsProject}\" -s \"${authfile}\" -j \"${jobName}\" $params"
      do_log "INFO Executing: $cmd"
      do_log "INFO Execution Start Time: $(date)"
      eval "$cmd"
      if [ $? -gt 2 ]; then
        do_log "ERROR ${jobName} Failed! Check DataStage Log"
        exit 1
      else
        do_log "INFO ${jobName} Successful! - Cycle $a\n\n"
      fi

      # Remove the first line
      tail -n +2 "${jobListfile}.run" > "${jobListfile}.tmp"
      mv "${jobListfile}.tmp" "${jobListfile}.run"
    done

    do_log "INFO -----------------------------------------------------------------------------------------"
    a=$((a + 1))
  done

  # Clean up
  rm -f "${jobListfile}.run" "${jobListfile}.tmp"
  if [ $? -ne 0 ]; then
    do_log "ERROR Failed to clean up temporary files"
    exit 1
  fi

}

main "$@"
