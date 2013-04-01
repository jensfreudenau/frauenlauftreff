require 'open-uri'

class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  # GET /profiles
  # GET /profiles.json
  #before_filter :authenticate_user!
  def index
    @points   = Array.new
    @profiles = Profile.where(:user_id => current_user.id)
    @user     = User.find(current_user.id)
    @bounds   = Hash.new

    lng_max=lat_max=-999999
    lng_min=lat_min=999999
    @anzahl = @user.profile.meeting_points.count
    @user.profile.meeting_points.each do |val|
      if val.lng.to_f > lng_max.to_f
        lng_max = val.lng
      end
      if val.lng.to_f < lng_min.to_f
        lng_min = val.lng
      end
      if val.lat.to_f > lat_max.to_f
        lat_max = val.lat
      end
      if val.lat.to_f < lat_min.to_f
        lat_min = val.lat
      end

      @points  << [ val.lng.to_s, val.lat.to_s, val.description, val.id ]
    end
    @bounds={:lng_max => lng_max, :lng_min=>lng_min, :lat_max=>lat_max, :lat_min=>lat_min }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profiles }
    end
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /profiles/new
  # GET /profiles/new.json
  def new
    @profile = Profile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @points = Array.new
    @user = User.find(current_user.id)
    @profile = Profile.where(:user_id => current_user.id).first
    @user.profile.meeting_points.each do |val|
        @points  << [ val.lng.to_s, val.lat.to_s, val.description, val.id ]
      end
  end

  def kill_off_photo
    @meeting_point = MeetingPoint.find(params[:id])
    @meeting_point.destroy
    render :layout => false
  end
  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(params[:profile])

    unless params[:profile][:city].nil?
      load_latlong_by_city(params[:profile][:city])
      params[:profile][:lat] = @lat
      params[:profile][:lng] = @lng
    end


    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { render action: "new" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = Profile.find(params[:id])


    respond_to do |format|
      unless params[:profile][:city].nil?
        load_latlong_by_city(params[:profile][:city])
        params[:profile][:lat] = @lat
        params[:profile][:lng] = @lng
      end
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to profiles_url, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url }
      format.json { head :no_content }
    end
  end

  private

  def load_latlong_by_city(city)
    doc = fetch "http://nominatim.openstreetmap.org/search?format=xml&q=" + city.gsub(' ', ',').to_s
    doc.remove_namespaces!
    @lat = doc.xpath("//searchresults/place").first["lat"].to_f
    @lng = doc.xpath("//searchresults/place").first["lon"].to_f
  end

  def fetch(uri_str, limit = 10)
    Nokogiri::XML(open(uri_str))
  end


end
