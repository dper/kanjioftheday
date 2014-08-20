KanjiOfTheDay
=============

A script to produce a piece of HTML showing kanji of the day and some information about it

Objective
=========

This project is a script that takes a list of kanji as input and outputs a file that can be used to generate a bit of HTML for a "kanji of the day" setup in an RSS feed or blog post.

Kanji are Japanese characters.  There are several thousand in existence.  If you want to learn them, you should study in many ways.  A daily script such as this is a tool to buttress whatever other study methods you already have.  If you're already doing reading practice, it's sometimes helpful to focus on a single character and see some common words that make use of the the character.

Getting Dependencies
====================

This code is under the MIT License.  However, to make the script work, some more restrictive dependencies are needed.  Download the following files and put them in the same directory as this script.

The kanji dictionary and Japanese word dictionary are Creative Commons Attribution-Share Alike 3.0 licensed and can be downloaded here.

* <https://dperkins.org/2014/2014-01-24.kanjidic2.zip>
* <https://dperkins.org/2014/2014-01-24.edict.zip>

Or do this from the command line.

    wget https://dperkins.org/2014/2014-01-24.kanjidic2.zip
    wget https://dperkins.org/2014/2014-01-24.edict.zip
    unzip 2014-01-24.kanjidic2.zip
    unzip 2014-01-24.edict.zip

History
=======

Most of this code is pulled from kanjiforanki (<https://github.com/dper/kanjiforanki>).  That code was designed for flash cards, which are by nature small.  The HTML here is designed for regular web use and is not as constrained in size.
