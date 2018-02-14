class WelcomeController < ApplicationController
  def index
    #Obtener todos los articulos de la BD
    @articles = Article.order(visits_count: :desc).limit(3)
  end
end
