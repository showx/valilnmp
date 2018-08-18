#!/bin/sh

mobiles=()
messages=""

for i in $@; do
    messages=$messages$i" "
done

for m in ${mobiles[@]};
do
    ./sendsms.py $m "$messages"
done