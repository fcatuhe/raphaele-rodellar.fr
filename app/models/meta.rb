class Meta < ActiveSupport::CurrentAttributes
  SITE_TITLE = "Raphaële Rodellar Thérapeute Réflexologue Bordeaux".freeze
  DEFAULT_DESCRIPTION = "Se mettre à l'écoute de son corps, se relâcher, se relaxer, se recharger, ... Venez profiter de tous les bienfaits de la réflexologie plantaire !".freeze
  DEFAULT_IMAGE = "og-image.jpg".freeze
  AUTHOR = "Raphaële Rodellar".freeze
  SITE_NAME = "Raphaële Rodellar".freeze
  DEFAULT_TYPE = "website".freeze

  attribute :layout, :body_class
  attr_writer :title, :description, :image, :type

  def title
    [ @title, SITE_TITLE ].compact_blank.join(" · ")
  end

  def description
    @description.presence || DEFAULT_DESCRIPTION
  end

  def image
    @image.presence || DEFAULT_IMAGE
  end

  def author
    AUTHOR
  end

  def type
    @type.presence || DEFAULT_TYPE
  end

  def site_name
    SITE_NAME
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

  def disallow_all?
    !production_live?
  end

  private
    def production_live?
      Rails.env.production? && !staging?
    end

    def staging?
      ActiveModel::Type::Boolean.new.cast(ENV["STAGING"])
    end
end
