require 'csv'
require 'active_support/all'

# translation discription
class Translation
  attr_reader :word, :translation, :synonyms
  def initialize(word, translation, synonyms)
    @word = word.mb_chars
    @translation = translation.mb_chars
    @synonyms = synonyms.mb_chars
  end

  def to_s
    if @synonyms.empty?
      "Word: #{word}, Translation: #{translation}"
    else
      "Word: #{word}, Translation: #{translation}, Synonyms: #{synonyms}"
    end
  end
end