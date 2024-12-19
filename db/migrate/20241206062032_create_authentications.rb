class CreateAuthentications < ActiveRecord::Migration[7.2]
  def change
    # Only create the table if it doesn't exist
    unless table_exists?(:authentications)
      create_table :authentications do |t|
        t.integer :user_id, null: false
        t.string :provider, null: false
        t.string :uid, null: false
        t.timestamps
      end

      add_index :authentications, [:provider, :uid], unique: true
    end
  end
end

