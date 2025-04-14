class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show, :home ]

  def home; end

  def show
    @page = Page.find_by!(slug: params[:slug])
  end
end
