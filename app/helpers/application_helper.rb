require "kramdown"

module ApplicationHelper
  SITE_NAME = "Raphaële Rodellar · Réflexologie plantaire thérapeutique".freeze
  SITE_AUTHOR = "Raphaële Rodellar".freeze
  DEFAULT_DESCRIPTION = "Se mettre à l'écoute de son corps, se relâcher, se relaxer, se recharger, ... Venez profiter de tous les bienfaits de la réflexologie plantaire !".freeze

  def render_content_from(page)
    render inline: page.content, layout: false
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

  def render_markdown(markdown)
    Kramdown::Document.new(markdown, input: "GFM", syntax_highlighter: :rouge).to_html.html_safe
  end

  def curious_layout_context?
    %w[curious book].include?(@page&.layout) || defined?(@book)
  end

  def curious_breadcrumbs_items
    return [] unless curious_layout_context?

    items = [ { label: "Curieux ?", path: page_path("curieux") } ]

    if defined?(@book) && @book.present?
      items << { label: "Dans ma Bibliothèque", path: page_path("bibliotheque") }
      items << { label: @book.title, path: nil }
    elsif current_page?(page_path("bibliotheque"))
      items << { label: @page.title, path: nil }
    elsif @page.present? && !current_page?(page_path("curieux"))
      items << { label: @page.title, path: nil }
    end

    items
  end

  def curious_breadcrumbs?
    curious_breadcrumbs_items.any?
  end

  def render_curious_breadcrumbs
    safe_join(
      curious_breadcrumbs_items.map do |item|
        if item[:path].present?
          link_to item[:label], item[:path], class: "text-green text-decoration-none"
        else
          content_tag(:span, item[:label], class: "text-green")
        end
      end,
      " · ".html_safe
    )
  end

  private

  def staging?
    ActiveModel::Type::Boolean.new.cast(ENV["STAGING"])
  end

  def production_live?
    Rails.env.production? && !staging?
  end
end
