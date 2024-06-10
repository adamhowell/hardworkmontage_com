class AddPostTypeToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :article_type, :string
  end
end
