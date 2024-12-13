class Quantity < ApplicationRecord
  #belongs_to :recipe, inverse_of: :quantities
  belongs_to :recipe, foreign_key: 'user_uuid', primary_key: 'uuid'
  
  # 材料名と分量の両方が空でない場合、エラーメッセージを追加
  validate :ingredient_or_amount_present

  private

  def ingredient_or_amount_present
    # 分量のみが入力されている場合はエラーメッセージを追加
    if amount.present? && ingredient_name.blank?
      errors.add(:ingredient_name, "を入力してください")
    end
  end
end
