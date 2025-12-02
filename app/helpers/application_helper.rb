require "kramdown"

module ApplicationHelper
  def render_erb(content)
    render inline: content, layout: false
  end

  def render_markdown(markdown)
    Kramdown::Document.new(markdown, input: "GFM").to_html.html_safe
  end

  def canonical_url
    url_for(only_path: false).delete_suffix("/")
  end

  def og_meta_tags(**tags)
    tags.filter_map do |key, content|
      next if content.blank?

      case key
      when :title, :description, :image
        tag.meta(name: key, property: "og:#{key}", content: content)
      when :author
        tag.meta(name: key, content: content)
      else
        tag.meta(property: "og:#{key}", content: content)
      end
    end.join("\n").html_safe
  end

  def root_path_or_scroll_to_top
    current_page?(root_path) ? "#" : root_path
  end
end
