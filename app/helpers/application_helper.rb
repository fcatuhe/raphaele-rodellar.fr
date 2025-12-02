require "kramdown"

module ApplicationHelper
  SITE_NAME = "Raphaële Rodellar · Réflexologie plantaire thérapeutique".freeze
  SITE_AUTHOR = "Raphaële Rodellar".freeze
  DEFAULT_DESCRIPTION = "Se mettre à l'écoute de son corps, se relâcher, se relaxer, se recharger, ... Venez profiter de tous les bienfaits de la réflexologie plantaire !".freeze

  def render_content_from(page)
    render inline: page.content, layout: false
  end

  def render_markdown(markdown)
    Kramdown::Document.new(markdown, input: "GFM").to_html.html_safe
  end

  def site_name
    SITE_NAME
  end

  def title
    [ @page&.title.presence, site_name ].compact_blank.join(" · ")
  end

  def description
    @page&.description.presence || DEFAULT_DESCRIPTION
  end

  def author
    SITE_AUTHOR
  end

  def canonical_url
    url_for(only_path: false)
  end

  def robots_content
    production_live? ? "index, follow" : "noindex, nofollow"
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

  def main_tag_class
    classes = []
    if @page&.layout == "home"
      classes << "home"
    else
      classes << "container mb-5"
    end
    classes << @page&.body_class
    class_names(*classes)
  end

  def curious_breadcrumbs
    return [] unless %w[curious book].include?(@page&.layout) || @book.present?
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

  private

  def staging?
    ActiveModel::Type::Boolean.new.cast(ENV["STAGING"])
  end

  def production_live?
    Rails.env.production? && !staging?
  end
end
