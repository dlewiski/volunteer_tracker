class Project

attr_accessor :title, :id

  def initialize(attributes)
    @title = attributes[:title]
    @id = attributes[:id]
  end

  def save
    var = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = var.first.fetch('id').to_i
    binding.pry
  end
end
