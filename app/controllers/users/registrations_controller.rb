class Users::RegistrationsController < Devise::RegistrationsController
  invisible_captcha only: :create

  protected

  def build_resource(hash = {})
    self.resource = resource_class.new_with_session(hash, session)

    # Registering to accept an invitation should display the invitation on sign up
    if params[:invite] && (invite = AccountInvitation.find_by(token: params[:invite]))
      @account_invitation = invite
      resource.skip_default_account = true

    # Build and display account fields in registration form if needed
    elsif Jumpstart.config.register_with_account?
      account = resource.owned_accounts.first || resource.owned_accounts.new
      account.account_users.new(user: resource, admin: true)
    end
  end

  def update_resource(resource, params)
    # Jumpstart: Allow user to edit their profile without password
    resource.update_without_password(params)
  end

  def sign_up(resource_name, resource)
    # sign_in(resource_name, resource)
    resource.send_magic_link
    # Set the flash message
    flash[:notice] = "A login link has been sent to your email address. Please follow the link to log in to your account."

    # If user registered through an invitation, automatically accept it after signing in
    if @account_invitation
      @account_invitation.accept!(current_user)

      # Clear redirect to account invitation since it's already been accepted
      stored_location_for(:user)
    end
  end

  def after_sign_up_path_for(resource)
    "/login_code?email=#{resource.email}"
  end
end
