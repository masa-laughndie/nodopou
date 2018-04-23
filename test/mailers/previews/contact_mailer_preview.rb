# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

  # Preview this email at 
  # http://localhost:3000/rails/mailers/contact_mailer/message_received
  def message_received
    contact = Contact.first
    ContactMailer.message_received(contact)
  end

end
