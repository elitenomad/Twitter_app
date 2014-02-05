class UserMailer < ActionMailer::Base
  #self.async = true
  def welcome_email(user)
    @user = user
    @url  = 'http://wditwitter.herokuapp.com'
    mail(to: @user.email, subject: 'Welcome to WDI Twitter App')
  end

  def contact_mail(params)
  	@params = params
    @url  = 'http://wditwitter.herokuapp.com'
    mail(to: params[:email], subject: 'Welcome to WDI Twitter App')
  end
end