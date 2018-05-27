class ListDirectory
  def initialize(connection)
    @links= Dir["#{connection}"]
  end

  def links_list
      @links.each do |liaison|
      "#{liaison}"
    end.join(" ")
  end

end
