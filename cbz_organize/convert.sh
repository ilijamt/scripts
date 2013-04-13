#!/bin/bash

if [ $# -ne 3 ]
then
  echo "Usage: `basename $0` {Title} {PositionX} {PositionY}"
  exit 65
fi

IFS="$(echo -e "\n\r")"
for vol in `ls *.zip`
do
   dir=${vol:$2:$3}
   rm "$dir" -rf
   echo "Uncompressing $vol to $dir";
   unzip -o -d "$dir" "$vol" > /dev/null
   echo "Creating new archive: $1.${dir}.zip"
   filelist=`find "$dir" -type f`
   echo "Moving chapters to the root folder"
   for file in $filelist
   do
     mv "$file" "$dir"
   done;
   cd "$dir"
   rm *.txt
   for file in `find * -type d`
   do 
     rm $file -rf
   done;
   zip -0 "../output/$1_${dir}.zip" * > /dev/null
   cd ..
   rm "$dir" -rf
   mv "$vol" converted
done;

