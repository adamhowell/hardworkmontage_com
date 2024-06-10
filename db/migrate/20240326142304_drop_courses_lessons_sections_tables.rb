class DropCoursesLessonsSectionsTables < ActiveRecord::Migration[6.0] # Make sure to use the correct version here
  def up
    drop_table :enrollments if ActiveRecord::Base.connection.table_exists?(:enrollments)
    drop_table :courses if ActiveRecord::Base.connection.table_exists?(:courses)
    drop_table :lessons if ActiveRecord::Base.connection.table_exists?(:lessons)
    drop_table :sections if ActiveRecord::Base.connection.table_exists?(:sections)
  end
end
