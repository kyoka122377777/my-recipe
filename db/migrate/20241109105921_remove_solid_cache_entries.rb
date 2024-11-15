class RemoveSolidCacheEntries < ActiveRecord::Migration[8.0]
  #solid_cache_entries のテーブルの残りを消す
  def change
    drop_table :solid_cache_entries, if_exists: true
  end
end
