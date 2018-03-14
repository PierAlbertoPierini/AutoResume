# File from http://rubywordcount.com/

class WordsOnlySanitizer
  # Allow for diacritics, hence p{Alpha} and not \w
  # We should not split words on apostrophes either
  WORDS_ONLY_REGEX = /[^\p{Alpha}']/i

  # We want to reduce all white space into a single space
  SPACE_ONLY_REGEX = /\s+/

  def self.to_words(text)
    text.gsub(WORDS_ONLY_REGEX, ' ').gsub(SPACE_ONLY_REGEX, ' ')
  end
end
