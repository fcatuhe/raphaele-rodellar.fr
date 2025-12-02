Voyage = Decant.define(dir: "content/voyage", ext: "md") do
  frontmatter :title
  frontmatter :position

  def self.advent
    all.select(&:position).sort_by { -it.position }
  end
end
