#!/bin/bash
mkdir -p migrations
cd migrations
filename="$(date +%s)_$1"
touch "$filename"_up.sql
touch "$filename"_down.sql
