Book = Decant.define(dir: "content/books", ext: "html.md") do
  frontmatter :title
  frontmatter :subtitle
  frontmatter :author
  frontmatter :publisher
  frontmatter :cover_url
  frontmatter :date
  frontmatter :tags

  def self.with_tag(tag)
    all.select { it.has_tag?(tag) }.sort_by(&:published_on).reverse
  end

  def has_tag?(tag)
    tags_list.include?(tag)
  end

  def tags_list
    tags.to_s.split(/\s*,\s*/)
  end

  def published_on
    return Date.new(1900) unless date

    Date.parse(date)
  end

  def set_meta
    Meta.title = title
    Meta.description = subtitle
  end
end
