class Project

attr_accessor :title, :id

  def initialize(attributes)
    @title = attributes[:title]
    @id = attributes[:id]
  end

  def save
    var = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = var.first.fetch('id').to_i.to_int
  end

  def ==(other_project)
    (self.title().== (other_project.title()))
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i
      projects.push(Project.new({:title => title, :id => id}))
    end
    projects
  end

  def self.find(id)
    located_project = nil
    Project.all.each do |project|
      if project.id.==(id)
        located_project = project
      end
    end
    return located_project
  end
end
