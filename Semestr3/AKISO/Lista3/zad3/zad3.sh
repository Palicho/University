#!/bin/bash

url="https://api.icndb.com"

echo $( curl -sS ${url}"/jokes/random/" | jq -r '.value.joke' )


url="https://api.thecatapi.com/v1/images/search"
myApiKey="65b22baa-441a-40ee-8ea3-abed36d69fc7"
fileName='pic.jpg'
urlPic=$( curl -sH  "X-Api-Key:${myApiKey}"  ${url} | jq -r '.[0].url' )

curl -sS ${urlPic} -o ${fileName} 
catimg ${fileName}

