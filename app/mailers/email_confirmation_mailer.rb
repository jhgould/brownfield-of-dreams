class EmailConfirmationMailer < ApplicationMailer

  def inform(recipient)
    @email = recipient[:email]
    @user = recipient
    @url = "https://localhost:3000/confirmation/#{@user[:id]}"
    mail(to: @email, subject: "Email confirmation for #{@user[:name]}")
  end

  def invite(name, email, inviter)
    @user = name
    @inviter = inviter
    mail(to: email, subject: "Your friend made an app. Be supportive, ok!")
  end
end
