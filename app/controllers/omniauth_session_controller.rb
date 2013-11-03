class OmniauthSessionController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Вошел!"
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Вышел!"
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

end
