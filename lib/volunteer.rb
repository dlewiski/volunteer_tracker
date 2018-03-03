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

 def self.all
   returned_volunteers = DB.exec("SELECT * FROM volunteers")
   volunteers = []
   returned_volunteers.each do |volunteer|
     name = volunteer.fetch('name')
     project_id = volunteer.fetch('project_id')
     id = volunteer.fetch('id')
     volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
   end
   volunteers
 end

 def self.find(id)
   located_volunteer = nil
   Volunteer.all.each do |volunteer|
     if volunteer.id.==(id)
       located_volunteer = volunteer
     end
   end
   located_volunteer
 end
end
