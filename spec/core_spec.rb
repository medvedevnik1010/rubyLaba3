require 'core'
require 'translations'

RSpec.describe Core do
  describe '#run' do
    it 'should add translation to translations list' do
      allow($stdout).to receive(:puts)
      core = Core.new
      allow(core).to receive(:menu_response_process)
      core.run
    end
  end

  describe '#menu_response_process' do
    before(:example) do
      @core = Core.new
      allow($stdout).to receive(:puts)
      allow(@core).to receive(:print)
      @translations = Translations.new
      allow(@translations).to receive(:read_from_csv_file)
      allow(@core).to receive(:sub_menu)
    end

    it 'provides a choice of the RU_EN mode of the translator' do
      expect(@core).to receive(:gets).and_return('1')
      @core.menu_response_process(@translations)
    end

    it 'provides a choice of the EN_RU mode of the translator' do
      expect(@core).to receive(:gets).and_return('2')
      @core.menu_response_process(@translations)
    end

    it 'wrong input' do
      expect(@core).to receive(:gets).and_return('3')
      @core.menu_response_process(@translations)
    end
  end

  describe '#sub_menu' do
    before(:example) do
      @core = Core.new
      @translations = Translations.new
      allow($stdout).to receive(:puts)
      allow(@core).to receive(:word_translation)
      allow(@core).to receive(:words_into_letter)
      allow(@core).to receive(:words_translation)
      allow(@core).to receive(:menu_response_process)
    end

    it 'choice of word translation with synonyms operation' do
      expect(@core).to receive(:gets).and_return('1')
      @core.sub_menu(@translations, 'mode')
    end

    it 'choice of print words with translations by preset letter operation' do
      expect(@core).to receive(:gets).and_return('2')
      @core.sub_menu(@translations, 'mode')
    end

    it 'choice of print words translations by set of words operation' do
      expect(@core).to receive(:gets).and_return('3')
      @core.sub_menu(@translations, 'mode')
    end

    it 'choice of return to translator mode chooser menu operation' do
      expect(@core).to receive(:gets).and_return('m')
      @core.sub_menu(@translations, 'mode')
    end

    it 'wrong input' do
      expect(@core).to receive(:gets).and_return('5')
      @core.sub_menu(@translations, 'mode')
    end
  end

  describe '#processing program functions' do
    before(:example) do
      allow($stdout).to receive(:puts)
      @translations = Translations.new
      @core = Core.new
      allow(@core).to receive(:print)
      expect(@core).to receive(:gets).and_return('hello')
      expect(@core).to receive(:gets).and_return('not_m_string')
    end

    it 'processing of method execution of printing word translation with synonyms' do
      allow(@translations).to receive(:print_translation_with_synonyms)
      @core.word_translation(@translations, 'mode')
    end

    it 'processing of method execution of printing words with translations by letter' do
      allow(@translations).to receive(:print_words_starts_with_letter)
      @core.words_into_letter(@translations, 'mode')
    end

    it 'processing of method execution of printing words translations by set' do
      allow(@translations).to receive(:print_words_translation)
      @core.words_translation(@translations, 'mode')
    end
  end
end
