require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "ac1",
                     account_id: "account1",
                     password: "foobar",
                     email: "account1@exmaple.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present less than 51 characters" do
    @user.validate_name = true
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should be presnet less than 256 characters" do
    @user.validate_email = true
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    #有効なアドレスの例
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    #各アドレスで有効である
    valid_addresses.each do |valid_address|
      @user.validate_email = true
      #ユーザーemail情報に有効なアドレスを代入
      @user.email = valid_address
      #assertの第二引数　→　失敗した場合のメッセージ
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  #無効なアドレスによるemailの有効性確認
  test "email validation should reject invalid addresses" do
    @user.validate_email = true
    #無効なアドレスの例
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    #各アドレスで無効である
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  #emailの一意性の確認
  test "email addresses should be unique" do
    @user.validate_email = true
    #dup:複製
    #ユーザーの複製
    duplicate_user = @user.dup
    #ユーザーemailを大文字(upcase)で複製ユーザーに代入
    duplicate_user.email = @user.email.upcase
    #ユーザーの保存
    @user.save
    #複製ユーザーが有効ではない
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    @user.validate_email = true
    #文字の大小が混在したemail
    mixed_case_email = "Foo@ExAMPle.CoM"
    #ユーザーemailに代入し保存
    @user.email = mixed_case_email
    @user.save
    #ユーザーの更新したemailが小文字にしたものと等しくなる
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "account_id should be present" do
    @user.account_id = "    "
    assert_not @user.valid?
  end

  test "account_id should be present less than 16 characters" do
    @user.account_id = "a" * 16
    assert_not @user.valid?
  end

  test "password should be present (nonblank)" do
    @user.validate_password = true
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  #passwordの最小文字数制限の確認
  test "password should have a minimum length" do
    @user.validate_password = true
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end
