class MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  def index
    @meetings = Meeting.all
    respond_to do |format|
      format.html
      format.json do
        meetings = @meetings.map do |meeting|
          {
            id: meeting.id,
            title: "RDV avec #{meeting.project_manager.company_name}",
            start: meeting.start_time,
            end: meeting.end_time,
            url: meeting_path(meeting)
          }
        end
        render json: meetings
      end
    end
  end

  def show
  end

  def new
    @meeting = Meeting.new
  end

  def edit
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.industrial = current_user if current_user.industrial?
    @meeting.project_manager = current_user if current_user.project_manager?

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: 'Le rendez-vous a été créé avec succès.' }
        format.json { render json: @meeting, status: :created }
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Le rendez-vous a été mis à jour avec succès.' }
        format.json { render json: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Le rendez-vous a été supprimé.' }
      format.json { head :no_content }
    end
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:start_time, :end_time, :location, :notes, :meeting_type, :project_manager_id, :industrial_id)
  end
end
