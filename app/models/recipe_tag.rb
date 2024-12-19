class RecipeTag < ApplicationRecord
  belongs_to :recipe, foreign_key: 'recipe_uuid', primary_key: 'uuid'
  belongs_to :tag, foreign_key: 'tag_uuid', primary_key: 'uuid'
end
