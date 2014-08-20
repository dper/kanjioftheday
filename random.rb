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

require 'nokogiri'

Script_dir = File.dirname(__FILE__)
Details_file = Script_dir + '/details.txt'

# The entire details file.
class Details
	attr_accessor :line	# A random line from the details file.

	# Creates a Details.
	def initialize
		path = Script_dir + '/' + Details_file
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
	attr_accessor :output	# The styled output.

	# Styles the given line.
	def initialize (line)
		@line = line
		style_line
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
	def get_kinyomis
		return @line.split("\t")[5]
	end

	# Returns the example words and definitions.
	def get_examples
		return @line.split("\t")[6]
	end
		
	# Styles the line.
	def style_line
		text = "<html>\n"
		text += "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01//EN\">\n"
		text += "<head>\n"
		text += "<meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\" >\n"
		text += "</head>\n"
		text += "<body>\n"

		#TODO
		text += "Stuff!"

		text += "</body>\n"
		text += "</html>\n"

		@output = text

		puts @output
	end
end

def write_random
	# Read the files and data.
	$details = Details.new
	$styler = Styler.new $details.line

	# Write the output.
end

write_random
