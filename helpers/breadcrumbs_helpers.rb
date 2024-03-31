module BreadcrumbsHelpers
  def breadcrumbs(page, separator: ' · ', wrapper: nil)
    hierarchy = [ page ]
    hierarchy.unshift hierarchy.first.parent while hierarchy.first.parent
    hierarchy.collect { |page| wrap link_to(page.data.title, page), wrapper: wrapper }.join(h separator)
  end

  private
    def wrap(content, wrapper: nil)
      wrapper ? content_tag(wrapper) { content } : content
    end
end
