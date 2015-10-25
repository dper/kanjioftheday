KanjiOfTheDay
=============

A script to produce a piece of HTML showing kanji of the day and some information about it.


Objective
=========

This project is a script that takes a list of kanji as input and outputs a file that can be used to generate a bit of HTML for a "kanji of the day" setup in an RSS feed or blog post.

Kanji are Japanese characters.  There are several thousand in existence.  If you want to learn them, you should study in many ways.  A daily script such as this is a tool to buttress whatever other study methods you already have.  If you're already doing reading practice, it's sometimes helpful to focus on a single character and see some common words that make use of the the character.

Some other websites already offer kanji of the day.  I've used [Yookoso](http://www.yookoso.com/pages/study.php) happily in the past.  It offers much the same kind of thing as can be found here, along with many other useful study tools.  On the other hand, you can't play around with third party websites.  You don't get to decide what the information looks like, and if you dislike the formatting, tough luck.  And if someone else's site goes down, you can't fix it.  This project is designed to give you an extra level of control.

To see this code in action, visit <https://dperkins.org/kanjioftheday/feeds.html>.  You can use those feeds for your own purposes, if you like.  Or, as mentioned above, you can deploy your own instance and customize it as you like.


Screenshots
===========

See `screenshots/` if you are interested in them.


Installation
============

First of all, you need Ruby.  Version 1.9.2 or newer is sufficient.  Some dependencies are needed.  They are relatively large in size.  Run the `dictionaries/update_dictionaries.sh` script to get them.  Some of the dictionary files are Creative Commons Attribution-Share Alike 3.0 licensed.  Take care if you are redistributing them to observe this.


Starting Out
============

To begin with, look in the `web` directory.  The files there are ready to go.  The script `random.rb` updates each RSS feed specified in it.  Take a look at `random.rb` and modify it if you like.  Each time you call `random.rb`, you produce a new random kanji for each file specified in it.  So, to make a kanji of the day, just make a cronjob that runs the script daily.

```
@daily /usr/bin/ruby /path/to/script/random.rb
```

After running that for a few days to make sure it works, disable the output.

```
@daily /usr/bin/ruby /path/to/script/random.rb > /dev/null
```

If you're happy with how that works, you don't have to look at the rest of the project at all.


Details
=======

Once you have the above dependencies, use the script `generator.rb` to produce a details file.  The `generator.rb` script looks for target kanji in the file `targetkanji.txt` and produces a tab-separated details file called `details.txt`.

The format of `details.txt` is a tab-delimited UTF-8 text file.  The tabs are, in order, as follows.

* Literal
* Strokes
* Grade
* Meanings
* Onyomis
* Kunyomis
* Examples

The examples can get quite long, so you probably wouldn't want to look at the file itself very much, but if you're running into unexpected behavior, it's work a look.  The left-most part of each line should be quite legible.

This project comes with some lists of kanji in the `lists` directory.  You can copy and paste those onto `targetkanji.txt` as desired.  Or, if you'd like to use a different set of kanji, modify `targetkanji.txt` by hand.  For convenience, the script `generator.sh` generates details files for all of the elementary and junior high school kanji lists and places the resultant details files in `web`.


Source
======

* Browse: <https://dperkins.org/git/gitlist/kanjioftheday.git/>.
* Clone: <https://dperkins.org/git/public/kanjioftheday.git/>.
* GitHub: <https://github.com/dper/kanjioftheday/>.


Contact
=======

If you want to contact the author, here are some ways.  Bug reports and improvements are always welcome.

* <https://microca.st/dper>
* <https://twitter.com/dpp0>
* <https://dperkins.org/tag/contact.html>


Sources
=======

Most of this code is pulled from [kanjiforanki](https://github.com/dper/kanjiforanki).  That code was designed for flash cards, which are by nature small.  The HTML here is designed for regular web use and is not as constrained in size.  That project was based on a [project](https://dperkins.org/arc/2011-03-22.kanji%20flashcards.html) I did in 2011 to make paper flash cards for elementary school kanji.

The school-based kanji lists themselves are published by the Ministry of Education (MEXT) in Japan.  Other websites copy and paste the data from official MEXT documents.

* <http://www.mext.go.jp/a_menu/shotou/new-cs/youryou/syo/koku/001.htm>.  Elementary school kanji.
* <http://www.imabi.net/joyokanjilist.htm>.  Elementary and junior high school kanji.

The JLPT kanji lists are based on those from the old official JLPT documentation.  The current version of the test has no official list, though, so we are forced to do some guesswork.

* <https://dperkins.org/arc/2014-08-28.jlpt%20kanji.html>.  

The word frequency list, `wordfreq_ck.txt`, is public domain and is included with the source.

* <ftp://ftp.edrdg.org/pub/Nihongo/00INDEX.html>.
* <ftp://ftp.edrdg.org/pub/Nihongo/wordfreq.README>.
* <ftp://ftp.edrdg.org/pub/Nihongo/wordfreq_ck.gz>.  Retrieved 2014-01-24.

The kanji dictionary and Japanese word dictionary are available from their original sources.  The original sources aren't in Unicode, but you can and should check there for updates and make the conversions yourself using a web browser and some copy and pasting.

* <ftp://ftp.edrdg.org/pub/Nihongo/kanjidic2_ov.html>.
* <ftp://ftp.edrdg.org/pub/Nihongo/kanjidic2.xml.gz>.
* <ftp://ftp.edrdg.org/pub/Nihongo/edict_doc.html>.
* <ftp://ftp.edrdg.org/pub/Nihongo/edict.gz>.


Contributions
=============

Thanks to **jfsantos** for the regular expressions that remove hiragana and katakana.
