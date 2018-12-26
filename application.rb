require_relative 'lib/translations'
require_relative 'lib/translation'
require 'sinatra'
require 'sinatra/reloader' if development?

also_reload 'lib/translations'

configure do
    set :en_ru_translations, Translations.init_from_en_ru_file
    set :ru_en_translations, Translations.init_from_ru_en_file
    set :en_word_or_phrase, ''
end

get '/' do
    @en_ru_translations = settings.en_ru_translations
    erb :enru
end

post '/' do
    settings.en_word_or_phrase = params["en_word_or_phrase"]
end

get '/word/en' do
    @translation_with_synonyms = settings.en_ru_translations.print_translation_with_synonyms(settings.en_word_or_phrase.to_s.strip)
    erb :en_word
end

get '/letter/en' do
    @en_words_by_letter = settings.en_ru_translations.print_words_starts_with_letter(settings.en_word_or_phrase.to_s.strip)
    erb :en_words
end

get '/phrase/en' do

    @en_phrase = settings.en_ru_translations.print_words_translation(settings.en_word_or_phrase.to_s.strip)
    erb :en_phrase
end

get '/ruen' do
    @ru_en_translations = settings.ru_en_translations
    erb :ruen
end
