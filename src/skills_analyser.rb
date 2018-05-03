class SkillsAnalyser
  def initialize(text)
    @skills = text.split(',')
  end

  def list_simple
    skill = filtered_skills.each do |frase|
      "  #{frase}"
    end.join("\n")
    "\n" + skill + "\n"
  end

  #def list_wo_caption

  #end

  #def list_w_caption

  #end

  #def text_list
  #  list = words_occurrences.sort_by {|word, occs| occs}.reverse.map do |word, occs|
  #    "  #{word}: #{occs}"
  #  end.join("\n")
  #  "\n" + list + "\n"
  #end

  private

  def filtered_skills
      filtered_skills ||= @skills.sort
  end

end
