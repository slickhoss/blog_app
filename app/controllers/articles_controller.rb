class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    def index
        @articles = Article.all
    end

    def show
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to articles_path
            flash[:success] = "Article has been created"
        else
            flash[:danger] = 'Article has not been created'
            render :new
        end
    end

    def edit
    end

    def update
        if @article.update(article_params)
            redirect_to @article
            flash[:success] = 'Article has been updated'
        else
            flash[:danger] = 'Article has not been updated'
            render :edit
        end
    end

    def destroy
        @article.destroy
        flash[:success] = 'Article successfully deleted'
        redirect_to articles_path
    end

    protected
        def resource_not_found
            message = 'The article you are looking for could not be found'
            flash[:alert] = message
            redirect_to root_path
        end

    private
        def article_params
            params.require(:article).permit(:title, :body)
        end
        
        def set_article
            @article = Article.find(params[:id])
        end

end
