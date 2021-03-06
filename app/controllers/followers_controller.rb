class FollowersController < ApplicationController
  before_action :logged_in_user, :find_user_by_id

  def index
    @title = t "follow.followers"
    @users = @user.followers.page(params[:page]).per Settings.max_item_per_page
    render "users/show_follow"
  end
end
