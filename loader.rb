#!/usr/bin/ruby
# coding: utf-8
#
# == NAME
# loader.rb
#
# == USAGE
# This should be called from generator.rb.
#
# == DESCRIPTION
# Loads and manipulates kanji and sentence data.
#
# == AUTHOR
# Douglas Perkins - https://dperkins.org

require 'nokogiri'
require Script_dir + '/' + 'wordfreq'

# Fixes style quirks in Edict.
class Styler
	def initialize
		# For readability here, sort by lower case, then by initial
		# letter capitalized, then by all caps, then by phrases to
		# remove.
		@lookup_table = {
			'acknowledgement' => 'acknowledgment',
			'aeroplane' => 'airplane',
			'centre' => 'center',
			'colour' => 'color',
			'defence' => 'defense',
			'e.g. ' => 'e.g., ',
			'economising' => 'economizing',
			'electro-magnetic' => 'electromagnetic',
			'favourable' => 'favorable',
			'favourite' => 'favorite',
			'honour' => 'honor',
			'i.e. ' => 'i.e., ',
			'judgement' => 'judgment',
			'lakeshore' => 'lake shore',
			'metre' => 'meter',
			'neighbourhood' => 'neighborhood',
			'speciality' => 'specialty',
			'storeys' => 'stories',
			'theatre' => 'theater',
			'traveller' => 'traveler',
			'Ph.D' => 'PhD',
			'Philipines' => 'Philippines',
			'JUDGEMENT' => 'JUDGMENT',
			'(kokuji)' => 'kokuji',
			' (endeavour)' => '',
			' (labourer)' => '',
			' (theater, theater)' => '(theater)',
			' (theatre, theater)' => '(theater)',
		}
	end

	# Returns re-styled text.
	def fix_style text
		@lookup_table.keys.each do |key|
			text = text.sub(key, @lookup_table[key])
		end

		return text
	end
end

# Looks up words in Edict.
class Edict
	# Creates an Edict.  Parsing the edict file takes a long time,
	# so it is desirable to only make one of this.
	def initialize
		puts 'Parsing edict.txt ...'
		path = Script_dir + '/dictionaries/edict.txt'
		edict = IO.readlines path
		@lookup_table = {}
		
		edict.each do |line|
			# Lines with definitions start with the word, followed
			# by a blank line, followed by the definition.  If
			# there is more than one definition, the first one is
			# used.
			next unless line.include? " "
			word, blank, definition = line.partition " "
			next if @lookup_table.key? word
			@lookup_table[word] = definition
		end
	end

	# Looks up a word, returning its kana and definition.  Returns nil iff
	# the word is not in the dictionary.
	def define word
		# Definitions are stored in @lookup_table, which is indexed by
		# the words.  The definition starts with the reading in
		# parentheses, followed by one or more definitions, as well as
		# grammatical terms.  Only the first definition is used here.
		definition = @lookup_table[word]

		if not definition then return nil end

		kana = definition.partition('[')[2].partition(']')[0]

		meaning = definition.partition('/')[2]

		while meaning.start_with? '('
			meaning = meaning.partition(')')[2].lstrip
		end

		meaning = meaning.partition('/')[0]
		meaning = $styler.fix_style meaning
		return [kana, meaning]
	end
end

# An example word, written in kanji (plus kana), kana, and English.
class Example
	attr_accessor :word      # Word, using kanji and maybe kana.
	attr_accessor :kana      # Kana.
	attr_accessor :meaning   # English meaning.
	attr_accessor :frequency # Word frequency.

	# Creates an Example for a given word.
	def initialize (word, frequency)
		@word = word
		@frequency = Integer(frequency)
	end
	
	# Looks up the kana and English for the kanji word.
	# Returns true if the definition is found, and false otherwise.
	def lookup_definition
		definition = $edict.define @word
		if not definition then return false end
		@kana, meaning = definition
		meaning = $styler.fix_style meaning
		@meaning = meaning
		return true
	end
end

