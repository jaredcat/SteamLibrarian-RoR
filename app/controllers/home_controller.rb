class HomeController < ApplicationController
  def index
  end
  
  def submit
    if(params[:steamid] != "")
      steamid = User.check_id(params[:steamid])
      redirect_to action: "user", steamid: steamid
    else
      render action: "index"
    end
  end
  
  def user
    @user = User.checkUser(params[:steamid])
  end
end
