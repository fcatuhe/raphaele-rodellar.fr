Rails.application.routes.draw do
  get "/.well-known/*", to: ->(_env) { [ 204, {}, [] ] }

  root "pages#show", slug: "index"
  get "bibliotheque/:slug", to: "books#show", as: :book
  get "/*slug", to: "pages#show", as: :page
end
