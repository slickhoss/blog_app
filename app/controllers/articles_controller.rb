class ArticlesController < ApplicationController
    def index
    end

    def show
        
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.save
        redirect_to articles_path
        flash[:success] = "Article has been created"
        end

    private
        def article_params
            params.require(:article).permit(:title, :body)
        end


end
