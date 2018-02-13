class Admin::UsersController < AdminController
  before_action :set_source, only: [:show, :edit, :update, :destroy, :email, :password]

  def new
    @user = User.new
  end

  def create
    @user = sign_up(user_params)

    if @user.valid?
      sign_in(@user)
      redirect_to admin_root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes nick: params[:user][:nick]
      redirect_to admin_root_path
    end
  end

  def email
    if params[:user][:email] == params[:user][:email_verify]
      if @user.update_attribute :email, params[:user][:email]
        redirect_to admin_root_path, notice: 'Email was successfully updated.'
      else
        redirect_to admin_root_path
      end
    else
      redirect_to :back, alert: 'Email does not comply to verification.'
    end
  end

  def password
    if params[:user][:password_digest] == params[:user][:password_verify]
      digest = reset_password @user, params[:user][:password_digest]
      @user.update_attribute :password_digest, digest
      redirect_to admin_root_path, notice: 'Password was successfully updated.'
    else
      redirect_to :back, alert: 'Password does not comply to verification.'
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_root_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private

  def set_source
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :nick)
  end
end
