class Recipe < ApplicationRecord
  belongs_to :user  # ユーザーとの関連付けを追加
  has_many :quantities, dependent: :destroy
  accepts_nested_attributes_for :quantities, allow_destroy: true
  has_many_attached :images  # 複数の画像を添付
  scope :owned_by, ->(user) { where(user: user) }

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true  # 説明が必須
  validates :quantities, presence: true
  validate :validate_quantities_count
  validates :user, presence: true

  private

  def validate_quantities_count
    if quantities.size < 1
      errors.add(:base, "少なくとも1つの材料を入力してください。")
    end
  end
end
