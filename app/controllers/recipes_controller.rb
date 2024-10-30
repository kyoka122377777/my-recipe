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

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user # ログインユーザーをレシピに関連付け

    if @recipe.save
      if @recipe.images.attached?
        redirect_to @recipe, notice: t('recipes.create.success') # i18n対応
      else
        #flash.now[:alert] = t('recipes.create.no_image') # i18n対応
        render :new
      end
    else
      flash.now[:alert] = @recipe.errors.full_messages.join(", ")  # エラーメッセージをフラッシュメッセージに設定
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

  # def recipe_params
  #   params.require(:recipe).permit(:title, :description, images: [], quantities_attributes: [:id, :ingredient_name, :amount_with_unit, :_destroy])
  # end
  def recipe_params
    params.require(:recipe).permit(:title, :description, images: [], 
      quantities_attributes: [:id, :ingredient_name, :amount_with_unit, :_destroy]).tap do |whitelisted|
        whitelisted[:quantities_attributes]&.each do |key, attributes|
          if attributes[:ingredient_name].blank? && attributes[:amount_with_unit].blank?
            attributes[:_destroy] = '1'
          end
        end
    end
  end
  def create_tags(ingredient_names)
    ingredient_names.each do |ingredient_name|
      tag = Tag.find_or_create_by(name: ingredient_name)
      RecipeTag.create(recipe_id: @recipe.id, tag_id: tag.id)
    end
  end
end
