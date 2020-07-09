class EmailConfirmationMailer < ApplicationMailer

  def inform(recipient)
    @email = recipient.email
    @user = recipient
    @url = "https://localhost:3000/confirmation/#{@user.id}"
    # @url = "https://brownsfield.herokuapp.com/confirmation/#{@user.id}"
    mail(to: @email, subject: "Email confirmation for #{@user.first_name}")
    # mail(to: @email, subject: "Email confirmation for #{@user.first_name}", body: "Visit #{view_context.link_to("here", "https/localhost:3000/email/#{@user.id}")} to activate your account")
  end
end
