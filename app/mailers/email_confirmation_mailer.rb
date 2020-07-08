class EmailConfirmationMailer < ApplicationMailer
  def inform(recipient)
    @email = recipient.email
    @user = recipient
    mail(to: @email, subject: "Email confirmation for #{@user.first_name}", body: "Visit #{view_context.link_to("here", confirmation_url(@user.id))} to activate your account")
  end
end
