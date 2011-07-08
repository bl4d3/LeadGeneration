class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :rpx_connectable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :displayName, :info
  before_create :set_role
  
  validates :displayName, :presence => true
  
  has_many :questions
  has_many :companies
  has_many :posts
  
  ROLES = %w[admin company guest]
  
  def role?(r)
      unless role.blank?
        role.downcase == r.to_s.downcase
      end
  end
  
  def before_rpx_success(rpx_user)
    
    rpx_user["verifiedEmail"].blank? ? rpx_email = rpx_user["email"] : rpx_email = rpx_user["verifiedEmail"]  
    update_attribute(:email, rpx_email) unless rpx_email.blank?
    
    ["url", "providerName","photo", "address", "displayName"].each do |prop|
      update_attribute(prop, rpx_user["#{prop}"]) unless rpx_user["#{prop}"].blank?
    end
    
  end
  
  def before_rpx_auto_create(rpx_user)
    
    rpx_user["verifiedEmail"].blank? ? rpx_email = rpx_user["email"] : rpx_email = rpx_user["verifiedEmail"]  
      unless rpx_email.blank?
      User.where(:email => rpx_email.to_s).each{|u|
        logger.info "\n removing... #{u.email}\n" 
        u.destroy
      }
      update_attribute(:email, rpx_email) 
    end    
    ["url", "providerName","photo", "address", "displayName"].each do |prop|
      update_attribute(prop, rpx_user["#{prop}"]) unless rpx_user["#{prop}"].blank?
    end
    
    update_attribute(:role, "guest")
  end
  
  def set_role
    self.role = "company"
  end
  
end
