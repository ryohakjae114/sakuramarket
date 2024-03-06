class AdminsController < ActionController::Base
  layout 'admin'
  before_action :authenticate_admin!

  private

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource_or_scope)
    admin_root_path
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource_or_scope)
    new_admin_admin_user_session_path
  end
end
