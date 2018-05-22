class ListDirectory
  def initialize(connection)
    @links= Dir["#{connection}"]
  end

  def links_list
    list = @links.each do |liaison|
      "#{liaison}"
    end.join(" ")
    list
  end

end
