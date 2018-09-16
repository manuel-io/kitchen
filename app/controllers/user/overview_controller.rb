class User::OverviewController < UserController
  def index
    @user = current_user
  end
end
