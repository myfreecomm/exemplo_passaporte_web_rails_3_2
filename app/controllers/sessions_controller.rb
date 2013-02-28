# encoding: utf-8
class SessionsController < ApplicationController

  skip_before_filter :login_required, :only => [:create]

  # GET /auth/:provider/callback
  def create
    @user = User.find_or_create_from_passaporte_web(auth_hash)
    session[:user_id] = @user.id
    redirect_to root_url, :notice => "Hello #{@user.email}!"
  end

  # GET /logout
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Not logged in anymore."
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
