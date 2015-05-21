#!/bin/sh

# Get the word dictionary.
rm edict.txt
wget http://ftp.monash.edu.au/pub/nihongo/edict.zip
unzip edict.zip
iconv -f EUC-JP -t UTF-8 edict > edict.txt
rm edict edict.zip edict_doc.html edict.jdx
