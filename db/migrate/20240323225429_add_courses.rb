class AddCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :body
      t.string :status
      t.string :slug, index: { unique: true } # This adds a unique index to the slug column
      t.timestamps
    end
  end
end
