class Admins::UsersController < AdminsController
  before_action :set_food, only: %i[ destroy ]

  def index
    @users = User.all.order(:id)
  end

  def destroy
    @user.destroy!
    flash[:notice] = 'ユーザを削除しました。'
    redirect_to admins_users_path
  end

  private

  def set_food
    @user = User.find(params[:id])
  end
end
