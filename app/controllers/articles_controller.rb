class ArticlesController < ApplicationController
    # GET /articles
    def index
      @pagy, @articles = pagy(Article.where(status: "published").order(published_at: :desc))
    end

    # GET /articles/:id
    def show
      @article = Article.friendly.find(params[:id])
    end
  
    # GET /articles/new
    def new
      @article = Article.new
    end
  
    # POST /articles
    def create
      @article = Article.new(article_params)
  
      # Set default status as draft if not provided
      @article.draft! unless @article.status.present?
  
      if @article.save
        redirect_to @article, notice: 'Article was successfully created.'
      else
        render :new
      end
    end
  
    # GET /articles/:id/edit
    def edit
      @article = Article.find(params[:id])
    end
  
    # PATCH/PUT /articles/:id
    def update
      @article = Article.find(params[:id])
      
      if @article.update(article_params)
        redirect_to @article, notice: 'Article was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /articles/:id
    def destroy
      @article = Article.find(params[:id])
      @article.destroy
      redirect_to articles_url, notice: 'Article was successfully destroyed.'
    end
  
    private
  
    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
  end
  