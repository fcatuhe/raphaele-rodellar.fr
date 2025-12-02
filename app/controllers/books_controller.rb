class BooksController < ApplicationController
  def show
    @book = Book.find(params[:slug])

    @page = OpenStruct.new(
      title: @book.title,
      description: @book.subtitle.presence,
      layout: "book",
      body_class: "book",
      slug: @book.slug
    )
  rescue Decant::FileNotFound
    render_not_found
  end
end
