class Admin::StaticPagesController < ApplicationController
  layout "admin"
  before_action :logged_in_superuser, only: [:dashboard]

  def dashboard
    @users = User.all
    @courses = Course.all
    @subjects = Subject.all
  end
end
