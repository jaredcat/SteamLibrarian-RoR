class HomeController < ApplicationController
  def index
  end
  
  def submit
    steamid = User.valid?(params[:steamid])
    if(steamid)
      redirect_to action: "user", steamid: steamid
    else
      render action: "index"
    end
  end
  
  def user
    @user = User.checkUser(params[:steamid])
  end
end
