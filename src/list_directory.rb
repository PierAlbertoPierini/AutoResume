class ListDirectory
  def initialize(connection)
    @links= Dir["../#{connection}"]
  end

  def links_list
    list = links_splitted.each do |liaison|
      "#{liaison}"
    end.join(",")
    list
  end

  private

  def links_splitted
      links_splitted ||= @skills.split
  end

end
