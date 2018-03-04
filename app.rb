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
  erb(:projects)
end

get('/project/:id/edit') do
  @project = Project.find(params['id'].to_i)
  erb(:edit_project)
end

patch('/project/:id') do
  @project = Project.find(params['id'].to_i)
  new_title = params['title']
  @project.update({:title => new_title, :id => @project.id})
  erb(:projects )
end
