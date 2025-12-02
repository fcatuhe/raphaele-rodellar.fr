class Meta < ActiveSupport::CurrentAttributes
  SITE_TITLE = "Raphaële Rodellar Thérapeute Réflexologue Bordeaux".freeze
  SITE_NAME = "Raphaële Rodellar".freeze
  AUTHOR = "Raphaële Rodellar".freeze
  DEFAULT_DESCRIPTION = "Se mettre à l'écoute de son corps, se relâcher, se relaxer, se recharger, ... Venez profiter de tous les bienfaits de la réflexologie plantaire !".freeze
  DEFAULT_IMAGE = "og-image.jpg".freeze
  DEFAULT_TYPE = "website".freeze

  attribute :layout, :body_class
  attr_writer :title, :description, :image, :type

  def title
    [@title, SITE_TITLE].compact_blank.join(" · ")
  end

  def description
    @description.presence || DEFAULT_DESCRIPTION
  end

  def image
    @image.presence || DEFAULT_IMAGE
  end

  def type
    @type.presence || DEFAULT_TYPE
  end

  def site_name
    SITE_NAME
  end

  def author
    AUTHOR
  end

  def robots_content
    production_live? ? "index, follow" : "noindex, nofollow"
  end

  def main_class
    classes = []
    if layout == "home"
      classes << "home"
    else
      classes << "container mb-5"
    end
    classes << body_class
    classes.compact_blank.join(" ")
  end

  def curious_layout?
    %w[curious book].include?(layout)
  end

  private

  def staging?
    ActiveModel::Type::Boolean.new.cast(ENV["STAGING"])
  end

  def production_live?
    Rails.env.production? && !staging?
  end
end
