# Inspired by https://github.com/rails/rails/pull/37918
module HeadHelpers
  def title
    [ current_page.data.title.presence, "Raphaële Rodellar Thérapeute Réflexologue Bordeaux" ].compact.join(' · ')
  end

  def description
    current_page.data.description || "Se mettre à l'écoute de son corps, se relâcher, se relaxer, se recharger, ... Venez profiter de tous les bienfaits de la réflexologie plantaire !"
  end
end
