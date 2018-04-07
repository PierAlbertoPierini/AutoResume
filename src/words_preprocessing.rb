
# This class clean the text file give to it, live only the text.
class WordsPreprocessing
  # Match any character that is not in the set: Alphabetic characters	\p{Alpha} in Java syntax. /i = case insensitive
  WORDS_REGEX = /[^\p{Alpha}']/i
  # \s = Matches any whitespace character (space, tabs, line breaks). + = Match 1 or more of the preceding token.
  SPACE_REGEX = /\s+/
  # substitute the sets and create a new cleaned text file
  def self.to_words(text)
    text.gsub(WORDS_REGEX, ' ').gsub(SPACE_REGEX, ' ')
  end
end
