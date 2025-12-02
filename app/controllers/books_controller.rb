class BooksController < ApplicationController
  def show
    @book = Book.find(params[:slug])
    @book.set_meta
  rescue Decant::FileNotFound
    render_not_found
  end
end
