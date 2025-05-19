#!/bin/bash

# Create a Test Harness
# Haylee Oyler

## Part 1

# % bash query_timer.sh label num_reps query db_file csv_file

label=$1
num_reps=$2
query=$3
db_file=$4
csv_file=$5

# get current time and store it
start_time=$(date +%s)

# loop num_reps times
for ((i = 1; i <= num_reps; i++)); do
#     duckdb db_file query
    duckdb "$db_file" "$query" > /dev/null
# end loop
done

# get current time
end_time=$(date +%s)

# Fixed time calculation!
elapsed_time=$((end_time - start_time)) 

# divide elapsed time by num_reps
avg_time=$(python -c "print($elapsed_time / $num_reps)")

# write output
echo "$label,$num_reps,$elapsed_time,$avg_time" >> "$csv_file"

## Part 2
# I started with 100 repetitions which gave me the same time for each method.

## NOTE: Before, I had forgotten to add another 0 in the decimal place when reporting my answer, that was my mistake!! I also fixed the time so I'm not getting negative numbers anymore. 

# So, I upped it to 1000 repetitions, and that revealed that outer_join was fastest with a time of 0.035s 
# compared to 0.039 for subquery and 0.042 for except.