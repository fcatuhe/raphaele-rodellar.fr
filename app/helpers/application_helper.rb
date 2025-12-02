require "kramdown"

module ApplicationHelper
  def render_content_from(page)
    render inline: page.content, layout: false
  end

  def render_markdown(markdown)
    Kramdown::Document.new(markdown, input: "GFM").to_html.html_safe
  end

  def canonical_url
    url_for(only_path: false)
  end

  def og_meta_tag(key, content)
    case key
    when :title, :description, :image
      tag(:meta, name: key, property: "og:#{key}", content: content)
    when :author
      tag(:meta, name: key, content: content)
    else
      tag(:meta, property: "og:#{key}", content: content)
    end
  end

  def root_path_or_scroll_to_top
    current_page?(root_path) ? "#" : root_path
  end

  def curious_breadcrumbs
    return [] unless Meta.curious_layout? || @book.present?
    return [] if current_page?(page_path("curieux"))

    [
      breadcrumb_link("Curieux ?", "curieux"),
      (@book.present? ? breadcrumb_link("Dans ma Bibliothèque", "bibliotheque") : nil)
    ].compact
  end

  def curious_breadcrumbs?
    curious_breadcrumbs.any?
  end

  def render_curious_breadcrumbs
    safe_join(curious_breadcrumbs, " · ".html_safe)
  end

  def breadcrumb_link(label, page)
    link_to(label, page_path(page), class: "text-green text-decoration-none")
  end
end
