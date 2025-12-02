class BooksController < ApplicationController
  def show
    @book = Book.find(params[:slug])
    @book.set_meta_and_breadcrumbs
  end
end
