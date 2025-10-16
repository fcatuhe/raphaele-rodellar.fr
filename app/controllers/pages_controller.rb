class PagesController < ApplicationController
  def show
    @page = Page.all.find { |page| page.slug == params[:slug] }

    return if @page

    render_not_found
  end
end
