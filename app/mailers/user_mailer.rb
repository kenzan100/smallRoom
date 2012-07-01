#encoding: utf-8
class UserMailer < ActionMailer::Base
  default from: "s04155yo@gmail.com"
  
  def send_congrats(user, last_done_by_user)
    @last_done_by_user = last_done_by_user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "おめでとう!")
  end
end
