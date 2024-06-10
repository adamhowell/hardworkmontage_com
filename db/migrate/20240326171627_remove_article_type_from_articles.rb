class RemoveArticleTypeFromArticles < ActiveRecord::Migration[6.0] # Ensure the version matches your app
  def change
    remove_column :articles, :article_type, :string # Specify the column type if you want to revert this migration in the future
  end
end
