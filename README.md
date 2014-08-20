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

Details
=======

There are two main steps.

1. Take a list of target kanji and make a details file.  This is done by placing the target kanji all on one line with no spaces in a file called `targetkanji.txt` and then running the `generator.rb` script.
2. Use the output of that file, which is temporarily called `details.txt` until you rename it by choosing one line at random and based on that line producing a kanji of the day code block.

The format of `details.txt` is a tab-delimited UTF-8 text file.  The tabs are, in order, as follows.

* Literal
* Strokes
* Grade
* Meanings
* Onyomis
* Kunyomis
* Examples

The examples can get quite long, so you probably wouldn't want to look at the file itself very much, but if you're running into unexpected behavior, it's work a look.  The left-most part of each line should be quite legible.

Issues
======

If you see any issues, obvious but missing features, or problems with the documentation, feel free to open an issue at <https://github.com/dper/KanjiForAnki/issues> or contact the author at <https://microca.st/dper>.

Sources
=======

Most of this code is pulled from kanjiforanki (<https://github.com/dper/kanjiforanki>).  That code was designed for flash cards, which are by nature small.  The HTML here is designed for regular web use and is not as constrained in size.  That project was based on a project I did in 2011 to make paper flash cards for elementary school kanji.  <https://dperkins.org/arc/2011-03-22.kanji%20flashcards.html>

The kanji lists themselves are published by the Ministry of Education (MEXT) in Japan.  Other websites copy and paste the data from official MEXT documents.

* <http://www.mext.go.jp/a_menu/shotou/new-cs/youryou/syo/koku/001.htm>.  Elementary school kanji.
* <http://www.imabi.net/joyokanjilist.htm>.  Elementary and junior high school kanji.

The word frequency list is public domain and is included with the source.

* <http://ftp.monash.edu.au/pub/nihongo/00INDEX.html>.
* <http://www.bcit-broadcast.com/monash/wordfreq.README>.
* <http://ftp.monash.edu.au/pub/nihongo/wordfreq_ck.gz>.  Retrieved 2014-01-24.

The kanji dictionary and Japanese word dictionary are available from their original sources.  The original sources aren't in Unicode, but you can and should check there for updates and make the conversions yourself using a web browser and some copy and pasting.

* <http://www.csse.monash.edu.au/~jwb/kanjidic2/>.
* <http://www.csse.monash.edu.au/~jwb/kanjidic2/kanjidic2.xml.gz>.
* <http://www.csse.monash.edu.au/~jwb/edict.html>.
* <http://ftp.monash.edu.au/pub/nihongo/edict.gz>.

Contributions
=============

Thanks to **jfsantos** for the regular expressions that remove hiragana and katakana.
