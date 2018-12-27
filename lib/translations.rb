require 'csv'
require_relative 'translation'
require 'active_support/all'

# collection of translations
class Translations
  attr_reader :translations
  def initialize
    @translations = []
  end

  def self.init_from_en_ru_file
    translations = Translations.new
    translations.read_from_csv_file(File.expand_path('../data/en_ru_translations.csv', __dir__))
    translations
  end

  def self.init_from_ru_en_file
    translations = Translations.new
    translations.read_from_csv_file(File.expand_path('../data/ru_en_translations.csv', __dir__))
    translations
  end

  def each
    return enum_for(:each) unless block_given?
    @translations.each do |translation|
      yield translation
    end
  end

  def read_from_csv_file(filename)
    CSV.foreach(filename, headers: true) do |row|
      @translations << Translation.new(row['Word'], row['Translation'], row['Synonyms'])
    end
  end

  def append(translation)
    @translations << translation
  end

  def each_to_print
    @translations.each do |value|
      puts value.to_s
    end
  end

  def clear
    @translations.clear
  end

  def at(index)
    @translations[index]
  end

  def print_translation_with_synonyms(word)
    flag = false
    result = ''
    @translations.each do |value|
      next unless word.downcase == value.word
      
      result = 'Word: ' + value.translation.to_s + ' '
      if !value.synonyms.empty?
        result = result + 'Synonyms: ' + value.synonyms.to_s
      end
      flag = true
    end
    result = 'Unknown word' unless flag
    result
  end

  def print_words_starts_with_letter(letter)
    flag = false
    string_array = []
    @translations.each do |value|
      next unless value.word.slice(0..letter.size - 1) == letter.downcase

      string_array << 'Word: ' + value.word + ' Translation: ' + value.translation
      flag = true
    end
    string_array << 'No words for the given letter' unless flag
    string_array
  end

  def print_words_translation(words)
    words = words.split(' ')
    result = ''
    flag = false
    words.each do |word|
      flag = false
      @translations.each do |translation|
        if word.mb_chars.downcase == translation.word
          result = result + translation.translation + ' '
          flag = true
        end
      end
      result = result + ' Word "' + word + '" missing in the translation list' unless flag
    end
    result
  end
end
