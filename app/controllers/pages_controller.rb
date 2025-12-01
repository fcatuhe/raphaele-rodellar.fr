class PagesController < ApplicationController
  def show
    @page = Page.find(params[:slug])
  rescue Decant::FileNotFound
    render_not_found
  end
end
