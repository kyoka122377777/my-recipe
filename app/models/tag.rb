class Tag < ApplicationRecord
  has_many :recipe_tags, primary_key: :uuid, foreign_key: :tag_uuid
  has_many :recipes, through: :recipe_tags

  # uuidを主キーとして設定
  self.primary_key = 'uuid'

  validates :name, presence: true, uniqueness: true
end
  