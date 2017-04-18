require 'sinatra'
require 'tiny_tds'

get '/' do
  @title = "Oh boy, this is an index page."
  erb :index
end

get '/about' do
  @title = "We are a team of people who took a class about databases."
  erb :about
end

get '/emptyDB' do
  @title = "That sure is an... empty database. Okay."
  erb :emptyDB
end

get '/tableMake' do
  @title = "Cookin' up some tables right quick."
  erb :tableMake
end

get '/populateDB' do
  @title = "What is a table but a container for tuples?"
  erb :populateDB
end

get '/union' do
  @title = "The union operation, in all its glory."
  erb :union
end

get '/intersection' do
  @title = "Intersection, but not of the traffic variety."
  erb :intersection
end

get '/difference' do
  @title = "Whether these lame titles annoy you makes no DIFFERENCE to me!"
  erb :difference
end

get '/division' do
  @title = "It is such a Joy to do Divison!"
  erb :division
end

get '/aggregation' do
  @title = "Aggregation is a hard word to spell. I know from experience."
  erb :aggregation
end

get '/innerJoin' do
  @title = "Inner join! Wow! Look at those graphics!"
  erb :innerJoin
end

get '/outerJoin' do
  @title = "Outer join! It is ALSO a join! Oh man!"
  erb :outerJoin
end
