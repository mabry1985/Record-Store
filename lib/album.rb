class Album
  attr_reader :id
  attr_accessor :name
  attr_accessor :artist
  attr_accessor :genre
  @@albums = {}
  @@sold = {}
  @@total_rows = 0

  def initialize(name, id, artist, genre)
    @name = name
    @artist = artist
    @genre = genre
    @id = id || @@total_rows += 1
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def save
    @@albums[self.id] = Album.new(self.name, self.id, self.genre, self.artist)
  end

  def self.all()
    @@albums.values()
  end

  def self.sold()
    @@sold.values()
  end

  def self.search(input)
    @search_array = []
    @@albums.each_value do |value|
      if value.name.match?(input)
        @search_array.push(value)
      elsif value.artist.match?(input)
        @search_array.push(value)
      elsif value.genre.match?(input)
        @search_array.push(value)
      end
    end
    return @search_array
  end

  def self.clear
    @@albums = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@albums[id]
  end

  def update(name, artist, genre)
    self.name = name
    self.artist = artist
    self.genre = genre
    @@albums[self.id] = Album.new(self.name, self.id, self.artist, self.genre)
  end

  def delete
    @@albums.delete(self.id)
  end

  def buy
    @@sold[self.id] = Album.new(self.name, self.id, self.artist, self.genre)
    @@albums.delete(self.id)
  end
end
