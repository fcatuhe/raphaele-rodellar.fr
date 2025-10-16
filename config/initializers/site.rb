Rails.application.config.x.site = ActiveSupport::InheritableOptions.new(
  name: "Raphaële Rodellar · Réflexologie plantaire thérapeutique",
  author: "Raphaële Rodellar",
  base_url: ENV.fetch("BASE_URL", "http://localhost:3000"),
  default_description: "Se mettre à l'écoute de son corps, se relâcher, se relaxer, se recharger, ... Venez profiter de tous les bienfaits de la réflexologie plantaire !",
  newsletter_subscription_url: ENV.fetch("NEWSLETTER_SUBSCRIPTION_URL", "https://patoumatic.fr/newsletters/4/subscribers"),
  robots_content: nil
)
