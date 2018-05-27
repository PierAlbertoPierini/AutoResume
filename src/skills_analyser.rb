class SkillsAnalyser
  def initialize(text)
    @skills = text.split(',')
  end

  def list_simple
    skill = filtered_skills.each do |frase|
      " #{frase}"
    end.join("\n")
    #"\n" + skill + "\n"
  end

  private

  def filtered_skills
      filtered_skills ||= @skills.sort
  end

end
