class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.message_received.subject
  #
  def message_received(contact)
    @contact = contact
    mail to: 'nodobotoke@outlook.jp', subject: "お問い合わせを受け取りました。(お問い合わせ番号 #{contact.id})"
  end
end
