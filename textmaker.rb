#!/usr/bin/ruby
# coding: utf-8
#
# == NAME
# rssmaker.rb
#
# == USAGE
# Call this from generator.rb.
#
# == DESCRIPTION
# Generates text to later be used online.
# 
# == AUTHOR
# Douglas Perkins - https://dperkins.org

# Makes the details file for a given list of Kanji.
class Rssmaker
	# Makes the literal string.
	def make_literal literal
		s = literal
		return s
	end

	# Makes the stroke count string.
	def make_stroke_count stroke_count
		s = "✍" + stroke_count
		return s
	end

	# Makes the grade string.
	def make_grade grade
		if grade >= 1 and grade <= 6
			s = '小' + grade.to_s
		elsif grade == 8
			s = '中学'
		else
			s = ''
		end

		return s
	end

	# Makes the meanings string.
	def make_meanings meanings
		if meanings.size == 0
			return ''
		end

		s = ''
		
		meanings.each do |meaning|
			s += meaning + ', '
		end

		s.chomp! ', '
		return s
	end

	# Makes the onyomi readings string.
	def make_onyomis readings
		if readings.size == 0
			return ''
		end

		s = ''

		readings.each do |reading|
			s += reading + '　'
		end

		s.chomp! '　'
		return s
	end

	# Makes the kunyomi readings string.
	def make_kunyomis readings
		if readings.size == 0
			return ''
		end

		s = ''

		readings.each do |reading|
			s += reading + '　'
		end

		s.chomp! '　'
		return s
	end

	# Makes the examples string.
	def make_examples examples
		s = ''

		examples.each do |example|
			word = example.word
			kana = example.kana
			meaning = example.meaning

			s += word + ' &nbsp; (' + kana + ') &nbsp; &mdash; &nbsp; ' + meaning
			s += '<br />'
		end

		s.chomp! '<br />'
		return s
	end

	# Makes the text for a card.
	def make_card kanji
		# Separates the front and back of the card.
		splitter = "\t"

		# The order of these lines is important.
		# If they are changed, care must be taken upon import.

		card = make_literal kanji.literal
		card += splitter
		card += make_stroke_count kanji.stroke_count
		card += splitter
		card += make_grade kanji.grade
		card += splitter
		card += make_meanings kanji.meanings
		card += splitter
		card += make_onyomis kanji.onyomis
		card += splitter
		card += make_kunyomis kanji.kunyomis
		card += splitter
		card += make_examples kanji.examples

		card += "\n"

		return card
	end

	# Makes the details string stores it as @details.
	def make_details kanjilist
		details = ""

		kanjilist.each do |kanji|
			details += make_card kanji
		end

		@details = details
	end

	def initialize kanjilist
		puts 'Making the details ...'
		make_details kanjilist
	end

	# Writes the contents of @details to a text file.
	def write_details
		file = 'rss.txt'
		path = Script_dir + '/' + file
		puts 'Writing the details to ' + file + '...'

		open(path, 'w') do |f|
			f.puts @details
		end		

		puts 'Done writing.'
	end
end
