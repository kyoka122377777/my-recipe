module RecipesHelper
  def ingredient_fields(form, index)
    content_tag(:div, class: 'quantity-fields mb-3') do
      form.label("quantities_attributes[#{index}][ingredient_name]", "材料") +
      form.text_field("quantities_attributes[#{index}][ingredient_name]", class: "form-control", placeholder: "例: トマト") +
      form.label("quantities_attributes[#{index}][amount_with_unit]", "分量") +
      form.text_field("quantities_attributes[#{index}][amount_with_unit]", class: "form-control", placeholder: "例: 200g")
    end
  end
end
  
  