module VoyageHelper
  def voyage_title(day)
    Voyage.find(day).title
  end

  def render_voyage(day)
    render_markdown(Voyage.find(day).content)
  end
end
