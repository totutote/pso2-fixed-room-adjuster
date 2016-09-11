class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Devise::Controllers::Rememberable
  
  def twitter
    authenticate
  end

  def google
    authenticate
  end

  private

  def authenticate
    auth = request.env['omniauth.auth']
    uid = auth['uid']
    provider = auth['provider']
    user_auth = UserAuth.where(uid: uid, provider: provider).first
    if user_auth
      flash[:notice] = "#{provider}でログインしました。"
      remember_me(user_auth.user)
      sign_in_and_redirect user_auth.user, event: :authentication
    else
      if user_signed_in?
        UserAuth.create!(uid: uid, provider: provider, user_id: current_user.id)
        redirect_to root_url, notice: "#{provider}と連携しました。"
      else
        user = User.create!
        UserAuth.create!(uid: uid, provider: provider, user_id: user.id)
        sign_in_and_redirect user, event: :authentication
      end
    end
  end

end

