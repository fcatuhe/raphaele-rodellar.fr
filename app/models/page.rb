Page = Decant.define(dir: "content/pages", ext: "html.erb") do
  frontmatter :title
  frontmatter :description
  frontmatter :page_type
  frontmatter :breadcrumbs

  def initialize(...)
    super
    set_meta
  end

  def set_meta
    Meta.title = title
    Meta.description = description
  end
end
