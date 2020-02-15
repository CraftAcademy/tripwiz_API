# frozen_string_literal: true

class FacebookLoginController < Devise::RegistrationsController
  def create
    @user = User.from_omniauth(params.require(:uid), params.require(:email), params.require(:provider))
    if @user.persisted?
      sign_in @user
      @token = @user.create_token
      @user.save
      @auth_params = {
        auth_token: @token.token,
        client_id:  @token.client,
        uid:        params[:uid],
        expiry:     @token.expiry,
      }
      render json: @auth_params
    else
      render json: { error: 'For helvede Mads' }
    end
  end
end
