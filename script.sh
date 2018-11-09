#!/bin/bash

# Reset result files
echo > result/failed.txt
echo > result/success.txt

totalCount=0
perfectAnswersCount=0

# All possible test cases (Excluding invalid input)
AGE_TEST=(35 36 35 36 35 36 34 34 34)
EXP_TEST=(8 8 9 9 7 7 8 9 7)
ANSWER=(50000 50000 50000 50000 37500 37500 28000 28000 17500)
# Too lazy to learn writing a proper REGEX in bash :(
ANSWER_COMMA=(50,000 50,000 50,000 50,000 37,500 37,500 28,000 28,000 17,500)
ANSWER_DOT=(50.000 50.000 50.000 50.000 37.500 37.500 28.000 28.000 17.500)

for file in *py
do
    totalCount=$(( $totalCount + 1 ))
    flag=true
    for i in {0..8}
    do
        out=$(printf "'${AGE_TEST[$i]}'\n'${EXP_TEST[$i]}'\n" | python $file)
        if ! [[ "$out" == *"${ANSWER[i]}"* || "$out" == *""${ANSWER_COMMA[i]}""* || "$out" == *""${ANSWER_DOT[i]}""* ]]; then
            flag=false
            break;
        fi
    done
    if [ $flag == true ]; then
        echo ${file::-3}  >> result/success.txt
        perfectAnswersCount=$(( $perfectAnswersCount + 1 ))
    else
        echo ${file::-3}  >> result/failed.txt
    fi
done

echo Total answers: $totalCount
echo Perfect answers: $perfectAnswersCount
# Perfect answer: covers all cases required