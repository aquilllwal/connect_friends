class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.send_mail.subject
  #
  def send_mail(user)
    @user = user
    user_friends = Friendship.where(user_id: @user.id)
    arr = []
    user_friends.each do |single_friend|
      arr << User.find(single_friend.friend_id).email
    end
    arr.each do |val|
      mail(to:val, subject:"#{@user.username} crated new post")
    end
  end
end
