class Admin::UsersController < AdminController
  before_action :set_source, only: [:show, :edit, :destroy, :update_nick, :update_email, :update_password]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_root_path
    else
      render :new
    end
  end

  def edit
  end

  def update_nick
      if @user.update(nick_params)
        redirect_to admin_root_path
      else
        render :edit
      end
  end

  def update_email
    if @user.update(email_params)
      redirect_to admin_root_path, notice: 'Email was successfully updated.'
    else
      render :edit
    end
  end

  def update_password
    if @user.update(password_params)
      redirect_to admin_root_path, notice: 'Password was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_root_path, notice: 'User was successfully destroyed.' }
    end
  end
  
  private

  def set_source
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :email_confirmation, :password, :password_confirmation, :nick)
  end

  def nick_params
    params.require(:user).permit(:nick)
  end

  def email_params
    params.require(:user).permit(:email, :email_confirmation)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
