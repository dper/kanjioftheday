#!/usr/bin/ruby
# coding: utf-8
#
# == NAME
# generator.rb
#
# == USAGE
# ./generator.rb
#
# == DESCRIPTION
# Takes a list of kanji as input and outputs a file that can be used to
# generate a kanji of the day entry.
# 
# == AUTHOR
# Douglas Perkins - https://dperkins.org

Script_dir = File.dirname(__FILE__)

require 'nokogiri'
require Script_dir + '/' + 'wordfreq'
require Script_dir + '/' + 'loader'
require Script_dir + '/' + 'rssmaker'

def make_details
	# Read all of the files and data.
	$edict = Edict.new
	$wordfreq = Wordfreq.new
	$styler = Styler.new
	$kanjidic = Kanjidic.new
	$targetkanji = Targetkanji.new

	# Make the RSS details.
	$rssmaker = Rssmaker.new($targetkanji.kanjilist)
	$rssmaker.write_details
end

make_details
