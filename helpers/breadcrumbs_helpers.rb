module BreadcrumbsHelpers
  def breadcrumbs(page, separator: ' · ', wrapper: nil)
    hierarchy = [ page ]
    hierarchy.prepend hierarchy.first.parent while hierarchy.first.parent
    hierarchy.map { |page| wrap link_to(page.path, page), wrapper: wrapper }.join(h separator)
  end

  def curious_breadcrumbs(page, separator: ' · ', wrapper: nil)
    hierarchy = [ page ]
    hierarchy.prepend hierarchy.first.parent while hierarchy.first.parent
    hierarchy.shift
    hierarchy.pop
    hierarchy.prepend sitemap.find_resource_by_path('/curieux.html')
    hierarchy.map { |page| wrap link_to(page.data.title, page, class: 'text-green text-decoration-none'), wrapper: wrapper }.join(h separator)
  end

  private
    def wrap(content, wrapper: nil)
      wrapper ? content_tag(wrapper) { content } : content
    end
end
