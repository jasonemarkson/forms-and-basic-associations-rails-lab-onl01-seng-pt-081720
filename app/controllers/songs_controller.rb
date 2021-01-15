class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
  end

  def create
    # @song = Song.new(song_params)
    # @song.artist_name = params[:song][:artist_name]
    # @song.genre = params[:song][:genre_name]
    artist = Artist.find_or_create_by(name: song_params[:artist_name])
    note = Note.find_or_create_by(content: params[:song][:notes_content])
    @song = artist.songs.build(song_params)
    @song.notes << note.content
  

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name, :genre_id, :notes => [])
  end
end

