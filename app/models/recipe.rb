class Recipe < ApplicationRecord
  belongs_to :user  # ユーザーとの関連付けを追加
  has_many :quantities, dependent: :destroy, inverse_of: :recipe
  accepts_nested_attributes_for :quantities, allow_destroy: true
  has_many_attached :images  # 複数の画像を添付
  scope :owned_by, ->(user) { where(user: user) }

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true  # 説明が必須
  validates :user, presence: true

  before_validation :remove_empty_quantities, if: -> { quantities.present? }
  validate :validate_quantities_count

  private

  # 空の材料入力欄を自動削除
  def remove_empty_quantities
    quantities.each do |quantity|
      if quantity.ingredient_name.blank? && quantity.amount_with_unit.blank?
        quantity.mark_for_destruction
      end
    end
  end

  def validate_quantities_count
    if quantities.size < 1
      errors.add(:base, "少なくとも1つの材料を入力してください。")
    end
  end
end
