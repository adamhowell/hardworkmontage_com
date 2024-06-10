class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course
  # Broadcast changes in realtime with Hotwire
  # after_create_commit -> { broadcast_prepend_later_to :enrollments, partial: "enrollments/index", locals: {enrollment: self} }
  # after_update_commit -> { broadcast_replace_later_to self }
  # after_destroy_commit -> { broadcast_remove_to :enrollments, target: dom_id(self, :index) }
end
