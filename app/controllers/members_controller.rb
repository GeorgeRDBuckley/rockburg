class MembersController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_member, only: [:destroy]
  before_action :set_band, only: [:destroy]

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  # idea - conform hire to 'create' convention
  def hire
    result = Band::HireMember.(band: params[:band_id], skill: params[:skill_id], member: params[:id])
    if result.success?
      redirect_to band_path(params[:band_id]), alert: "Member hired successfully."
    else
      redirect_to new_band_path, alert: result.message || "Error hiring member."
    end
  end

  def destroy
    if @member.destroy
      @band.happenings.create(what: "#{@member.name} was fired!", kind: 'fired')
      redirect_to band_path(@band), alert: "#{@member.name} was fired."
    else
      redirect_to root_path, alert: 'Something went wrong.'
    end
  end

  private

  def set_member
    @member = current_manager.members.find(params[:member_id]) rescue nil
    redirect_to root_path, alert: "You can't do that." if @member.nil?
  end

  def set_band
    @band = current_manager.bands.find(params[:band_id]) rescue nil
    redirect_to root_path, alert: "You can't do that." if @band.nil?
  end

end
