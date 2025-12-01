require "useragent"

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern unless Rails.env.development?

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :modern_browser?

  private
    def modern_browser?
      !ActionController::AllowBrowser::BrowserBlocker.new(request, versions: :modern).blocked?
    end

    def render_not_found
      @page = Page.find("404")
      render "pages/show", status: :not_found
    end
end
