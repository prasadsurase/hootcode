class CallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
    data = request.env['omniauth.auth']
    @user.update!({ 
      username: data['info']['nickname'], 
      avatar_url: data['info']['image']
    })
    sign_in_and_redirect @user
  end
end
