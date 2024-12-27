module UrlHelpers
  def base_url
    config[:base_url]
  end

  def absolute_url(path = nil)
    [ base_url, path ].join.delete_suffix('.html').delete_suffix('/')
  end

  alias site_url absolute_url

  def current_page_canonical_url
    site_url(current_page.url)
  end

  def root_url_or_scroll_to_top(current_page_url)
    current_page_url == "/" ? site_url("#") : site_url
  end

  def image_url(image_filename)
    absolute_url image_path(image_filename)
  end
end
