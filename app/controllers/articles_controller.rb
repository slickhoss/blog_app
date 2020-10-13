class ArticlesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    
    def index
        @articles = Article.all
    end

    def show
        @comments = @article.comments.all
        @comment = @article.comments.build
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            redirect_to articles_path
            flash[:success] = "Article has been created"
        else
            flash[:danger] = 'Article has not been created'
            render :new
        end
    end

    def edit
        unless @article.user == current_user
            flash[:alert] = 'You can only edit your own article.'
            redirect_to root_path
        end
    end

    def update
        unless @article.user == current_user
            flash[:alert] = 'You can only edit your own article.'
            redirect_to root_path
        else
            if @article.update(article_params)
                redirect_to @article
                flash[:success] = 'Article has been updated'
            else
                flash[:danger] = 'Article has not been updated'
                render :edit
            end
        end
    end

    def destroy
        unless @article.user == current_user
            flash[:alert] = 'You can only delete your own articles.'
            redirect_to root_path
        else
            @article.destroy
            flash[:success] = 'Article successfully deleted'
            redirect_to root_path
        end
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
