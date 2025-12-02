class BookCategory
  attr_reader :title, :tag, :title_color, :shelf_color

  def initialize(title:, tag:, title_color:, shelf_color:)
    @title = title
    @tag = tag
    @title_color = title_color
    @shelf_color = shelf_color
  end

  def books
    Book.with_tag(tag)
  end

  class << self
    def all
      @all ||= begin
        data = YAML.load_file(Rails.root.join("data", "categories.yml"))
        data.map { |attrs| new(**attrs.symbolize_keys) }
      end
    end

    def find_by_tag(tag)
      all.find { |category| category.tag == tag }
    end
  end
end
