class UserController < ApplicationController
  before_action :require_login
end
