puts "Updating UUID for existing records..."

User.find_each do |user|
  user.update_column(:uuid, SecureRandom.uuid)
end
puts "UUID updated for Users."

Recipe.find_each do |recipe|
  recipe.update_column(:uuid, SecureRandom.uuid)
end
puts "UUID updated for Recipes."

Tag.find_each do |tag|
  tag.update_column(:uuid, SecureRandom.uuid)
end
puts "UUID updated for Tags."
