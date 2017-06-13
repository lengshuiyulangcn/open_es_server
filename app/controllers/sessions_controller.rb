class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    flash[:success] = "登陆成功"
    redirect_to root_path
  end

  def subscribe
    subscription = JSON.dump(params[:subscription].permit!.to_hash)
    if current_user
      current_user.update(subscription: subscription)
    end
    session[:subscription] = subscription 
    head :ok
  end

  def wunderlist
     token = request.env['omniauth.auth']['info']['token']
     id = request.env['omniauth.auth']['info']['id']
     if current_user && current_user.update(wunderlist_token: token, wunderlistId: id)
       flash[:success] = "关联wunderlist成功！"
       redirect_to root_path
     end

  end
  def destroy
    reset_session
    flash[:alert] = "已退出登陆"
    redirect_to root_path
  end
end
