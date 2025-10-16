require "kramdown"
require "uri"

module ApplicationHelper
  def render_content_from(page)
    render inline: page.content, layout: false
  end

  def site_name
    site_config.name
  end

  def title
    [ @page&.title.presence, site_name ].compact_blank.join(" · ")
  end

  def description
    @page&.description.presence || site_config.default_description
  end

  def author
    site_config.author
  end

  def canonical_url
    absolute_url(request.fullpath)
  end

  def robots_content
    site_config.robots_content || default_robots_content
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

  def absolute_url(path = nil)
    return site_config.base_url if path.blank?

    URI.join("#{site_config.base_url}/", path.delete_prefix("/")).to_s
  end
  alias site_url absolute_url

  def root_url_or_scroll_to_top
    @page&.slug == "index" ? site_url("#") : site_url
  end

  def newsletter_subscription_url
    site_config.newsletter_subscription_url
  end

  def class_names(*args)
    classes = []

    args.each do |arg|
      case arg
      when Hash
        arg.each { |key, value| classes << key.to_s if value }
      when Array
        nested = class_names(*arg)
        classes << nested if nested.present?
      else
        classes << arg.to_s if arg.present?
      end
    end

    classes.compact_blank.join(" ")
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
    elsif @page&.slug == "bibliotheque"
      items << { label: @page.title, path: nil }
    elsif @page&.slug.present? && @page.slug != "curieux"
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

  def site_config
    Rails.application.config.x.site
  end

  def default_robots_content
    Rails.env.production? ? "index, follow" : "noindex, nofollow"
  end
end
