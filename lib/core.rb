require_relative 'translations'
require 'active_support/all'

# manage of application
class Core
  def run
    puts
    puts 'Task 2.2.6 Medvedev Nikita IT-41'
    puts
    translations = Translations.new
    menu_response_process(translations)
  end

  def menu_response_process(translations)
    show_menu
    mode_number = gets.strip
    case mode_number
    when /^1/
      translations.clear
      translations.read_from_csv_file('../data/ru_en_translations.csv')
      sub_menu(translations, '(RU_EN mode):')
    when /^2/
      translations.clear
      translations.read_from_csv_file('../data/en_ru_translations.csv')
      sub_menu(translations, '(EN_RU mode):')
    else
      puts
    end
  end

  def show_menu
    puts 'Select the mode of operation:'
    puts '1) Russian-English translator'
    puts '2) English-Russian translator'
    print '>'
  end

  def sub_menu(translations, mode)
    show_sub_menu(mode)
    mode_number = gets.strip
    case mode_number
    when /^1/
      word_translation(translations, mode)
    when /^2/
      words_into_letter(translations, mode)
    when /^3/
      words_translation(translations, mode)
    when /^m/
      menu_response_process(translations)
    else
      puts
    end
  end

  def show_sub_menu(mode)
    puts 'Select the desired function ' + mode
    puts '1) Display translation of word with synonyms'
    puts '2) Display list of words with translation into given letter'
    puts '3) Display the translation of the sequence of words'
    puts 'm) Return to the mode selection menu'
  end

  def word_translation(translations, mode)
    puts 'Enter word for translation:'
    print '>'
    word = gets.strip.encode!('utf-8')
    translations.print_translation_with_synonyms(word)
    puts "Enter 'm' to show menu"
    sub_menu(translations, mode) if gets.strip == 'm'
  end

  def words_into_letter(translations, mode)
    puts 'Enter letter for search words:'
    print '>'
    letter = gets.strip.encode!('utf-8')
    translations.print_words_starts_with_letter(letter)
    puts "Enter 'm' to show menu"
    sub_menu(translations, mode) if gets.strip == 'm'
  end

  def words_translation(translations, mode)
    puts 'Enter words for translation:'
    print '>'
    words = gets.strip.encode!('utf-8')
    translations.print_words_translation(words)
    puts "Enter 'm' to show menu"
    sub_menu(translations, mode) if gets.strip == 'm'
  end
end
