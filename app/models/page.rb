Page = Decant.define(dir: "content/pages", ext: "html.erb") do
  frontmatter :title
  frontmatter :description
  frontmatter :layout
  frontmatter :body_class
end
