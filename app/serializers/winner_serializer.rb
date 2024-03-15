class WinnerSerializer < ActiveModel::Serializer
  attributes :name, :latitude, :longitude, :distance

  delegate :name, to: :user, prefix: true

  private

  def user
    object.user
  end
end
