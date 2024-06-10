class Users::SessionsController < Devise::SessionsController
  include Devise::Controllers::Rememberable
  
  # We need to intercept the Sessions#create action for processing OTP
  # prepend_before_action :authenticate_with_two_factor, only: [:create]

  def authenticate_with_two_factor
    if sign_in_params[:email]
      self.resource = resource_class.find_by(email: sign_in_params[:email])

      # Any new login attempt should reset 2FA user
      clear_otp_user_from_session

      # Intercept Devise if 2FA required. Otherwise let Devise handle non-2FA auth
      authenticate_and_start_two_factor if resource&.otp_required_for_login?
    elsif session[:otp_user_id]
      authenticate_otp_attempt
    end
  end

  def authenticate_and_start_two_factor
    if resource.valid_password?(sign_in_params[:password])
      session[:remember_me] = Devise::TRUE_VALUES.include?(sign_in_params[:remember_me])
      session[:otp_user_id] = resource.id
      render :otp, status: :unprocessable_entity
    else
      # Let Devise handle invalid passwords
    end
  end

  def authenticate_otp_attempt
    self.resource = resource_class.find(session[:otp_user_id])

    if resource.verify_and_consume_otp!(params[:otp_attempt])
      clear_otp_user_from_session
      remember_me(resource) if session.delete(:remember_me)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource, event: :authentication)
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      flash.now[:alert] = t(".incorrect_verification_code")
      render :otp, status: :unprocessable_entity
    end
  end

  def clear_otp_user_from_session
    session.delete(:otp_user_id)
  end

  # The login code… code

  def login_code
    # Store the email from params in the session, if it's present
    session[:user_email] = params[:email] if params[:email].present?

    # Redirect to the same action without the email param to refresh the page
    redirect_to login_code_path unless params[:email].blank?
  end

  def login_code_submit
    # Assuming you have a way to identify the user (e.g., through a session variable)
    resource = User.find_by(email: session[:user_email])

    if resource.present? && resource.login_code == params[:login_code]
      # The codes match, sign in the user
      sign_in(resource, event: :authentication)
      # Redirect to the root path or another path of your choosing
      redirect_to root_path, notice: 'Successfully signed in.'
    else
      # The codes do not match, redirect back to the login form with an error message
      flash[:alert] = 'Invalid login code.'
      redirect_to action: :new # Adjust this as needed based on your routes
    end
  end
end
