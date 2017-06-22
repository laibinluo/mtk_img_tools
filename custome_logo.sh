#!/bin/bash

set -e 

echo $1 
echo $2
echo $0
echo $3

if [ $# != 3 ] ; then
   echo "USAGE: $0 <input_logofile> <input_bmpfile> <output_new_logofile>"
   echo "Example: $0 logo.bin logo.bmp logo_new.bin "
   echo  
   exit 1;
fi

 ./bmp_to_raw logo.raw $2

if [ $? -eq 0 ]
then
    echo "bmp_to_raw successful"
else
    echo "bmp file failed!"
    exit 1
fi

rm -rf *.rgb565
./unpack-MT8665.pl logo.bin

if [ $? -eq 0 ]
then
    echo "unpack-MT8665.pl successful"
else
    echo "logo.bin file failed!"
    exit 1
fi

rm -rf logo_new
mkdir -p logo_new

mv *.rgb565  logo_new/
cp logo.raw logo_new/logo.bin-raw[00].rgb565

./repack-MT8665.pl -logo logo_new/ $3