# A kanji character and all relevant details.
class Kanji
	attr_accessor :literal      # The character.
	attr_accessor :grade        # School grade level.
	attr_accessor :stroke_count # Stroke count.
	attr_accessor :meanings     # One or more meanings.
	attr_accessor :kunyomis     # Zero or more kunyomi readings.
	attr_accessor :onyomis	    # Zero or more onyomi readings.
	attr_accessor :examples     # Example list.

	Max_example_count = 10 # The maximum number of examples to store.
	Max_example_size = 75 # Max example width.

	# Look up examples of word use and record them.
	def lookup_examples
		@examples = []
		return unless $wordfreq.include? @literal
		$wordfreq.lookup(@literal).each do |pair|
			ex = Example.new(pair[0], pair[1])
		
			# Only keep examples that are in the dictionary.
			next unless ex.lookup_definition
			ex_size = (ex.word + ex.kana + ex.meaning).size
			next if ex_size > Max_example_size
			@examples << ex
			break if @examples.size == Max_example_count
		end
	end

	# Given a character node from nokogiri XML, creates a Kanji.
	def initialize (node)
		@literal = node.css('literal').text
		@grade = node.css('misc grade').text.to_i
		@stroke_count = node.css('misc stroke_count')[0].text

		rmgroup = node.css('reading_meaning rmgroup')

		# Parse the meanings.
		@meanings = []
		rmgroup.css('meaning').each do |meaning|
			if !meaning['m_lang']
				@meanings << ($styler.fix_style meaning.text)
			end
		end

		# Parse the readings.
		@onyomis = []
		@kunyomis = []
		rmgroup.css('reading').each do |reading|
			if reading['r_type'] == 'ja_on'
				@onyomis << reading.text
			elsif reading['r_type'] == 'ja_kun'
				@kunyomis << reading.text
			end
		end
		
		lookup_examples
	end
end

# Reader for kanjidic2.
class Kanjidic
	def initialize
		puts 'Parsing kanjidic2.xml ...'
		path = Script_dir + '/dictionaries/kanjidic2.xml'
		doc = Nokogiri::XML(open(path), nil, 'UTF-8')
		@characters = {}
		doc.xpath('kanjidic2/character').each do |node|
			character = node.css('literal').text
			@characters.store(character, node)
		end
		
		puts "Characters in kanjidic2: " + @characters.size.to_s + "."
	end

	# Returns a node for the specified characters.
	# If a character is not in the dictionary, it is skipped.
	def get_kanji characters
		kanjilist = []
		
		characters.each_char do |c|
			if @characters[c]
				kanjilist << Kanji.new(@characters[c])
			else
				puts "Character not found in kanjidic: " + c + "."
			end	
		end
		
		return kanjilist		
	end
end

# Reader for target kanji file.
class Targetkanji
	attr_accessor :kanjilist	# The target kanji.

	def lookup_characters characters
		@kanjilist = $kanjidic.get_kanji characters
		puts 'Found ' + @kanjilist.size.to_s + ' kanji in kanjidic.'
	end

	# Removes unwanted characters from the list.
	# This is a weak filter, but it catches the most obvious problems.
	def remove_unwanted_characters characters
		characters = characters.dup
		characters.gsub!(/[[:ascii:]]/, '')
		characters.gsub!(/[[:blank:]]/, '')
		characters.gsub!(/[[:cntrl:]]/, '')
		characters.gsub!(/[[:punct:]]/, '')
		characters.gsub!(/([\p{Hiragana}]+)/, '')
		characters.gsub!(/([\p{Katakana}]+)/, '')
		return characters	
	end

	def initialize
		puts 'Parsing targetkanji.txt ...'
		path = Script_dir + '/targetkanji.txt'
		characters = IO.read path
		characters = remove_unwanted_characters characters

		puts 'Target kanji count: ' + characters.size.to_s + '.'
		puts 'Target characters: ' + characters + '.'
		puts 'Looking up kanji ...'
		lookup_characters characters	
	end
end
