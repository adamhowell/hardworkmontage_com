# == Schema Information
#
# Table name: articles
#
#  id           :bigint           not null, primary key
#  body         :string
#  excerpt      :string
#  published_at :datetime
#  slug         :string
#  status       :string
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_articles_on_slug  (slug) UNIQUE
#

class Article < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged

    STATUSES = %w[draft published]

    has_rich_text :body

    validates :body, :published_at, presence: true

    attribute :published_at, default: -> { Time.current }

    has_one_attached :featured_image

    def self.with_title
        where.not(title: nil)
    end
end
  
