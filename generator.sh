#!/bin/sh

# Generates the details files for each elementary school grade,
# elementary school combined, and junior high school.

for file in elementary.1.txt elementary.2.txt elementary.3.txt elementary.4.txt elementary.5.txt elementary.6.txt elementary.txt jhs.txt joyo.txt jlpt.n5.txt jlpt.n4.txt jlpt.n3.txt jlpt.n2.txt jlpt.n1.txt
do
	echo "Making details for ${file} ..."
	cp lists/${file} targetkanji.txt
	ruby generator.rb
	cp rss.txt rss/${file}
done
