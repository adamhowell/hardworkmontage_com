class AddExcerptToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :excerpt, :string
  end
end
