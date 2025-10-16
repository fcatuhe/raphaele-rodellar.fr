require "yaml"

module VoyageHelper
  def voyage_titles
    @voyage_titles ||= YAML.load_file(Rails.root.join("config", "voyage.yml"))
  end

  def voyage_title(day)
    voyage_titles.fetch("title").fetch(day.to_s)
  end

  def render_voyage_step(day)
    render_markdown(VoyageStep.find(day).content)
  end
end
