require 'pry'

class MusicLibraryController
  extend Memorable::ClassMethods

  attr_accessor :music

  def initialize(path = "./db/mp3s")
    @music = MusicImporter.new(path)
    @music.import
  end

  def sorter
    @music.files.sort
  end

  def call
    puts "Welcome to your music library!"
    input = ""
    @sorted_songs = sorter
    while input != "exit"
      puts "To list all of your songs, enter 'list songs'."
      input = gets.strip
      case input
      when "list songs"
        list_songs
      when  "list artists"
        list_artists
      when "list genres"
        list_genres
      when "play song"
        play_song
      when "list artist"
         list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      end
    end
  end

  def list_songs
    @sorted_songs.each_with_index do|song, num|
      puts "#{num+1}. #{song}"
    end
  end

  def list_artists
    Artist.all.each do |artist|
      puts artist.name
    end
  end

  def list_genres
    Genre.all.each do |genre|
      puts genre.name
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    song_num = gets.chomp
    playing_song = @sorted_songs[song_num.to_i - 1]
    puts "Playing #{playing_song}"
  end

  def list_songs_by_artist
    array = @music.files.collect do |file|
      song = self.class.split_filename(file)
    end
    puts "What artist would you like to list songs for?"
    artist_input = gets.chomp
    artist = Artist.find_by_name(artist_input)
    array.each do |song|
      if song[0] == artist.name
        puts "#{song[0]} - #{song[1]} - #{song[2]}"
      end
    end
  end
  def list_songs

  end

  def list_song_by_genre
    array = @music.files.collect do |file|
      song = self.class.split_filename(file)
    end
    puts "What genre would you like to list songs for?"
    genre_input = gets.chomp
    genre = Genre.find_by_name(genre_input)
    array.each do |song|
      if song[2] == genre.name
        puts "#{song[0]} - #{song[1]} - #{song[2]}"
      end
    end
  end
end
