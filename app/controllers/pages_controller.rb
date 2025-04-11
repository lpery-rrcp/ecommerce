# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def home
  end

  def show
    @page = Page.find_by!(slug: params[:slug])
  end
end
