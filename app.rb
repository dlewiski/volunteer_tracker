require 'sinatra'
require 'sinatra/reloader'
require 'pry'
also_reload('lib/**/*.rb')
require './lib/word_definer'

get('/') do
  @first_words = Word.new
  @first_words.add_word("happy")
  erb(:word_list)
end

post('/') do
  @first_words = Word.new
  word = params["word"]
  @first_words.add_word(word)
  erb(:word_list)
end
