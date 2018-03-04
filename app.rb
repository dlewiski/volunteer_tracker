require 'sinatra'
require 'sinatra/reloader'
require 'pry'
also_reload('lib/**/*.rb')
require './lib/project'
require './lib/volunteer'
require 'pg'

DB = PG.connect({:dbname => 'project'})

get('/') do
  @projects = Project.all
  erb(:index)
end

post('/') do
  new_project = Project.new({:title => params["title"]})
  new_project.save
  @projects = Project.all
  erb(:index)
end

get('/project/:id') do
  @project = Project.find(params['id'].to_i)
  @volunteers = Volunteer.all
  erb(:projects)
end

get('/project/:id/edit') do
  @project = Project.find(params['id'].to_i)
  @volunteers = Volunteer.all
  erb(:edit_project)
end

get('/volunteer/:id') do
  @volunteer = Volunteer.find(params['id'].to_i)
  erb(:volunteers)
end

post('/project/:id/volunteer') do
  @project = Project.find(params['id'].to_i)
  volunteer = Volunteer.new({:name => params['name'], :project_id => params['id'].to_i})
  volunteer.save
  @volunteers = Volunteer.all
  erb(:projects )
end

patch('/project/:id') do
  @project = Project.find(params['id'].to_i)
  new_title = params['title']
  @project.update({:title => new_title, :id => @project.id})
  @volunteers = Volunteer.all
  erb(:projects )
end

post('/project/:id') do
  volunteer = Volunteer.find(params['volunteer_id'].to_i)
  @project = Project.find(params['id'].to_i)
  new_name = params['name']
  volunteer.update({:name => new_name, :project_id => @project.id, :id => volunteer.id})
  @volunteers = Volunteer.all
  erb(:projects )
end

delete('/delete/:id/project') do
  project = Project.find(params['id'].to_i)
  project.delete
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:index)
end
