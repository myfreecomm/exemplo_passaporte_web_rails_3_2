# encoding: utf-8
class PagesController < ApplicationController

  skip_before_filter :login_required, :only => [:public]

  # GET /
  def public
    respond_to :html
  end

  # GET /private
  def private
    respond_to :html
  end

end
