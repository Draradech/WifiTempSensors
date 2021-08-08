#!/bin/bash
rsync --append-verify power@[$(cat /home/powerpi/last_ip)]:tempmon/*.log rawData
#rsync --append-verify power@strompi:tempmon/*.log rawData
