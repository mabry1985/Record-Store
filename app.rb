require('sinatra')
require('sinatra/reloader')
require('./lib/song')
require('./lib/album')
require('pry')
also_reload('lib/**/*.rb')

get ('/') do
  @albums = Album.all
  @albums_sold = Album.sold
  erb(:albums)
end

get ('/albums') do
  if params[:search] == nil
    @albums = Album.all
    @albums_sold = Album.sold
    erb(:albums)
  else
    @albums = Album.search(params[:search])
    erb(:search_results)
  end
end

get ('/albums/new') do
  erb(:new_album)
end

post ('/albums') do
  name = params[:album_name]
  artist = params[:artist]
  genre = params[:genre]
  album = Album.new(name, nil, genre, artist)
  album.save()
  @albums = Album.all() # Adding this line will fix the error.
  @albums_sold = Album.sold
  erb(:albums)
end

get ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end


get ('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

get ('/albums/:id/purchase') do
  @album = Album.find(params[:id].to_i())
  @album.buy
  @albums = Album.all
  @albums_sold = Album.sold
  erb(:albums)
end

patch ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:name],params[:artist],params[:genre])
  @albums = Album.all
  @albums_sold = Album.sold
  erb(:albums)
end

delete ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  @albums_sold = Album.sold
  erb(:albums)
end
# Get the detail for a specific song such as lyrics and songwriters.
get ('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

# Post a new song. After the song is added, Sinatra will route to the view for the album the song belongs to.
post ('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  song = Song.new(params[:song_name], @album.id, nil)
  song.save()
  erb(:album)
end

# Edit a song and then route back to the album view.
patch ('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:name], @album.id)
  erb(:album)
end

# Delete a song and then route back to the album view.
delete ('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end
