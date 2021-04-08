class UsersController < ApplicationController
  # FILTERS
  before_action :only_loggedin_users, only:[:index, :edit, :update, :destroy, :follwing, :followers]
  before_action :correct_user, only: [:edit, :update]

  def index
    # @user = User.all
    # this will call will_paginate
    @users = User.paginate(page:params[:page], per_page: 10)
    # @user = Model_User.paginate(page: params[total number of users]
    #                               per_page: how many users will you display)
    
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Saved successfully!"
      redirect_to login_url
    else
      flash[:danger] = "Invalid content. Try again."
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page:12)
  end

  def edit
      @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_parames)
        flash[:success] = "Save successfully!"
          redirect_to @user   
    else
      flash[:danger] = "Invalid content. Try again"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url
  end

  private # Only this child can access this function
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

    

      def correct_user
        @user = User.find(params[:id])
          # go to HOME PAGE
          # UNLESS
          # current_user? ->ID of this user
          # is the same as the ID of the user being checked
        redirect_to(root_url) unless current_user?(@user)
      end
      
      def following
        @title ="Following"
        @user = User.find(params[:id])
        @user = @user.followed_users.paginate(page: params[:pate], per_page: 5)
        @all_users = @user.followed_users
        render 'show_follow'
      end

      def followers
        @title ="Followers"
        @user = User.find(params[:id])
        @user = @user.followers_users.paginate(page: params[:pate], per_page: 5)
        @all_users = @user.follower_users
        render 'show_follow'
      end

      private
      def user_parames
        params.require(:user).permit.(:name, :email, :password, :password_confirmation)
      end
        
end
