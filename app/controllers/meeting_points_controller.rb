class MeetingPointsController < ApplicationController
  # GET /meeting_points
  # GET /meeting_points.json
  before_filter :authenticate_user!
  def index
    @lat    = 52.515803012883595
    @lng    = 13.376712799072266
    profile = Profile.where(:user_id => current_user.id).first
    unless profile.lat.nil?
      @lat = profile.lat
    end
    unless profile.lng.nil?
      @lng = profile.lng
    end

    @points         = Array.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meeting_points }
    end
  end

  def map_points
    @points         = Array.new
    args            = Hash.new
    args[:user_id]  = current_user.id
    args[:latmin]   = params[:latmin]
    args[:lngmin]   = params[:lngmin]
    args[:latmax]   = params[:latmax]
    args[:lngmax]   = params[:lngmax]

    @meeting_points = MeetingPoint.map_points_wo_own_profile(args)
    @meeting_points.each do |val|
      user = User.where(:id => val.profile.user_id).all
      username = Array.new
      user.each do |u|
        username << u.username
      end
      @points  << [ val.lng, val.lat, val.description, val.id, val.profile.user_id, username.first]
    end

    respond_to do |format|
      format.js { render :json => @points }
    end
  end
  # GET /meeting_points/1
  # GET /meeting_points/1.json
  def show
    @meeting_point = MeetingPoint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meeting_point }
    end
  end

  # GET /meeting_points/new
  # GET /meeting_points/new.json
  def new
    @lat    = 52.515803012883595
    @lng    = 13.376712799072266
    profile = Profile.where(:user_id => current_user.id).first
    unless profile.lat.nil?
      @lat = profile.lat
    end
    unless profile.lng.nil?
      @lng = profile.lng
    end

    @points         = Array.new
    @meeting_point = MeetingPoint.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meeting_point }
    end
  end

  # GET /meeting_points/1/edit
  def edit
    @meeting_point = MeetingPoint.find(params[:id])
  end

  # POST /meeting_points
  # POST /meeting_points.json
  def create
    @meeting_point = MeetingPoint.new(params[:meeting_point])

    respond_to do |format|
      if @meeting_point.save
        format.html { redirect_to @meeting_point, notice: 'Meeting point was successfully created.' }
        format.json { render json: @meeting_point, status: :created, location: @meeting_point }
      else
        format.html { render action: "new" }
        format.json { render json: @meeting_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meeting_points/1
  # PUT /meeting_points/1.json
  def update
    @meeting_point = MeetingPoint.find(params[:id])

    respond_to do |format|
      if @meeting_point.update_attributes(params[:meeting_point])
        format.html { redirect_to @meeting_point, notice: 'Meeting point was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meeting_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meeting_points/1
  # DELETE /meeting_points/1.json
  def destroy
    @meeting_point = MeetingPoint.find(params[:id])
    @meeting_point.destroy

    respond_to do |format|
      format.html { redirect_to meeting_points_url }
      format.json { head :no_content }
    end
  end
end
