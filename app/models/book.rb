Book = Decant.define(dir: "content/books", ext: "html.md") do
  frontmatter :title
  frontmatter :subtitle
  frontmatter :author
  frontmatter :publisher
  frontmatter :cover_url
  frontmatter :date
  frontmatter :tags

  def published_on
    raw = frontmatter[:date]
    raw.present? ? Date.parse(raw.to_s) : nil
  end

  def tags_list
    Array(tags).flat_map { |value| value.to_s.split(/\s*,\s*/) }.reject(&:blank?)
  end
end
