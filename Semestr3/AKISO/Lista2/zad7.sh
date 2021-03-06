#!/bin/bash

IFS=$'\n'
for f in $(find -type f); do
	mv -v "$f" "`echo $f | tr '[:upper:]' '[:lower:]'`"; done
