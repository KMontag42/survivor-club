class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_check

  def index

  end

  protected

  def admin_check
    unless current_user.admin?
      flash[:danger] = 'You do not have permissions to do that.'
      redirect_to root_path
    end
  end
end
