class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  

  def index
    if params[:query].present?
      @recipes = Recipe.joins(:quantities)
                       .where("recipes.title ILIKE ? OR quantities.ingredient_name ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
                       .distinct
    else
      @recipes = current_user.recipes
    end
  end

  def new
    @recipe = Recipe.new
    @recipe.quantities.build # 材料の入力フィールドを追加
  end

  
  # def create
  #   logger.debug params.inspect
  #   @recipe = Recipe.new(recipe_params)
  #   if @recipe.save
  #     redirect_to @recipe, notice: 'Recipe was successfully created.'
  #   else
  #     logger.debug(@recipe.errors.full_messages)
  #     render :new
  #   end
  # end
  def create
    logger.debug params.inspect
    @recipe = Recipe.new(recipe_params)
  
    # 自分で実装した方法で現在のユーザーを取得
    @recipe.user = User.find(session[:user_id]) if session[:user_id]
  
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      logger.debug(@recipe.errors.full_messages)
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: t('recipes.update.success') # i18n対応
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to home_path, notice: t('recipes.destroy.success') # i18n対応
  end

  def search
    if params[:query].present?
      @recipes = current_user.recipes.joins(:quantities)
                      .where("recipes.title ILIKE ? OR quantities.ingredient_name ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
                      .distinct
      render :index # index ビューをレンダリング
    else
      redirect_to home_path # クエリが空の場合はホームにリダイレクト
    end
  end
  


  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, images: [], quantities_attributes: [:id, :ingredient_name, :amount_with_unit, :_destroy])
  end

  def create_tags(ingredient_names)
    ingredient_names.each do |ingredient_name|
      tag = Tag.find_or_create_by(name: ingredient_name)
      RecipeTag.create(recipe_id: @recipe.id, tag_id: tag.id)
    end
  end
end
