class ArticlesController < ApplicationController
  
  #CALLBACKS
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_article, except: [:index, :new, :create]
  
  #GET /articles
  def index
    #Obtener todos los articulos de la BD
    @articles = Article.paginate(page: params[:page], per_page:3).ultimos
  end

  #GET /articles/:id
  def show
    @article.update_visits_count
    @comment = Comment.new
  end

  #GET /articles/new
  def new
    @article = Article.new
    @categories = Category.all
  end

  def edit

  end

  #POST /articles
  def create
    @article = current_user.articles.new(article_params)
    @article.categories = params[:categories]
    
    #Guardar articulo en la base de datos y redireccionar
    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  #DELETE /articles/:id
  def destroy
    @article.destroy #Eliminar el objeto de la BD
    redirect_to articles_path
  end

  #PUT /articles/:id
  def update
    @article.categories = params[:categories]
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title,:body,:cover,:categories)
  end

end