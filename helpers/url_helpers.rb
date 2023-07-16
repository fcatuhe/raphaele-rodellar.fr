module UrlHelpers
  def base_url
    config[:base_url]
  end

  def absolute_url(path = nil)
    [base_url, path].join
  end

  alias_method :site_url, :absolute_url

  def image_url(image_filename)
    absolute_url image_path(image_filename)
  end
end
