require "date"
require "yaml"

module LibraryHelper
  Category = Struct.new(:title, :tag, :title_color, :shelf_color, keyword_init: true)

  def library_categories
    @library_categories ||= begin
      data = YAML.load_file(Rails.root.join("config", "categories.yml"))
      data.map { |attributes| Category.new(attributes.symbolize_keys) }
    end
  end

  def books_for_category(category)
    Book.all
        .select { |book| book.tags_list.include?(category.tag) }
        .sort_by { |book| book.published_on || Date.new(1900) }
        .reverse
  end

  def book_category_for(tag)
    library_categories.find { |category| category.tag == tag }
  end
end
