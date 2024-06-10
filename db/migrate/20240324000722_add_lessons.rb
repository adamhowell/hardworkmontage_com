class AddLessons < ActiveRecord::Migration[7.1]
  def change
    create_table :lessons do |t|
      t.bigint :section_id
      t.string :title
      t.boolean :is_paid, default: false
      t.text :body
      t.timestamps
    end
  end
end