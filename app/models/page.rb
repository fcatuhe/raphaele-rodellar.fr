Page = Decant.define(dir: "content/pages", ext: "html.erb") do
  frontmatter :title
  frontmatter :description
  frontmatter :page_type
  frontmatter :breadcrumbs

  def initialize(...)
    super
    set_meta
    Current.page_type = page_type
    Current.breadcrumbs = breadcrumbs
  end

  private
    def set_meta
      Meta.title = title
      Meta.description = description
    end
end
