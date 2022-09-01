class CategoriesController < ApplicationController
    before_action :require_admin, except: [:index, :show]
    before_action :set_data, only: [:show, :edit, :update]
    
    def new
        @category = Category.new
    end

    def index
        @categories = Category.paginate(page: params[:page], per_page: 5)
    end

    def show
        @articles = @category.articles.paginate(page: params[:page], per_page: 5)
    end

    def edit
    end

    def create
        @category = Category.new(set_params)
        if @category.save
            flash[:notice] = "Category Saved Successfully!"
            redirect_to @category
        else
            render 'new'
        end
    end

    def update
        if @category.update(set_params)
            flash[:notice] = "Article Updated Successfully!"
            redirect_to @category
        else
            render 'edit'
        end
    end

    private

    def set_params
        params.require(:category).permit(:name)
    end

    def set_data
        @category = Category.find(params[:id])
    end 

    def require_admin
        if !(logged_in? && current_user.admin?)
            flash[:alert] = "Need to be admin to perform this action!"
            redirect_to categories_path
        end
    end
end