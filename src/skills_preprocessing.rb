
# This class clean the text file give to it, live only the text.
class SkillsPreprocessing
  # \s = Matches any whitespace character (space, tabs, line breaks). + = Match 1 or more of the preceding token.
  SPACE_REGEX = /\s+/
  # substitute the sets and create a new cleaned text file
  def self.to_skills(text)
    text.gsub(SPACE_REGEX, ' ')
  end
end
