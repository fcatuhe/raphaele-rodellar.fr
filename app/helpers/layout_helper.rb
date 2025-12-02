module LayoutHelper
  def main_class
    case page_type
    when "home" then "home"
    when "book" then "container mb-5 book"
    else "container mb-5"
    end
  end

  def page_type
    @page&.page_type || (@book && "book")
  end
end
