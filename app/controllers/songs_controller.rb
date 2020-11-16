class SongsController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_band, only: [:destroy]
  before_action :set_song, only: [:destroy]

  def index
    not_implemented
  end

  def destroy
    if @song.destroy
      activity = Activity.create!(band: @band, action: :song_deleted, starts_at: Time.now, ends_at: Time.now)

      @band.happenings.create(what: "#{@song.name} was thrown in the trash!", kind: 'trash', activity_id: activity.id)
      redirect_to band_path(@band), alert: "#{@song.name} was deleted."
    else
      redirect_to root_path, alert: 'Something went wrong.'
    end
  end

  private

  def set_band
    @band = begin
      current_manager.bands.find(params[:band_id])
    rescue StandardError
      nil
    end
    redirect_to root_path, alert: "You can't do that." if @band.nil?
  end

  def set_song
    @song = begin
      @band.songs.find(params[:id])
    rescue StandardError
      nil
    end
    authorize(@song)
    redirect_to root_path, alert: "You can't do that." if @song.nil?
  end
end
