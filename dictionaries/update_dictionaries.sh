#!/bin/sh

# Get the kanji dictionary.
rm -f kanjidic2.xml
wget http://www.edrdg.org/kanjidic/kanjidic2.xml.gz
gunzip kanjidic2.xml.gz

# Get the word dictionary.
rm -f edict.txt
wget http://ftp.edrdg.org/pub/Nihongo/edict.gz
gunzip edict.gz
iconv -f EUC-JP -t UTF-8 edict > edict.txt
rm edict

# Get the word frequency file.
rm -f distribution.txt
wget ftp://ftp.edrdg.org/pub/Nihongo/edict_dupefree_freq_distribution.gz
gunzip edict_dupefree_freq_distribution.gz
mv edict_dupefree_freq_distribution distribution.txt
