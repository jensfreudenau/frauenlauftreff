require 'pp'
require 'yaml'
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all

  # This is our new function that comes before Devise's one
  before_filter :set_locale, :set_timezone


  def set_timezone
    Time.zone = current_user.time_zone if current_user
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end


end
