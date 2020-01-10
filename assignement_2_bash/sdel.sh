#!/bin/bash

clear


cd ~
if [ ! -d TRASH ] 
then mkdir TRASH					       ##Creates trash directory if it doesn't exist
fi
cd -


find ~/TRASH -name *.tar.gz -type f -atime +2 -delete          ##Deletes any file in TRASH for more than 2 days!


for i in $@
do

if [ -f "$i" ] || [ -d "$i" ]
then

gzip -t $i 2>/dev/null

if [[ $? -eq 0 ]]

then
echo "File $i is compressed so it won't be compressed again"
mv $i ~/TRASH							 
								##Checks if compressed/not-compressed and moves the passed file to TRASH
else
echo "file $i isn't compressed so it will be compressed first"
tar czf $i.tar.gz $i
mv $i.tar.gz ~/TRASH
if [ -f "$i" ]
then
rm $i
elif [ -d "$i" ]
then
rm -r $i
fi
fi
else
echo "No such file or directory named $i"
fi

done





