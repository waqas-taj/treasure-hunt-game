# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  respond_to :json

  private

  def respond_with(current_user, _opts = {})
    if current_user.persisted?
      render json: {
        status: { code: 200, message: 'Signed up successfully.' },
        data: UserSerializer.new(current_user)
      }
    else
      render json: {
        status: { code: 422, message: "User couldn't be created successfully.", errors: current_user.errors.full_messages }
      }, status: :unprocessable_entity
    end
  end
end
