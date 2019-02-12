#!/bin/sh

# Get the kanji dictionary.
echo "Getting kanji dictionary..."
wget http://www.edrdg.org/kanjidic/kanjidic2.xml.gz && \
rm kanjidic2.xml && \
gunzip kanjidic2.xml.gz

# Get the word dictionary.
echo "Getting word dictionary..."
wget http://ftp.monash.edu.au/pub/nihongo/edict.zip && \
rm edict.txt && \
unzip edict.zip && \
iconv -f EUC-JP -t UTF-8 edict > edict.txt && \
rm edict edict.zip edict_doc.html edict.jdx

# Get the word frequency file.
echo "Getting word frequency file..."
wget ftp://ftp.edrdg.org/pub/Nihongo/edict_dupefree_freq_distribution.gz && \
rm distribution.txt && \
gunzip edict_dupefree_freq_distribution.gz && \
mv edict_dupefree_freq_distribution distribution.txt
