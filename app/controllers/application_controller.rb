class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Accounts::SubscriptionStatus
  include ActiveStorage::SetCurrent
  include Authentication
  include Authorization
  include CurrentHelper
  include DeviceFormat
  include Pagy::Backend
  include SetCurrentRequestDetails
  include SetLocale
  include Sortable
  include Users::AgreementUpdates
  include Users::NavbarNotifications
  include Users::Sudo
  include Users::TimeZone

  def after_magic_link_sent_path_for(resource_or_scope)
    "/login_code?email=#{resource_or_scope.email}"
  end
end
