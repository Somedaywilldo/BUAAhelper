class User < ApplicationRecord
  

  #before_save { email.downcase! }#回调
  
  attr_accessor :remember_token, :activation_token 
  before_save :downcase_email
  before_create :create_activation_digest
  
  validates :name, presence: true, length: { maximum: 50 } 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i 
  validates :email, presence: true, length: { maximum: 255 },
                        format:     { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
  has_secure_password #这一命令将会验证密码是否为空
  #validates :password, presence: true, length: { minimum: 6 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  has_many :microposts, dependent: :destroy
  


  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost) 
  end
  
  def self.new_token
    SecureRandom.urlsafe_base64 
  end 
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost) 
  end
  
  # 返回一个随机令牌 
  def User.new_token
    SecureRandom.urlsafe_base64 
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token)) 
  end
  
  
  class << self
    # 返回指定字符串的哈希摘要 
    def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost) 
    end
    # 返回一个随机令牌 
    def new_token
      SecureRandom.urlsafe_base64 
    end
  end
  
# 如果指定的令牌和摘要匹配,返回 true 
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
# 忘记用户 
  def forget
    update_attribute(:remember_digest, nil) 
  end
  
    
  def feed
    Micropost.where("user_id = ?", id) 
  end
  
  # 激活账户 
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end
  # 发送激活邮件  
  def send_activation_email
    UserMailer.account_activation(self).deliver_now 
  end
  
  
  private
    def downcase_email
      self.email = email.downcase
    end
  # 创建并赋值激活令牌和摘要 
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token) 
    end
end
