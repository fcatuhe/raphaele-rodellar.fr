Page = Decant.define(dir: "content/pages", ext: "html.erb") do
  frontmatter :title
  frontmatter :description
  frontmatter :layout
  frontmatter :body_class

  def initialize(...)
    super
    set_meta
  end

  def set_meta
    Meta.title = title
    Meta.description = description
    Meta.layout = layout
    Meta.body_class = body_class
  end
end
