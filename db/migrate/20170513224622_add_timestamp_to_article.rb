class AddTimestampToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :created_at, :datetime, default: Time.now
    add_column :articles, :updated_at, :datetime, default: Time.now
  end
end
