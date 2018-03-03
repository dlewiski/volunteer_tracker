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

  def volunteers
    volunteers = []
    located_volunteers = DB.exec("SELECT * FROM volunteers;")
    located_volunteers.each do |volunteer|
      id = volunteer.fetch("id").to_i
      name = volunteer.fetch("name")
      project_id = volunteer.fetch('project_id').to_i
      if project_id.==self.id
        volunteers.push(Volunteer.new({:id => id, :name => name, :project_id => project_id}))
      end
    end
  return volunteers
  end

  def update (project)
    @title = project[:title]
    DB.exec("UPDATE projects SET title = ('#{@title}') WHERE id = ('#{@id}');")
  end
end
