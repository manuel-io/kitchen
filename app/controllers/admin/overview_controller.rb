class Admin::OverviewController < AdminController
  def index
    @users = User.all
  end
end
