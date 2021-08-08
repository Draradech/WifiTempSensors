#!/bin/bash

sample() {
  TimeSeries/resample 2m avg 1 rawData/$1.log sampleData/02m.$2.log
  TimeSeries/resample 10m avg 1 sampleData/02m.$2.log sampleData/10m.$2.log
  TimeSeries/resample 60m avg 3 sampleData/10m.$2.log sampleData/60m.$2.log
  TimeSeries/resample 1d avg 18 sampleData/60m.$2.log sampleData/d.$2.log
}

sampleTemp() {
  sample $1 t_$2
}

sampleModule() {
  sample d_$1 d_$2
  sample v_$1 v_$2
  sample c_$1 c_$2
  sample r_$1 r_$2
}

graph() {
  prefix=$1
  name=$2
  shift 2
  cmd="TimeSeries/graph 1440 $(date +%s) $1 $2 $3 500 $4 $5 $6 $7 "
  shift 7
  while (( "$#" )); do
    cmd=$cmd"sampleData/$prefix$1.log $1 $2 "
    shift 2
  done
  cmd=$cmd"graphs/$name.pnm"
  $($cmd)
}

graphTemp() {
  graph 02m.t_ temp_1d  1m  30m 2h  35.0 0.05 1.0  5.0 $*
  graph 10m.t_ temp_10d 10m 6h  1d  35.0 0.05 1.0  5.0 $*
  graph 60m.t_ temp_2m  1h  1d  7d  35.0 0.05 1.0  5.0 $*
  graph d.t_   temp_4y  12h 1M  1M  35.0 0.05 1.0  5.0 $*
}

graphTempLow() {
  graph 02m.t_ templow_1d  1m  30m 2h  20.0 0.1  1.0  5.0 $*
  graph 10m.t_ templow_10d 10m 6h  1d  20.0 0.1  1.0  5.0 $*
  graph 60m.t_ templow_2m  1h  1d  7d  20.0 0.1  1.0  5.0 $*
  graph d.t_   templow_4y  12h 1M  1M 20.0 0.1  1.0  5.0 $*
}

graphModule() {
  graph 02m.v_ voltage_1d  1m  30m 2h    3.4  0.001 0.01  0.05 $*
  graph 10m.v_ voltage_10d 10m 6h  1d    3.4  0.001 0.01  0.05 $*
  graph 60m.v_ voltage_2m  1h  1d  7d    3.4  0.001 0.01  0.05 $*
  graph d.v_   voltage_4y  12h 1M  1M   3.4  0.001 0.01  0.05 $*
  graph 02m.d_ delay_1d    1m  30m 2h    5.0  0.01  0.1   0.5  $*
  graph 10m.d_ delay_10d   10m 6h  1d    5.0  0.01  0.1   0.5  $*
  graph 60m.d_ delay_2m    1h  1d  7d    5.0  0.01  0.1   0.5  $*
  graph d.d_   delay_4y    12h 1M  1M   5.0  0.01  0.1   0.5  $*
  graph 02m.r_ rssi_1d     1m  30m 2h  -30.0  0.14  2.0  10.0  $*
  graph 10m.r_ rssi_10d    10m 6h  1d  -30.0  0.14  2.0  10.0  $*
  graph 60m.r_ rssi_2m     1h  1d  7d  -30.0  0.14  2.0  10.0  $*
  graph d.r_   rssi_4y     12h 1M  1M -30.0  0.14  2.0  10.0  $*
  graph 02m.c_ channel_1d  1m  30m 2h   12.0  0.024 1.0   1.0  $*
  graph 10m.c_ channel_10d 10m 6h  1d   12.0  0.024 1.0   1.0  $*
  graph 60m.c_ channel_2m  1h  1d  7d   12.0  0.024 1.0   1.0  $*
  graph d.c_   channel_4y  12h 1M  1M  12.0  0.024 1.0   1.0  $*
}

#sampleTemp ff0869651502 Gaeste_1
#sampleTemp ff5ffa641501 Gaeste_2
sampleTemp ffb030651502 Gaeste
sampleTemp 382ab60c0000 Wohnzimmer
sampleTemp c22cb50c0000 Keller
sampleTemp 70f8b50c0000 Kueche
sampleTemp 2327b60c0000 Kuehlschrank_O
sampleTemp 94e3b50c0000 Kuehlschrank_M
sampleTemp f1e3b30c0000 Kuehlschrank_U
sampleTemp f8f5b20c0000 Gefrierfach
sampleTemp 8206b50c0000 Bad_DG
sampleTemp 4c3cb30c0000 Bad
sampleTemp 0dadb60c0000 Aussen
sampleTemp 7f6fb30c0000 WC
sampleTemp a092b40c0000 Buero
sampleTemp 2c0fb60c0000 Aussen_Busch

sampleModule db84e0dd02 Gaeste
sampleModule cf7f9b8e21 Wohnzimmer
sampleModule cf7f9b9443 Keller
sampleModule cf7f9b9432 Kueche
sampleModule db84e0dd10 Bad_DG
sampleModule db84e0dc80 Bad
sampleModule db84e0dd2b WC
sampleModule db84e0dd54 Buero
sampleModule db84e0dc66 Aussen_Busch

graphTemp \
Aussen       777777 \
Aussen_Busch 7700ff \
WC           ffffff \
Gaeste       ff0000 \
Buero        77ff00 \
Wohnzimmer   0077ff \
Keller       00ff77 \
Kueche       ffff00 \
Bad_DG       ff00ff \
Bad          ff7700

graphTempLow \
Kuehlschrank_U ff0000 \
Kuehlschrank_O ff7700 \
Kuehlschrank_M ffff00 \
Gefrierfach    77ff00

graphModule \
Aussen_Busch 7700ff \
WC           ffffff \
Gaeste       ff0000 \
Buero        77ff00 \
Wohnzimmer   0077ff \
Keller       00ff77 \
Kueche       ffff00 \
Bad_DG       ff00ff \
Bad          ff7700

mogrify -format png graphs/*.pnm
rm graphs/*.pnm

