require 'translations'
require 'translation'

RSpec.describe Translations do
  describe '#read_from_csv_file' do
    it 'should read translations from correct file' do
      list = Translations.new
      translation = Translation.new('hello', 'zdrav', 'privet')
      file_name = 'non-existent'
      expect(CSV).to receive(:foreach).with(file_name, headers: true).and_return(translation)
      list.read_from_csv_file(file_name)
    end
  end

  describe '#collection operations' do
    before(:example) do
      @list = Translations.new
      @translation = Translation.new('bye', 'poka', '')
      @list.append(@translation)
    end

    it 'should add translation to translations list' do
      expect(@list.translations).to eq([@translation])
    end

    it 'should print translations to console' do
      allow($stdout).to receive(:puts)
      @list.each_to_print
    end

    it 'should clear translations list' do
      @list.clear
      expect(@list.translations.empty?).to eq(true)
    end

    it 'should return translation by index from translations list' do
      expect(@list.at(0)).to eq(@translation)
    end
  end

  describe '#to_s' do
    it 'should convert translation with synonyms to string' do
      bye_translation = Translation.new('hello', 'privet', 'zdrav')
      expect(bye_translation.to_s).to eq('Word: hello, Translation: privet, Synonyms: zdrav')
    end
  end

  describe '#print_translation_with_synonyms' do
    before(:example) do
      @list = Translations.new
      @bye_translation = Translation.new('bye', 'poka', '')
      allow($stdout).to receive(:puts)
      allow(@list).to receive(:print)
    end

    it 'should print translation without synonyms for preset word' do
      @list.append(@bye_translation)
      @list.print_translation_with_synonyms('bye')
      @list.clear
    end

    it 'should print translation with synonyms for preset word' do
      hello_translation = Translation.new('hello', 'privet', 'zdrav')
      @list.append(hello_translation)
      @list.print_translation_with_synonyms('hello')
    end

    it 'should print words that starts with preset letter' do
      @list.append(@bye_translation)
      @list.print_words_starts_with_letter('b')
    end

    it 'should print input words translations' do
      @list.append(@bye_translation)
      @list.print_words_translation('bye')
    end
  end
end
