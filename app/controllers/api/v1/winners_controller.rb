class Api::V1::WinnersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_winner, only: [:create]

  def index
    winners = Winner.all.order(distance: :asc)
    render json: winners, each_serializer: WinnerSerializer
  end

  def create
    return render json: { message: 'You have already won this game.' } if @winner_already_exists

    distance = calculate_distance
    return render_no_distance_calculated unless distance.positive?

    winner_params = {
      latitude: guess_params[:latitude],
      longitude: guess_params[:longitude],
      distance: distance,
      user_id: current_user.id
    }

    winner = Winner.new(winner_params)

    if winner.save
      if distance < DISTANCE_THRESHOLD
        UserMailer.winner_email(current_user).deliver_now
        winner.update(:email_sent, true)
        render status: :ok, json: { message: 'Congratulations! You are the winner' }
      else
        render json: { message: 'Better Luck For Next Time!' }
      end
    else
      render status: :unprocessable_entity, json: { message: 'Something went wrong!' }
    end
  end

  private

  def guess_params
    params.require(:winner).permit(:latitude, :longitude)
  end

  def load_winner
    @winner_already_exists = Winner.exists?(user: current_user, email_sent: true)
  end

  def calculate_distance
    treasure_location = [TREASURE_LATITUDE, TREASURE_LONGITUDE]
    user_guess = [guess_params[:latitude].to_f, guess_params[:longitude].to_f]
    Geocoder::Calculations.distance_between(treasure_location, user_guess) * DISTANCE_THRESHOLD
  end

  def render_no_distance_calculated
    render status: :unprocessable_entity, json: { message: 'Failed to calculate distance.' }
  end
end
