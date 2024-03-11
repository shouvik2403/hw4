class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new
    @user["username"] = params["username"]
    @user["email"] = params["email"]
    @user["password"] = params["password"]
    
    # check if the username exists
    if User.find_by({"email" => @user["email"]}) == nil
      # encrypt user's password "at rest"  
      @user["password"] = BCrypt::Password.create(params["password"])
      @user.save
      # add a secure cookie for this user
      session["user_id"] = User.find_by({"email" => @user["email"]})["id"]
      # display welcome message
      flash["notice"] = "Welcome #{@user["username"]}"  
      # redirect to places page
      redirect_to "/places"
    else   
      flash["notice"] = "An account with this email already exists! Please try a different email or login to your account."
      redirect_to "/users/new"
    end
  end  

end
