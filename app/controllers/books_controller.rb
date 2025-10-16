require "ostruct"

class BooksController < ApplicationController
  def show
    @book = Book.all.find { |book| book.slug == params[:slug] }

    return render_not_found unless @book

    @page = OpenStruct.new(
      title: @book.title,
      description: @book.subtitle.presence,
      layout: "book",
      body_class: "book",
      slug: @book.slug
    )
  end
end
