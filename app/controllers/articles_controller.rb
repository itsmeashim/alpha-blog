class ArticlesController < ApplicationController
    before_action :find_article, only: [:show, :edit, :update, :destroy]

    def show
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def edit
    end

    def create
        @article = Article.new(whitelist_vars)
        if @article.save
            flash[:notice] = "Article Created Successfully!!"
            redirect_to @article
        else
            render 'new'
        end
    end

    def update
        if @article.update(whitelist_vars)
            flash[:notice] = "Article Edited Successfully!!"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        if @article.destroy
            flash[:notice] = "Article Deleted Successfully!!"
            redirect_to articles_path
        end
    end

    private 
    
    def find_article
        @article = Article.find(params[:id])
    end

    def whitelist_vars
        params.require(:article).permit(:title, :description)
    end

end