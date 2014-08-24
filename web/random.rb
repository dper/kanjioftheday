#!/usr/bin/ruby
# coding: utf-8
#
# == NAME
# random.rb
#
# == USAGE
# ./random.rb
#
# == DESCRIPTION
# Chooses a line at random from the details file specified below and
# displays information about the kanji specified in that file.
# 
# This script depends on the details file being properly formatted.
# See the README for more information.
#
# == AUTHOR
#   Douglas P Perkins - https://dperkins.org - https://microca.st/dper

require 'date'
require 'rss'

Script_dir = File.dirname(__FILE__)
URL = "https://dperkins.org/kanjioftheday/"
Author = "Douglas Paul Perkins"

# The entire details file.
class Details
	attr_accessor :line	# A random line from the details file.
	

	# Creates a Details.
	def initialize (input)
		path = Script_dir + '/' + input
		details = IO.readlines path
		details.delete_if {|line| line.start_with? '#'}
		details.delete_if {|line| not line.include? "\t"}
		@details = details
		@line = random_line
	end

	# Returns a line at random.
	def random_line
		length = @details.length
		line = rand(length)
		return @details[line]
	end
end

class Styler
	attr_accessor :html	# Styled HTML output.
	attr_accessor :rss	# Styled Atom output.
	attr_accessor :output	# The output file.

	# Styles the given line.
	def initialize (line, output)
		@line = line
		@output = output
		style_core
		make_rss
	end

	# Returns the literal.
	def get_literal
		return @line.split("\t")[0]
	end

	# Returns the stroke count.
	def get_strokes
		return @line.split("\t")[1]
	end

	# Returns the grade level, if specified.
	def get_grade
		return @line.split("\t")[2]
	end

	# Returns the meaning or meanings -- one or more.
	def get_meanings
		return @line.split("\t")[3]
	end

	# Returns the onyomi -- zero or more.
	def get_onyomis
		return @line.split("\t")[4]
	end

	# Returns the kunyomis -- zero or more.
	def get_kunyomis
		return @line.split("\t")[5]
	end

	# Returns the example words and definitions.
	def get_examples
		return @line.split("\t")[6]
	end

	# Returns an attribution string.
	def get_attribution
		attribution = "This page was generated using <a href=\"https://github.com/dper/kanjioftheday/\">kanjioftheday</a>, written by Douglas Paul Perkins.  Kanji lists came from the Ministry of Education.  Example words are derived from a <a href=\"http://www.bcit-broadcast.com/monash/wordfreq.README\">word frequency list</a> by Alexandre Girardi.  Dictionary information is taken from <a href=\"http://www.csse.monash.edu.au/~jwb/kanjidic2/\">KANJIDIC2</a> and <a href=\"http://www.edrdg.org/jmdict/edict.html\">EDICT</a>."
		return attribution
	end

	# Returns the current date and time as a string in RFC3339 format.
	def get_date
		if RUBY_VERSION == '1.8.7'
			# For compatibility with Ruby 1.8.7.
			datetime = Time.now.strftime("%Y-%m-%dT%H:%M:%S")
			timezone = Time.now.strftime("%z")[0,3] + ':00'
			return datetime + timezone
		else
			# Ruby 1.9.3 and newer can use this.
			return DateTime.now.rfc3339
		end
	end

	# Makes a styled HTML block for embedding.
	def style_core
		core = "<center>\n"
		core += "<p style=\"font-size: 500%; color: blue;\">" + get_literal + "</p>\n"
		core += "<p style=\"color: #ff66ff;\">" + get_strokes + "</p>\n"
		core += "<p style=\"color: gray;\">" + get_grade + "</p>\n"
		core += "<p style=\"color: green;\">" + get_meanings + "</p>\n"
		core += "<p style=\"color: orange;\">" + get_onyomis + "</p>\n"
		core += "<p style=\"color: red;\">" + get_kunyomis + "</p>\n"
		core += "<p>" + get_examples + "</p>\n"
		core += "<p style=\"font-size: smaller; color: gray;\">" + get_attribution + "</p>\n"
		core += "</center>\n"
		@core = core	
	end

	# Makes the Atom text.
	def make_rss
		rss = RSS::Maker.make("2.0") do |maker|
			maker.channel.author = "Douglas Paul Perkins"
			maker.channel.updated = Time.now.to_s
			maker.channel.about = "https://github.com/dper/kanjioftheday/"
			maker.channel.title = "Kanji of the Day"
			maker.channel.link = URL
			maker.channel.description = "Kanji of the Day"

			maker.items.new_item do |item|
				item.link = URL + @output
				item.title = "Kanji of the Day: " + get_literal
				item.updated = Time.now.to_s
				item.description = @core
				item.guid.content = URL + @output + '#' + get_date
				item.guid.isPermaLink = false
			end
		end

		@rss = rss
	end

	# Writes the RSS text to a file.
	def write_rss
		puts 'Writing to ' + @output + ' ...'
		open(@output, 'w') do |file|
			file.puts @rss
		end
	end
end

# Writes the random kanji Atom feed for a file.
def write_random (input, output)
	$details = Details.new input
	$styler = Styler.new($details.line, output)
	$styler.write_rss
end

# Writes the random kanji Atom feeds for a bunch of files.
def write_many_random
	write_random("elementary.1.txt", "elementary.1.xml")
	write_random("elementary.2.txt", "elementary.2.xml")
	write_random("elementary.3.txt", "elementary.3.xml")
	write_random("elementary.4.txt", "elementary.4.xml")
	write_random("elementary.5.txt", "elementary.5.xml")
	write_random("elementary.6.txt", "elementary.6.xml")
	write_random("elementary.txt", "elementary.xml")
	write_random("jhs.txt", "jhs.xml")
	write_random("joyo.txt", "joyo.xml")
end

write_many_random
