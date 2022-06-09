#!/bin/bash

touch crew3-100
GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'
YELLOW=$'\e[0;33m'
CYAN=$'\e[0;36m'

echo "**********${GREEN} Ships Report ${NC}**********"


  echo "**********${YELLOW} ships that appeared in Return of the Jedi ${NC}**********"
  curl -s https://swapi.dev/api/starships/ | jq -r .results[].name


  echo "**********${CYAN} ships that have a hyperdrive rating >= 1.0 ${NC}**********"

  curl -s https://swapi.dev/api/starships/ | jq -r 'select(.results[0].hyperdrive_rating >=1 )| .results[].name'


  echo "**********${GREEN} ships that have crews between 3 and 100  ${NC}***********"

   curl -s https://swapi.dev/api/starships/ |jq -r '.results[] | "\(.crew)|\(.name)" ' > Crew


   while read line
   do
    crewcount=$(echo $line | awk -F "|" '{print $1}')
    shipname=$(echo $line | awk -F "|" '{print $2}')


    if [[ "$crewcount" = *"-"* ]]; then
     CrewNumber=$(echo $crewcount | awk -F "-" '{print $2}')

       if [[ $CrewNumber -gt 3 && $CrewNumber -lt 100 ]];then
               echo $shipname >> crew3-100
       fi
    elif [[ "$crewcount" = *","* ]]; then
      CrewNumber=$(echo $crewcount | sed 's/,//g')
       if [[ $CrewNumber -gt 3 && $CrewNumber -lt 100 ]];then
           echo $shipname >> crew3-100
       fi
    else
       if [[ $crewcount -gt 3 && $crewcount -lt 100 ]];then
         echo $shipname >> crew3-100
       fi
    fi
   done < Crew

 cat  crew3-100
 rm  crew3-100