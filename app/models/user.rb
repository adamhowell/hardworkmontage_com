class User < ApplicationRecord
  # Devise passwordless
  devise :magic_link_authenticatable
  
  has_prefix_id :user

  include Accounts
  include Agreements
  include Authenticatable
  include Mentions
  include Notifiable
  include Searchable
  include Theme

  has_one_attached :avatar
  has_person_name
  
  # has_many :enrollments
  # # Association for events that the user owns
  # has_many :owned_events, class_name: 'Event', foreign_key: 'owner_id'

  # # Association for events that the user is attending through enrollments
  # has_many :enrollments
  # has_many :attended_events, through: :enrollments, source: :event

  validates_uniqueness_of :email, case_sensitive: false
  validates :avatar, resizable_image: true

  def rememberable_value
    Devise.friendly_token
  end

  def name
    "#{first_name} #{last_name}"
  end

  store_accessor :preferences, :discount_code
  store_accessor :preferences, :teamstreak_invite_sent
end
