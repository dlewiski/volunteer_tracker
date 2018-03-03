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
  new_project = Project.new({:title => params["project"]})
  new_project.save
  @projects = Project.all
  erb(:index)
end
