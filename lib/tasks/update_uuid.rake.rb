# lib/tasks/update_uuid.rake

namespace :data do
  desc "Update UUID for all users"
  task update_uuid: :environment do
    User.find_each do |user|
      user.update_column(:uuid, SecureRandom.uuid) if user.uuid.nil?
    end
    puts "UUID updated for Users."
  end
end
