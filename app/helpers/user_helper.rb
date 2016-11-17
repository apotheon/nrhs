module UserHelper
  def admin_signed_in?
    user_signed_in? and current_user.admin
  end

  def redirect_unauthorized
    flash[:alert] = 'You are not authorized to perform that action.'
    redirect_to root_path
  end

  def redirect_non_admin
    redirect_unauthorized unless admin_signed_in?
  end
end
