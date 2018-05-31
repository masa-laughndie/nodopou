require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase

  def setup
    @contact = contacts(:co1)
  end

  test "message_received" do
    mail = ContactMailer.message_received(@contact)
    mail.transport_encoding = "8bit"
    assert_equal "お問い合わせを受け取りました。(お問い合わせ番号 #{@contact.id})", mail.subject
    assert_equal ["noreply@nodopou.com"],  mail.from
    assert_equal ["nodobotoke@outlook.jp"], mail.to
  end

end
