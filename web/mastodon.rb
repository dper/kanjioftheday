#!/usr/bin/ruby
# coding: utf-8
#
# == NAME
# mastodon.rb
#
# == USAGE
# ./mastodon.rb
#
# == DESCRIPTION
# Chooses a line at random from the details file specified below and
# posts on Mastodon with the results.
#
# == AUTHOR
# Douglas P Perkins - https://dperkins.org

Script_dir = File.dirname(__FILE__)

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

# Adjusts the details to be useful on Mastodon.
# As a part of this, HTML is changed to raw text.
class Styler
	# Styles the given line.
	def initialize (line)
		@line = line
		style_text
	end

	# Returns the literal.
	def get_literal
		literal = @line.split("\t")[0]
		literal = "Kanji: " + literal
		return literal
	end

	# Returns the stroke count.
	def get_strokes
		strokes = @line.split("\t")[1]
		strokes = "✍ " + strokes
		return strokes
	end

	# Returns the grade level, if specified.
	def get_grade
		grade = @line.split("\t")[2]
		grade = "🏫 " + grade
		return grade
	end

	# Returns the meaning or meanings -- one or more.
	def get_meanings
		meanings = @line.split("\t")[3]
		return meanings
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
		examples = @line.split("\t")[6]
		examples.gsub!('<br />', "\n")
		examples.gsub!('&nbsp;', " ")
		examples.gsub!('  &mdash;  ', "—")
		examples.gsub!('   ', ' ')
		return examples
	end

	# Makes a styled HTML block for embedding.
	def style_text
		text = get_literal + "\n\n"
		text += get_meanings + "\n\n"
		text += get_onyomis + "\n"
		text += get_kunyomis + "\n\n"
		text += get_examples + "\n\n"
		text += get_strokes + "\n"
		text += get_grade + "\n\n"
		text += "#kanji #japanese\n"
		text.gsub!("\n\n\n", "\n\n")
		@text = text	
	end

	def get_text
		return @text
	end
end

class Poster
	# Write to Mastodon.
	def mastodon(text)
		#TODO write file.
		command = 'toot post < mastodon.txt'
		puts text
		#TODO remove file.
	end

	# Post the file.
	def post(file)
		details = Details.new(file)
		styler = Styler.new(details.line)
		text = styler.get_text
		mastodon(text)
	end
end

# Writes the random kanji to Mastodon.
def post_many
	$poster = Poster.new
	#post_random("elementary.txt")
	$poster.post("joyo.txt")
end

post_many
