class UserMailer < ApplicationMailer
  def winner_email(user)
    @user = user
    mail(to: @user.email, subject: 'Winner of the Treasure Hunt Game!')
  end
end
