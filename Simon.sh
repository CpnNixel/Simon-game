#!/bin/bash
#./Simon.sh

clear	
echo "The rules are simple: "
echo ""
echo "Remember colors in order of their appearing"
echo ""
echo "User ARROW KEYS (UP, DOWN, RIGHT, LEFT) to input colors"
echo ""
read -n 1 -s -r -p "Press any key to Start:"
clear

#declare -ia user_nums #array
declare -i score=1
game_colors=""
user_colors=""

function levelup(){
score+=1
}


function FillArray(){
MAXCOUNT=99
count=0
while [ "$count" -le $MAXCOUNT ]; do
	numbers[$count]=$(( ( RANDOM % 4 )  + 1 ))
	let "count += 1"
done
######
echo "Total Elements:" ${#numbers[@]}
echo "First element:" ${numbers[0]}

echo "${numbers[*]}"
#####
}

FillArray

function GameRound(){
MAXCOUNT=`expr $1`
i=0
while [ "$i" -ne $MAXCOUNT ]; do
	if [[ ${numbers[$i]} = 1 ]];then 
		clear
		echo -e "\e[32mGreen"
		echo $i
		game_colors+="g"
		elif [[ ${numbers[$i]} = 2 ]];then
		clear
		echo -e "\e[31mRed"
		echo $i
		game_colors+="r"
		elif [[ ${numbers[$i]} = 3 ]];then
		clear
		echo -e "\e[33mYellow"
		echo $i
		game_colors+="y"
		elif [[ ${numbers[$i]} = 4 ]];then
		clear
		echo -e "\e[34mBlue"
		echo $i
		game_colors+="b"
	fi
	sleep 1.4
	let "i += 1"
	echo -e "\e[39m"
done
}

function TestInput(){
clear
echo -e "\t\e[32mGreen"
echo -e "\e[31mRed" "\t\t\e[33mYellow"
echo -e "\t\e[34mBlue"
counter=0
t=""
while [[ ${#user_colors} < ${#game_colors} ]]
do
    read -r -sn1 t
    case $t in
        A) echo -e "\e[32mGreen" 
		user_colors+="g"
		 counter+=1 ;;
        B) echo -e "\e[34mBlue" 
		user_colors+="b"
		 counter+=1 ;;
        C) echo -e "\e[33mYellow"
		user_colors+="y"
		 counter+=1 ;;
        D) echo -e "\e[31mRed"
		user_colors+="r"
		 counter+=1 ;;
		[qQ]) echo $user_colors
			  counter=0
			  ;;
    esac
done
echo " "
#echo -e "\e[39m$user_colors"
echo -e "\e[39mActual colors were: " "$game_colors"
}

function Judge(){
if [ "$game_colors" == "$user_colors" ]; then
	return 0
else
	return 1
fi
}


function GameInit(){

GameRound $1
echo $game_colors
TestInput

if Judge; then
	echo "win"
	game_colors=""
	user_colors=""
	levelup
	GameInit $score
else
	echo "You've lost"
	echo "SCORE" $score
	exit 0
fi
}

GameInit $score







