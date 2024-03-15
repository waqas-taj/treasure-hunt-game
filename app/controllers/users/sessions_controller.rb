# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include RackSessionsFix
  respond_to :json

  def respond_with(current_user, _opts = {})
    if current_user.persisted?
      render json: {
        status: { code: 200, message: 'Logged in successfully.' },
        data: { user: UserSerializer.new(current_user) }
      }, status: :ok
    else
      render json: {
        status: { code: 401, message: 'Invalid credentials.' }
      }, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, ENV['DEVISE_JWT_SECRET_KEY']).first
      current_user = User.find_by(id: jwt_payload['sub'])
    end

    if current_user
      render json: {
        status: { code: 200, message: 'Logged out successfully.' }
      }, status: :ok
    else
      render json: {
        status: { code: 401, message: "Couldn't find an active session." }
      }, status: :unauthorized
    end
  end

  private

  def jwt_payload
    return if request.headers['Authorization'].blank?

    JWT.decode(request.headers['Authorization'].split(' ').last, ENV['DEVISE_JWT_SECRET_KEY']).first
  end

  def current_user_from_jwt_payload
    User.find_by(id: jwt_payload['sub']) if jwt_payload
  end
end
