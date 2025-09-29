class ContactMailer < ApplicationMailer
  default to: ENV.fetch("CONTACT_TO_EMAIL", "test@example.com")

  def contact_email(name:, email:, message:)
    @name, @email, @message = name, email, message
    mail(
      from: ENV.fetch("CONTACT_FROM_EMAIL", "noreply@example.com"),
      reply_to: email,
      subject: "New website inquiry from #{name}"
    )
  end
end
