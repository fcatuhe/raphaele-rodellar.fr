module BreadcrumbHelper
  def breadcrumbs
    return [] unless Current.breadcrumbs.in?(%w[curious book])

    crumbs = [ { label: "Curieux ?", path: page_path("curieux") } ]
    crumbs << { label: "Dans ma Bibliothèque", path: page_path("bibliotheque") } if Current.breadcrumbs == "book"
    crumbs
  end

  def breadcrumb_links(link_class:)
    links = breadcrumbs.map { |crumb| link_to(crumb[:label], crumb[:path], class: link_class) }
    safe_join(links, " · ")
  end
end
