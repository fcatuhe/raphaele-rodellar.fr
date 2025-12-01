class BooksController < ApplicationController
  def show
    @book = Book.find(params[:slug])
  rescue Decant::FileNotFound
    render_not_found
  end
end
