class AddEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :body
      t.string :status
      t.datetime :start_time
      t.string :slug, index: { unique: true } # This adds a unique index to the slug column
      t.timestamps
    end
  end
end
