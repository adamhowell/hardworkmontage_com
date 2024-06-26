module CurrentHelper
  def current_account
    Current.account
  end

  def current_account_user
    return unless current_account
    @account_user ||= current_account.account_users.includes(:user).find_by(user: current_user)
  end

  def current_roles
    current_account_user&.active_roles || []
  end

  def current_account_admin?
    !!current_account_user&.admin?
  end

  def current_account_paid?
    current_account.subscriptions.any?(&:active?)
  end

  def other_accounts
    @_other_accounts ||= current_user.accounts.order(name: :asc).where.not(id: current_account.id)
  end
end
