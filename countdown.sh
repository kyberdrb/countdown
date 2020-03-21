#/bin/sh

MINUTES=$1
SONG_ARG=$2
SONG=${SONG_ARG:="/home/laptop/git/kyberdrb/countdown/Bongos_Sample_Sound_Effect_Loops_HD-mgJkQ5NUQ7Y.webm"}

MINUTES_IN_SEC=$(( ${MINUTES} * 60 ))
echo "Countdown is set to ${MINUTES_IN_SEC} seconds"
echo "Start time: $(date)"

#sleep ${MINUTES_IN_SEC}

echo "End time:   $(date)"
echo

cvlc --play-and-exit "${SONG}"

