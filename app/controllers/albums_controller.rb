class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.all
    gracenote = Gracenote.new({
      :clientID => "13347840",
      :clientTag => "D65E1D17F0A30742392E35C9717FA90E",
      :userID => "32185966555210305-3B5A796CF0A1B370B88F4258970932B7"
    })

    #result = gracenote.findTrack("Perfume", "GAME", "チョコレイト・ディスコ", '0').inspect
    # puts result
    # 1.アルバムを指定
    # 2.api実行

    #result = gracenote.findTrack("", "THE IDOLM@STER LIVE THE@TER COLLECTION Vol. 2 -765PRO ALLSTARS- [Disc 2]", "", '0') # .inspect
    ## THE IDOLM@STER LIVE THE@TER DREAMERS 02 がない問題
    ## LTA LTFはない
    # result = gracenote.findTrack("", "", "創造は始まりの風を連れて", '0') # .inspect
if false
    @albums.each do |album|
      album.songs.each do |song|
        unless song.tempo.blank?
          tempo_ids = []
          song.tempo.split(',').each do |m|
            tempo_ids = tempo_ids.push(Tempo.find_or_create_by(name: m).id)
          end
          song.tempos = Tempo.where(id: tempo_ids)
          song.save
        end
        unless song.mood.blank?
          mood_ids = []
          song.mood.split(',').each do |m|
            mood_ids = mood_ids.push(Mood.find_or_create_by(name: m).id)
          end
          song.moods = Mood.where(id: mood_ids)
          song.save
        end
      end
    end
end
if false
    # 3.アルバムのデータをsave
    # gn_id:string artist title release_date:date track_count:integer genre url
    album = Album.new
    album.gn_id = result[0][:album_gnid]
    album.artist = result[0][:album_artist_name]
    album.title = result[0][:album_title]
    album.release_date = result[0][:album_year]
    album.track_count = result[0][:tracks].count
    album.genre = result[0][:genre].map{ |g| g[:text] }.join(',')
    album.url = result[0][:album_art_url]
    album.save

    # 4.トラックのデータをsave
    # song = Song.new
    # gn_id:string album_id:integer artist title track_num:integer genre modo tempo
    result[0][:tracks].each do |track|
      song = Song.new
      song.gn_id = track[:track_gnid]
      song.album_id = album.id
      song.artist = track[:track_artist_name]
      song.title = track[:track_title]
      song.track_num = track[:track_number]
      mood_ids = []
      if track[:mood].present?
        track[:mood].each do |mood|
          mood_ids = mood_ids.push(Mood.find_or_create_by(name: mood).id)
        end
      end
      song.moods = Mood.where(id: mood_ids)
      tempo_ids = []
      if track[:tempo].present?
        track[:tempo].each do |tempo|
          tempo_ids = tempo_ids.push(Tempo.find_or_create_by(name: tempo).id)
        end
      end
      song.tempos = Tempo.where(id: song.tempo_ids)
      song.save
    end
end
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
  end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params)

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:gn_id, :artist, :title, :release_date, :track_count, :genre, :url)
    end
end
