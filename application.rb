require_relative 'lib/translations'
require_relative 'lib/translation'
require 'sinatra'
require 'sinatra/reloader' if development?

also_reload 'lib/translations'

configure do
    set :en_ru_translations, Translations.init_from_en_ru_file
    set :ru_en_translations, Translations.init_from_ru_en_file
    set :en_word_or_phrase, ''
    set :ru_word_or_phrase, ''
end

get '/' do
    @en_ru_translations = settings.en_ru_translations
    erb :enru
end

post '/' do
    settings.en_word_or_phrase = params["en_word_or_phrase"]
    redirect to(params["select"])
end

get '/word/en' do
    puts settings.en_word_or_phrase.to_s.strip
    @translation_with_synonyms = settings.en_ru_translations.print_translation_with_synonyms(settings.en_word_or_phrase.to_s.strip)
    @translation_with_synonyms = @translation_with_synonyms.force_encoding(Encoding::UTF_8)
    erb :en_word
end

get '/letter/en' do
    @en_words_by_letter = settings.en_ru_translations.print_words_starts_with_letter(settings.en_word_or_phrase.to_s.strip)
    @en_words_by_letter = @en_words_by_letter.map{|word| word.force_encoding(Encoding::UTF_8)}
    erb :en_words
end

get '/phrase/en' do
    @en_phrase = settings.en_ru_translations.print_words_translation(settings.en_word_or_phrase.to_s.strip)
    @en_phrase = @en_phrase.force_encoding(Encoding::UTF_8)
    erb :en_phrase
end

get '/ruen' do
    @ru_en_translations = settings.ru_en_translations
    erb :ruen
end

post '/ruen' do
    settings.ru_word_or_phrase = params["ru_word_or_phrase"]
    redirect to(params["ru_select"])
end

get '/word/ru' do
    @ru_translation_with_synonyms = settings.ru_en_translations.print_translation_with_synonyms(settings.ru_word_or_phrase.to_s.strip)
    @ru_translation_with_synonyms = @ru_translation_with_synonyms.force_encoding(Encoding::UTF_8)
    erb :ru_word
end

get '/letter/ru' do
    @ru_words_by_letter = settings.ru_en_translations.print_words_starts_with_letter(settings.ru_word_or_phrase.to_s.strip)
    @ru_words_by_letter = @ru_words_by_letter.map{|word| word.force_encoding(Encoding::UTF_8)}
    erb :ru_words
end

get '/phrase/ru' do
    @ru_phrase = settings.ru_en_translations.print_words_translation(settings.ru_word_or_phrase.to_s.strip)
    @ru_phrase = @ru_phrase.force_encoding(Encoding::UTF_8)
    erb :ru_phrase
end
