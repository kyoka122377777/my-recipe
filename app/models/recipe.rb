class Recipe < ApplicationRecord
  # **アソシエーション**
  belongs_to :user, primary_key: 'uuid', foreign_key: 'user_uuid'
  has_many :recipe_tags, primary_key: :uuid, foreign_key: :recipe_uuid
  has_many :tags, through: :recipe_tags
  has_many :quantities, dependent: :destroy, inverse_of: :recipe
  has_many_attached :images

  # uuidを主キーとして設定
  self.primary_key = 'uuid'

  # **ネストされたフォームでの属性許可**
  accepts_nested_attributes_for :quantities, allow_destroy: true
  accepts_nested_attributes_for :recipe_tags

  # **スコープ**
  scope :owned_by, ->(user) { where(user: user) }

  # **コールバック**
  before_validation :remove_empty_quantities  # 空の材料を削除
  after_save :create_tags

  # **バリデーション**
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true
  validates :user, presence: true
  validate :validate_image_count  # 画像の検証
  validate :validate_image_format

  private

  # **空の材料入力欄を削除**
  def remove_empty_quantities
    quantities.each do |quantity|
      if quantity.ingredient_name.blank? && quantity.amount.blank?
        quantity.mark_for_destruction
      end
    end
  end

  # **材料名を基にタグを生成**
  # quantitiesに依存しているため、事前にquantitiesが設定されている必要があります。
  def create_tags
    Rails.logger.info "create_tagsメソッド開始"

    # quantitiesから名前を取得してタグに変換
    quantities.each do |quantity|
      next if quantity.ingredient_name.blank?

      tag = Tag.find_or_create_by(name: quantity.ingredient_name.strip)
      Rails.logger.info "生成/検索されたタグ: #{tag.name}"

      unless self.tags.include?(tag)
        self.tags << tag
        Rails.logger.info "タグ #{tag.name} をレシピに関連付けました"
      end
    end
    Rails.logger.info "create_tagsメソッド終了"
  end

  def validate_image_format
    # MIMEタイプが画像かどうかをチェック
    images.each do |image|
      unless image.content_type.start_with?('image/')
        errors.add(:images, "は画像ファイルではありません。")
      end
    end
  end

  # **画像の数を検証**
  # 必要に応じて画像の最大数を調整
  def validate_image_count
    if images.attached? && images.count > 5
      errors.add(:images, "は最大5枚まで添付できます")
    end
  end

end
