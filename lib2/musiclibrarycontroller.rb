class MusicLibraryController

  extend Concerns::Findable
  
  def initialize(path = './db/mp3s')
    @path = path
    music_importer = MusicImporter.new(@path)
    @songs = music_importer.import
  end  

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts"To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    exit_value = ""
    while exit_value != "exit"
      user_input = gets.chomp
      if user_input == "list songs"
        list_songs
      elsif user_input == "list artists"
        list_artists
      elsif user_input == "list genres"
        list_genres
      elsif user_input == "list artist"
        list_artist
      elsif user_input == "list genre"
        list_genre
      elsif user_input == "play song"
        play_song
      elsif user_input == "exit"
        exit_value = user_input
      end
    end
  end
  
  def list_songs
    sorted_songs = @songs.sort{|song1, song2| song1.name <=> song2.name}
    i = 0
    while i < @songs.length
      artist_song = []
      i+=1
      song = sorted_songs[i-1]
      if song.genre.name == "hi-ho"
        song.genre.name = "hip-hop"
      end
      artist_song << ["#{song.artist.name}", "#{song.name}"]
      puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
    artist_song
  end
  
  def list_artists
    sorted_songs = @songs.sort{|song1, song2| song1.artist.name <=> song2.artist.name}
    i = 1
    sorted_songs.map{|song|
        artist = song.artist.name
        puts "#{i}. #{artist}".to_s
        i+=1
    }
  end
  
  def list_genres
    sorted_songs = @songs.sort{|song1, song2| song1.genre.name <=> song2.genre.name}
    i = 1
    sorted_songs.map{|song|
      if song.genre.name == "hi-ho"
        song.genre.name = "hip-hop"
      end
      genre = song.genre.name
      puts "#{i}. #{genre}".to_s
      i+=1
    }
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.chomp.to_s
    song_by_artist = @songs.find{|song| song.artist.name == user_input}
    if song_by_artist != nil
      artist = song_by_artist.artist
      songs_by_artist = @songs.select{|song| song.artist == artist}
      ordered_songs_by_artist = 
      i = 1
      songs_by_artist.collect{|song| 
        if song.genre.name == "hi-ho"
          song.genre.name = "hip-hop"
        end
        puts "#{i}. #{song.name} - #{song.genre.name}"
        i+=1
      }
    end
  end
  
  def list_artist
    list_songs_by_artist
  end
  
  def list_songs_by_genre
  end
  
  def list_genre
    list_songs_by_genre
  end
  
  def play_song
    puts "Which song number would you like to play?"
    plays = gets.chomp.to_i
    if plays >= 1 && plays < list_songs.count
      artist = list_songs[plays][0]
      song = list_songs[plays][1]
      puts "Playing #{song} by #{artist}"
    else
      "Invalid song selection."
    end
  end
  
end