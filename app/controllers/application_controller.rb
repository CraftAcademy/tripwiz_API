class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from ActionController::ParameterMissing, with: :missing_params

  def missing_params
    render json: { error: 'Missing parameters' }, status: 422
  end
end
