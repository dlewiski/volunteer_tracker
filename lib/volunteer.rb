require 'pry'

class Volunteer
  attr_accessor :name, :project_id, :id

  def initialize(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id]
    @id = attributes[:id]
  end

  def save
    var = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', '#{@project_id}') RETURNING id;")
    @id = var.first.fetch('id').to_i
  end

  def ==(new_volunteer)
   self.name.==(new_volunteer.name)
 end

 def project_id
   @project_id
 end
end
