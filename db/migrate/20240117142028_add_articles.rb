class AddArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :body
      t.string :status
      t.timestamps
    end
  end
end
