#!/bin/sh -e
echo 'Waiting for sia'

# wait while sia is not synced
while ! /home/USER/sia/siac | grep -A1 -E Consensus\: | grep Yes
do
    echo 'Wait'
    sleep 10
done

# If Sia synced, mount it
echo 'Sia loaded, mounting drive...'
/home/USER/repertory -o big_writes /home/USER/siadrive
exit 0
