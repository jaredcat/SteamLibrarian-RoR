class HomeController < ApplicationController
  def index
  end
  
  def submit
    steamid = nil
    steamid = User.valid?(params[:steamid])
    if(steamid)
      redirect_to action: "user", steamid: steamid
    else
      redirect_to action: "index"
    end
  end
  
  def user
    @user = User.checkUser(params[:steamid])
  end
  
  def stats
    @user = User.checkUser(params[:steamid])
  end
end
