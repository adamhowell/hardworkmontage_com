class Event < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged

    has_one_attached :image

    has_rich_text :body
    validates :body, :start_time, presence: true
    
    # Association back to the user that owns the event
    belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

    # Association for users attending the event through enrollments
    has_many :enrollments
    has_many :attendees, through: :enrollments, source: :user
      
    # Checks if a given user is enrolled in the event
    def enrolled?(user)
        attendees.include?(user)
    end

    def paid?
        status == 'paid'
    end

    # Check if the event is a free event
    def free?
        status == 'free'
    end
end