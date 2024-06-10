class AddSections < ActiveRecord::Migration[7.1]
  def change
    create_table :sections do |t|
      t.bigint :course_id
      t.string :title
      t.timestamps
    end
  end
end
