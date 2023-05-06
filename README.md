KanjiOfTheDay
=============

A script to produce a piece of HTML showing kanji of the day and some information about it.


Objective
=========

This project is a script that takes a list of kanji as input and outputs a file that can be used to generate a bit of HTML for a "kanji of the day" setup in an RSS feed or blog post.

Kanji are Japanese characters.  There are several thousand in existence.  If you want to learn them, you should study in many ways.  A daily script such as this is a tool to buttress whatever other study methods you already have.  If you're already doing reading practice, it's sometimes helpful to focus on a single character and see some common words that make use of the the character.

Some other websites already offer kanji of the day.  I've used [Yookoso](http://www.yookoso.com/study/) happily in the past.  It offers much the same kind of thing as can be found here, along with many other useful study tools.  On the other hand, you can't play around with third party websites.  You don't get to decide what the information looks like, and if you dislike the formatting, tough luck.  And if someone else's site goes down, you can't fix it.  This project is designed to give you an extra level of control.

To see this code in action, visit <https://kotd.dperkins.org/>.  You can use those feeds for your own purposes, if you like.  Or, as mentioned above, you can deploy your own instance and customize it as you like.


Screenshots
===========

See `screenshots/` if you are interested in them.


Installation
============

Ruby is required. Version 3.1.2 or newer should work.

Download the source code into a directory of your choosing.


Getting Going
=============

Run `dictionaries/update_dictionaries.sh` to get the required dictionary files.  Some of the dictionary files are Creative Commons Attribution-Share Alike 3.0 licensed, so they aren't bundled here.

Next, run `generator.sh`. This could take a minute or two. It compiles all of the dictionaries, kanji, and examples into quickly-usable text files.

The above two scripts only need to be run on first installation or when you want to update the backend data.


Regular Use
===========

Daily action occurs in `web`.

Run `random.rb`. This creates or updates each RSS feed. If you don't want to generate all of the available feeds, edit the file accordingly. To make a kanji of the day, make a cronjob.

```
@daily /usr/bin/ruby /path/to/script/random.rb
```

After running that for a few days to make sure it works, disable the output.

```
@daily /usr/bin/ruby /path/to/script/random.rb > /dev/null
```


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

* GitHub: <https://github.com/dper/kanjioftheday/>.


Contact
=======

If you want to contact the author, here are some ways.  Bug reports and improvements are always welcome.

* <https://dperkins.org/>


Sources
=======

This code was based on [kanjiforanki](https://github.com/dper/kanjiforanki), a 2011 project to create paper flashcards. These days, I would generally recommend using Anki or some other kind of spaced repetition system instead of physical flashcards.

The school-based kanji lists themselves are published by the Ministry of Education (MEXT) in Japan.  Other websites copy and paste the data from official MEXT documents.

* <http://www.mext.go.jp/a_menu/shotou/new-cs/youryou/syo/koku/001.htm>.  Elementary school kanji.
* <http://www.imabi.net/joyokanjilist.htm>.  Elementary and junior high school kanji.

The JLPT kanji lists are based on those from the old official JLPT documentation.

The dictionaries are available from their original sources.

* <http://nihongo.monash.edu/japanese.html>


Contributions
=============

Thanks to **jfsantos** for the regular expressions that remove hiragana and katakana.
