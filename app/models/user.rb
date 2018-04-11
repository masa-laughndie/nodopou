class User < ApplicationRecord

  attr_accessor :validate_name, :validate_email,
                :validate_password, :validate_password_confirmation,
                :remember_token, :reset_token

  before_save :downcase_email, if: :validate_email?
  before_save :downcase_nodoboid

  validates :name, presence: { message: "名前を入力してください",
                               if: :validate_name? },
                   length:   { maximum: 50,
                               message: "名前は50文字以内まで有効です",
                               allow_blank: true }

  VALID_MYSIZE_ID_REGIX = /\A[a-zA-Z0-9_]+\z/
  validates :account_id, presence:   { message: "NoDoBoIDを入力してください" },
                         length:     { maximum: 15,
                                       message: "NoDoBoIDは15文字以内まで有効です" },
                         format:     { with: VALID_MYSIZE_ID_REGIX,
                                       message: "NoDoBoIDは英数字,_(アンダーバー)のみ使用できます",
                                       allow_blank: true },
                         uniqueness: { case_sensitive: false,
                                       message: "そのNoDoBoIDは既に使われています",
                                       allow_nil: true }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   { message: "メールアドレスを入力してください",
                                  if: :validate_email? },
                    length:     { maximum: 255,
                                  message: "メールアドレスは255文字以内まで有効です" },
                    format:     { with: VALID_EMAIL_REGEX,
                                  message: "そのメールアドレスは不正な値を含んでいます",
                                  allow_blank: true },
                    uniqueness: { case_sensitive: false,
                                  message: "そのメールアドレスは既に登録されています" }

  has_secure_password validations: false

  validates :password, presence:     { message: "Passwordを入力してください",
                                       if: :validate_password? },
                       length:       { minimum: 6,
                                       message: "Passwordは6文字以上で入力してください",
                                       allow_blank: true },
                       confirmation: { message: "PasswordとPassword確認が不一致です",
                                       allow_blank: true }
  validates :password_confirmation,  presence: { message: "Password確認を入力してください",
                                                 if: :validate_password_confirmation? }

  validates :profile, length: { maximum: 160,
                                massage: "プロフィールは160字以内で入力してください" }

  # validate :image_size

  class << self

    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost )
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def find_or_create_from_auth(auth)
      provider   = auth[:provider]
      uid        = auth[:uid]
      name       = auth[:info][:name]
      account_id = auth[:info][:nickname]
      email      = User.dummy_email(auth)
      # image      = auth[:info][:image].sub("_normal", "")

      find_or_create_by(provider: provider, uid: uid) do |user|
        user.name = name
        user.password = SecureRandom.urlsafe_base64(6)
        user.email = email
        # user.remote_image_url = image
        if User.find_by(account_id: account_id).nil?
          user.account_id = account_id
        else
          while true
            num = SecureRandom.urlsafe_base64(10)
            if User.find_by(account_id: num).nil?
              user.account_id = num
              break
            end
          end
        end
      end
    end

  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def to_param
    account_id
  end

  def validate_name?
    validate_name.in?(['true', true])
  end

  def validate_email?
    validate_email.in?(['true', true])
  end

  def validate_password?
    validate_password.in?(['true', true])
  end

  def validate_password_confirmation?
    validate_password_confirmation.in?(['true', true])
  end


  private

    def downcase_email
      email.downcase!
    end

    def downcase_nodoboid
      account_id.downcase!
    end

    def image_size
      if image.size > 5.megabytes
        error.add(:image, "画像サイズは最大5MBまで設定できます")
      end
    end

    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end
end
