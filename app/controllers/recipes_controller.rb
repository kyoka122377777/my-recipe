class RecipesController < ApplicationController
  before_action :require_login, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :disable_cache, only: [:show]

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

    # 画像がある場合、保存前に画像を添付
    if params[:recipe][:images].present?
      params[:recipe][:images].each do |image|
        if image.is_a?(ActionDispatch::Http::UploadedFile)
          # 画像がすでに添付されているか確認
          unless @recipe.images.attachments.any? { |attached_image| attached_image.filename.to_s == image.original_filename }
            @recipe.images.attach(image)
          end
        end
      end
    end

    if @recipe.save
      # 画像添付後、レシピの情報を保存
      if params[:recipe][:ingredients].present?
        ingredients = params[:recipe][:ingredients]
        amounts = params[:recipe][:amounts]
        ingredients.each_with_index do |ingredient_name, index|
          next if ingredient_name.blank?

          amount = amounts[index]
          @recipe.quantities.create(ingredient_name: ingredient_name.strip, amount: amount)

          # タグを作成
          tag = Tag.find_or_create_by(name: ingredient_name.strip)
          @recipe.recipe_tags.find_or_create_by(tag: tag)
        end
      end

      redirect_to recipe_path(@recipe), notice: "レシピを作成しました。", status: :see_other
    else
      Rails.logger.error @recipe.errors.full_messages
      render :new, alert: "作成に失敗しました。", status: :unprocessable_entity
    end
  end


  
  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe.assign_attributes(recipe_params)
  
    if @recipe.changed? || @recipe.valid?
      @recipe.save
      redirect_to home_path, notice: 'レシピが更新されました。'
    else
      flash.now[:alert] = '更新に失敗しました。'
      render :edit
    end
  end
  
  def destroy
    if @recipe.destroy
      redirect_to home_path, notice: 'レシピが削除されました。', status: :see_other
    else
      redirect_to home_path, alert: '削除に失敗しました。'
    end
  end
  
  
  private

  def recipe_params
    params.require(:recipe).permit(:title, :description, images: [], quantities_attributes: [:id, :ingredient_name, :amount, :_destroy])
  end

  def set_recipe
    @recipe = current_user.recipes.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to home_path, alert: 'レシピが見つかりません。'
  end

  def disable_cache
    response.headers["Cache-Control"] = "no-store, no-cache, must-revalidate, max-age=0"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: "ログインが必要です"
    end
  end
end
