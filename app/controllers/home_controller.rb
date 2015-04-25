class HomeController < ApplicationController
  def index
  end
  
  def submit
    if(params[:steamid] != "")
      @user = User.newUser(params[:steamid])
    else
      redirect_to root_url
    end
  end
  
  def user
  end
end
