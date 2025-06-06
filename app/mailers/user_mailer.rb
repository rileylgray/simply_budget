class UserMailer < ApplicationMailer
  def email_confirmation(user, url)
    client = Mailersend::Client.new("mlsn.6f2abf96b7462cc4cfc2b56071b050793f26b06d9c871f89ec749cb8eb1a81d2")
    ms_email = Mailersend::Email.new(client)
    ms_email.add_from("email" => "MS_aplJg5@test-51ndgwvzq2qlzqx8.mlsender.net")
    ms_email.add_recipients("email" => user.email)
    ms_email.add_subject("Confirm Email")

    html_body = ApplicationController.render(
      template: "user_mailer/email_confirmation",
      assigns: { user: user, url: url },
      layout: "mailer"
    )

    ms_email.add_html(html_body)

    ms_email.send
  end

  def password_reset(user, url)
    client = Mailersend::Client.new("mlsn.6f2abf96b7462cc4cfc2b56071b050793f26b06d9c871f89ec749cb8eb1a81d2")
    ms_email = Mailersend::Email.new(client)
    ms_email.add_from("email" => "MS_aplJg5@test-51ndgwvzq2qlzqx8.mlsender.net")
    ms_email.add_recipients("email" => user.email)
    ms_email.add_subject("Reset Your Password")

    html_body = ApplicationController.render(
      template: "user_mailer/password_reset",
      assigns: { user: user, url: url },
      layout: "mailer"
    )

    ms_email.add_html(html_body)

    ms_email.send
  end
end
