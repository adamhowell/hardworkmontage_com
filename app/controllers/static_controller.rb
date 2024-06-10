class StaticController < ApplicationController
  def index
    @user = User.new
    @article = Article.order(published_at: :asc).first
  end

  def about
  end

  def pricing
  end

  def terms
    @agreement = Rails.application.config.agreements.find { _1.id == :terms_of_service }
  end

  def privacy
    @agreement = Rails.application.config.agreements.find { _1.id == :privacy_policy }
  end

  def jumpstart_pro
  end

  def campfire
  end

  def projects
  end
end
