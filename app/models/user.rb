class User < ApplicationRecord

  attr_accessor :validate_name, :validate_email, :validate_password,
                :remember_token, :reset_token

  before_save :downcase_email, if: :validate_email?
  before_save :downcase_nodoboid

  mount_uploader :image, ImageUploader

  #自分が開いたリスト
  has_many :create_lists, class_name: "List"

  #便乗リスト
  has_many :mylists, dependent: :destroy
  has_many :lists,   through: :mylists

  has_many :posts,   dependent: :destroy

  validates :name, presence: { message: "名前を入力してください" },
                   length:   { maximum: 50,
                               message: "名前は50文字以内まで有効です",
                               allow_blank: true },
                   if: :validate_name?

  VALID_MYSIZE_ID_REGIX = /\A[a-zA-Z0-9_]+\z/
  validates :account_id, presence:   { message: "nodopouIDを入力してください" },
                         length:     { maximum: 15,
                                       message: "nodopouIDは15文字以内まで有効です" },
                         format:     { with: VALID_MYSIZE_ID_REGIX,
                                       message: "nodopouIDは英数字,_(アンダーバー)のみ使用できます",
                                       allow_blank: true },
                         uniqueness: { case_sensitive: false,
                                       message: "そのnodopouIDは既に使われています",
                                       allow_nil: true }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   { message: "メールアドレスを入力してください" },
                    length:     { maximum: 255,
                                  message: "メールアドレスは255文字以内まで有効です" },
                    format:     { with: VALID_EMAIL_REGEX,
                                  message: "そのメールアドレスは不正な値を含んでいます",
                                  allow_blank: true },
                    uniqueness: { case_sensitive: false,
                                  message: "そのメールアドレスは既に登録されています" },
                    if: :validate_email?

  has_secure_password validations: false

  validates :password, presence:     { message: "Passwordを入力してください",
                                       on: :create },
                       length:       { minimum: 6,
                                       message: "Passwordは6文字以上で入力してください",
                                       allow_blank: true },
                       confirmation: { message: "PasswordとPassword確認が不一致です",
                                       allow_blank: true },
                       if: :validate_password?

  validates :profile, length: { maximum: 160,
                                massage: "プロフィールは160字以内で入力してください" }

  validate :image_size

  class << self

    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost )
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def new_reset_token
      SecureRandom.uuid
    end

    def find_or_create_from_auth(auth)
      provider   = auth[:provider]
      uid        = auth[:uid]
      name       = auth[:info][:name]
      account_id = auth[:info][:nickname]
      email      = User.dummy_email(auth)
      profile    = auth[:info][:description]
      image      = auth[:info][:image].sub("_normal", "")
      t_token    = auth[:credentials][:token]
      t_secret   = auth[:credentials][:secret]

      find_or_create_by(provider: provider, uid: uid) do |user|
        user.name             = name
        user.password         = SecureRandom.urlsafe_base64(6)
        user.email            = email
        user.profile          = profile
        user.remote_image_url = image
        user.t_token          = user.secure_for(t_token, uid)
        user.t_secret         = user.secure_for(t_secret, uid)
        user.t_url            = "https://twitter.com/" + account_id

        if User.find_by(account_id: account_id).nil?
          user.account_id     = account_id
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

    def search(keyword)
      if keyword
        keyword_ary = keyword.downcase.split(/[\s　]+/)
        condition = where(["lower(name) LIKE (?) OR lower(account_id) LIKE (?)",
                    "%#{keyword_ary[0]}%", "%#{keyword_ary[0]}%"])
        for i in 1..(keyword_ary.length - 1) do
          condition = condition.where(["lower(name) LIKE (?) OR lower(account_id) LIKE (?)",
                                "%#{keyword_ary[i]}%", "%#{keyword_ary[i]}%"])
        end
        condition
      else
        all
      end
    end

  end

  def update_from_auth(auth)
    provider   = auth[:provider]
    uid        = auth[:uid]
    account_id = auth[:info][:nickname]
    t_token    = auth[:credentials][:token]
    t_secret   = auth[:credentials][:secret]

    update_columns(provider: provider,
                   uid:      uid,
                   t_token:  self.secure_for(t_token, uid),
                   t_secret: self.secure_for(t_secret, uid),
                   t_url:    "https://twitter.com/" + account_id)
  end

  def to_param
    account_id
  end

  ["name", "email", "password"].each do |param|
    class_eval <<-EOS
      def validate_#{param}?
        validate_#{param}.in?(['true', true])
      end
    EOS
  end

  def set_name(param)
    self.name = param
  end

  def set_pass_and_time(password, time)
    if time.nil?
      password_confirmation = password
      check_reset_at = Time.zone.now.beginning_of_day + 1.day + 6.hours
    else
      unless password.nil?
        validate_password = true
        password_confirmation = password
      end

      time = time.to_i
      if time != self.check_reset_time
        check_reset_at = self.check_reset_at.beginning_of_day + time.hours
      end
    end
  end

  def check_blank(params)
    check_params = [params[:account_id], params[:name], params[:email]]
    if check_params.include?("")
      self.reload
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

  def send_email(subject)
    mail = UserMailer.send("#{subject}", self)
    mail.transport_encoding = "8bit"
    mail.deliver_now
  end

  def create_reset_digest_and_etoken
    self.reset_token = User.new_reset_token
    update_columns(reset_digest:  User.digest(reset_token),
                   e_token:       User.digest(email),
                   reset_sent_at: Time.zone.now)
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def avail(list)
    mylists.create(list_id: list.id)
    list.joined_user
  end

  def unavail(list)
    mylists.find_by(list_id: list.id).destroy
    list.leaved_user
  end

  #SQL文が発行され過ぎるため、seedにのみ使用
  def availing?(list)
    mylists.pluck(:list_id).include?(list.id)
  end

  def update_check_reset
    update_attribute(:check_reset_at,
                     Time.zone.now.beginning_of_day +
                     1.day + self.check_reset_time.hours)
  end
  

  def confirm_and_reset_check_of(mylists)
    if self.check_reset_at < Time.zone.now

      mylists ||= self.mylists.includes(:list)

      if mylists.any?
        Mylist.transaction do
          mylists.each do |mylist|
            if mylist.check? && self.check_reset_at + 1.day > Time.zone.now 
              mylist.add_running_days_and_reset_check
            else
              mylist.reset_running_days
            end
          end
        end
      end

      self.update_check_reset
    end
  end

  def secure_for(string, uid)
    space = uid.length + 1
    n = space + uid.to_i % (string.length - space)
    char = SecureRandom.hex(1)[0]
    string.insert(n, char)
  end

  def unlock_for(string, uid)
    space = uid.length + 1
    n = space + uid.to_i % (string.length - space - 1)
    string.slice(0..(n - 1)) + string.slice((n + 1)..string.length)
  end

  def og_image_url(post_id)
    if self.posts.any? && !post_id.blank?
      post = self.posts.find_by(id: post_id)
      post.picture.url
    else
      ""
    end
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
