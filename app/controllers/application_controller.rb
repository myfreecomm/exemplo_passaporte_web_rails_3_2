# encoding: utf-8

class NotAuthenticatedExpection < StandardError; end

class ApplicationController < ActionController::Base
  protect_from_forgery

  # requires login for all actions by default
  before_filter :login_required

  helper_method :current_user, :login_path

  rescue_from NotAuthenticatedExpection, :with => :unauthenticated_access

  private

  def login_path
    '/auth/passaporte_web'
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # before_filter
  def login_required
    raise NotAuthenticatedExpection if current_user.nil?
  end

  def unauthenticated_access
    error_message = 'You must be logged in to access this resource.'
    respond_to do |format|
      format.html { redirect_to(root_url, alert: error_message) }
      format.js   { render :text => "alert('#{error_message}');" }
      format.xml  { render :xml  => {:error => error_message}, :status => :unauthorized }
      format.json { render :json => {:error => error_message}, :status => :unauthorized }
    end
  end

end
