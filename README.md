KanjiOfTheDay
=============

A script to produce a piece of HTML showing kanji of the day and some information about it.


Objective
=========

This project is a script that takes a list of kanji as input and outputs a file that can be used to generate a bit of HTML for a "kanji of the day" setup in an RSS feed or blog post.

Kanji are Japanese characters.  There are several thousand in existence.  If you want to learn them, you should study in many ways.  A daily script such as this is a tool to buttress whatever other study methods you already have.  If you're already doing reading practice, it's sometimes helpful to focus on a single character and see some common words that make use of the the character.

Some other websites already offer kanji of the day.  I've used [Yookoso](http://www.yookoso.com/study/) happily in the past.  It offers much the same kind of thing as can be found here, along with many other useful study tools.  On the other hand, you can't play around with third party websites.  You don't get to decide what the information looks like, and if you dislike the formatting, tough luck.  And if someone else's site goes down, you can't fix it.  This project is designed to give you an extra level of control.

To see this code in action, visit <https://kotd.dperkins.org/> or <https://c.im/@kanjioftheday>.  Use those feeds or deploy and customize your own instance.


Installation
============

Download the source code into a directory of your choosing.

Ruby is required. Version 3.1.2 or newer should work.

If you want to post to Mastodon, get [toot](https://github.com/ihabunek/toot) working with your target account.


Getting Going
=============

Run `dictionaries/update_dictionaries.sh` to get the required dictionary files.  Some of the dictionary files are Creative Commons Attribution-Share Alike 3.0 licensed, so they aren't bundled here.

Next, run `generator.sh`. This could take a minute or two. It compiles all of the dictionaries, kanji, and examples into quickly-usable text files.

The above two scripts only need to be run on first installation or when you want to update the backend data.


RSS
===

Run `web/random.rb`. This creates or updates each RSS feed. If you don't want to generate all of the available feeds, edit the file accordingly. To do this daily, make a cronjob.

    @daily /usr/bin/ruby /path/to/script/random.rb

Run that for a few days to make sure it works, and then disable the output.

    @daily /usr/bin/ruby /path/to/script/random.rb > /dev/null


Mastodon
========

Run `web/mastodon.rb`. This posts to the Mastodon account you've already configured in `toot`. To do this daily, make a cronjob.

    @daily /usr/bin/ruby /path/to/script/mastodon.sh

Run that for a few days to make sure it works, and then disable the output.

    @daily /usr/bin/ruby /path/to/script/random.rb > /dev/null


Details
=======

The script `generator.rb` looks for target kanji in the file `targetkanji.txt` and produces a tab-separated details file called `details.txt`.

The format of `details.txt` is a tab-delimited UTF-8 text file.  The tabs are, in order, as follows.

* Literal
* Strokes
* Grade
* Meanings
* Onyomis
* Kunyomis
* Examples

The examples can get quite long, so you probably wouldn't want to look at the details file itself unless trouble shooting.

This project comes with some lists of kanji in the `lists` directory.  You can copy and paste those onto `targetkanji.txt` as desired.  If you'd like to use a different set of kanji, modify `targetkanji.txt` by hand.  For convenience, the script `generator.sh` generates details files for all of the elementary and junior high school kanji lists and places the results in `web`.


Source
======

* <https://github.com/dper/kanjioftheday/>


Contact
=======

Suggestions and comments are always welcome.

* <https://dperkins.org/>


Sources
=======

This code was originally forked from [kanjiforanki](https://github.com/dper/kanjiforanki), a 2011 project to create paper flashcards.

The JLPT kanji lists are based on those from the old official JLPT documentation.

* <http://www.mext.go.jp/a_menu/shotou/new-cs/youryou/syo/koku/001.htm>.  Elementary school kanji.
* <http://www.imabi.net/joyokanjilist.htm>.  Elementary and junior high school kanji.
* <http://nihongo.monash.edu/japanese.html>. The dictionaries are available from their original sources.


Contributions
=============

Thanks to **jfsantos** for the regular expressions that remove hiragana and katakana.
