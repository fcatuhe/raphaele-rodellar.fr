module UrlHelpers
  def base_url
    config[:base_url]
  end

  def absolute_url(path = nil)
    [base_url, path].join
  end

  alias site_url absolute_url

  def root_url_or_scroll_to_top(current_page_url)
    if current_page_url == '/'
      site_url('#')
    else
      site_url
    end

  end

  def image_url(image_filename)
    absolute_url image_path(image_filename)
  end
end
