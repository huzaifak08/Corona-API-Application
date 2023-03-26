#!/bin/bash
# ./new.sh

# Question :2
function fibonacci {
    a=0
    b=1
    echo "Fibonacci Sequence up to $1:"
    echo -n "$a, $b"
    while [ $b -le $1 ]
    do
        c=$((a + b))
        echo -n ", $c"
        a=$b
        b=$c
    done
    echo ""
}

# Call the function with an input number
fibonacci 50
