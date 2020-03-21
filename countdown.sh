#/bin/sh

MINUTES=$1
SONG=$2

MINUTES_IN_SEC=$(( ${MINUTES} * 60 ))
echo "Countdown is set to ${MINUTES_IN_SEC} seconds"
echo "Start time: $(date)"

sleep ${MINUTES_IN_SEC}
echo "End time:   $(date)"
echo

cvlc --play-and-exit "${SONG}"

