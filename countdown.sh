#/bin/sh

SCRIPT_DIR="$(dirname "$(readlink --canonicalize "$0")")"
SONG="${SCRIPT_DIR}/Bongos_Sample_Sound_Effect_Loops_HD-mgJkQ5NUQ7Y.webm"

TOTAL_COUNTDOWN_TIME_IN_SECONDS=0

for TIME_ARG in "$@"
do
    LENGTH_OF_TIME_ARG=${#TIME_ARG}
    TIME_ARG_SUBSTRING_LENGTH=$(( LENGTH_OF_TIME_ARG - 1 ))
    TIME=${TIME_ARG:0:$TIME_ARG_SUBSTRING_LENGTH}

    TIME_UNIT=${TIME_ARG:$TIME_ARG_SUBSTRING_LENGTH:1}

    if [ "${TIME_UNIT}" = "s" ]
    then
        let "TOTAL_COUNTDOWN_TIME_IN_SECONDS+=${TIME}"
    fi

    if [ "${TIME_UNIT}" = "m" ]
    then
        SECONDS_IN_MINUTE=60
        MINUTES_IN_SECONDS=$(( ${TIME} * ${SECONDS_IN_MINUTE} ))
        let "TOTAL_COUNTDOWN_TIME_IN_SECONDS+=${MINUTES_IN_SECONDS}"
    fi

    if [ "${TIME_UNIT}" = "h" ]
    then
        SECONDS_IN_HOUR=3600
        HOURS_IN_SECONDS=$(( ${TIME} * ${SECONDS_IN_HOUR} ))
        let "TOTAL_COUNTDOWN_TIME_IN_SECONDS+=${HOURS_IN_SECONDS}"
    fi
done

clear

START_TIME_IN_SECONDS=$(date "+%s")
TIME_ELAPSED_IN_SECONDS=0

START_TIME=$(date)
PREDICTED_END_TIME=$(date -d "${START_TIME} + ${TOTAL_COUNTDOWN_TIME_IN_SECONDS} seconds" "+%T")
START_TIME=$(date "+%T")

last_update_time_in_seconds=$(date "+%s")

printf "loading..."

while [ ${TIME_ELAPSED_IN_SECONDS} -lt ${TOTAL_COUNTDOWN_TIME_IN_SECONDS} ]
do
    CURRENT_TIME=$(date "+%T")

    CURRENT_TIME_IN_SECONDS=$(date "+%s")

    TIME_ELAPSED_IN_SECONDS=$(( CURRENT_TIME_IN_SECONDS - START_TIME_IN_SECONDS ))

    REMAINING_TIME_IN_SECONDS=$(( TOTAL_COUNTDOWN_TIME_IN_SECONDS - TIME_ELAPSED_IN_SECONDS ))

    MESSAGE=""

    MESSAGE+="Countdown is set to ${TOTAL_COUNTDOWN_TIME_IN_SECONDS} seconds"
    MESSAGE+="\n\n"

    MESSAGE+="Start time:\t\t"
    MESSAGE+="${START_TIME}"
    MESSAGE+="\n"

    MESSAGE+="Current time:\t\t${CURRENT_TIME}\n"

    MESSAGE+="Predicted end time:\t${PREDICTED_END_TIME}\n\n"

    MESSAGE+="Time elapsed:\t${TIME_ELAPSED_IN_SECONDS}\n"

    MESSAGE+="Remaining time:\t${REMAINING_TIME_IN_SECONDS}\n"

    current_time_in_seconds=$(date "+%s")
    (( last_update_time_in_seconds == current_time_in_seconds ))
    is_time_the_same=$?
    yes="0"
    if [ "${is_time_the_same}" = "${yes}" ]
    then
        continue
    fi

    last_update_time_in_seconds=${current_time_in_seconds}

    clear
    printf "${MESSAGE}"
done

END_TIME=$(date "+%T")

MESSAGE+="\n"
MESSAGE+="End time:\t\t${END_TIME}\n\n"

clear
printf "${MESSAGE}"

cvlc "${SONG}" --play-and-exit --no-volume-save --gain 8 --audio-filter equalizer --equalizer-bands "0 0 0 0 0 0 0" --equalizer-preamp 15

