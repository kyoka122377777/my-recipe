class RecipesController < ApplicationController
  before_action :require_login, only: [:new, :create, :show, :edit]

  def index
    if params[:query].present?
      @recipes = current_user.recipes
                  .joins(:quantities, :tags)
                  .where("recipes.title ILIKE ? OR quantities.ingredient_name ILIKE ? OR tags.name ILIKE ?", 
                         "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
                  .distinct
    else
      @recipes = current_user.recipes
    end
  end
  

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
  
    if @recipe.save
      if params[:recipe][:ingredients].present?
        ingredients = params[:recipe][:ingredients]
        amounts = params[:recipe][:amounts]
        
        # quantitiesの保存を先に行う
        ingredients.each_with_index do |ingredient_name, index|
          next if ingredient_name.blank?
    
          amount = amounts[index]
          @recipe.quantities.create(ingredient_name: ingredient_name.strip, amount: amount)
          
          # タグを作成
          tag = Tag.find_or_create_by(name: ingredient_name.strip)
          @recipe.recipe_tags.find_or_create_by(tag: tag)
        end
      end
      Rails.logger.info "リダイレクト先: #{recipe_path(@recipe)}"
      redirect_to recipe_path(@recipe), notice: "レシピを作成しました。", status: :see_other
    else
      render :new, alert: "作成に失敗しました。", status: :unprocessable_entity
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  # def search
  #   if params[:query].present?
  #     @recipes = current_user.recipes.joins(:quantities)
  #                     .where("recipes.title ILIKE ? OR quantities.ingredient_name ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
  #                     .distinct
  #     render :index # index ビューをレンダリング
  #   else
  #     redirect_to home_path # クエリが空の場合はホームにリダイレクト
  #   end
  # end
  
  private

  def recipe_params
    params.require(:recipe).permit(:title, :description, images: [], quantities_attributes: [:id, :ingredient_name, :amount, :_destroy])
  end

  # def create_tags(ingredient_names)
  #   ingredient_names.each do |ingredient_name|
  #     tag = Tag.find_or_create_by(name: ingredient_name)
  #     RecipeTag.create(recipe_id: @recipe.id, tag_id: tag.id)
  #   end
  # end

  def require_login
    unless current_user
      redirect_to login_path, alert: "ログインが必要です"
    end
  end
end
