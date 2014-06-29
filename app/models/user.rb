class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :omniauthable,
         :authentication_keys => [:login]

  validates :username, presence: true, uniqueness: {
    case_sensitive: false
  }

  before_create :set_default_role

  scope :with_role, lambda{ |role| joins(:roles).where(:roles => {:internal_name => role.to_s}) }

  has_and_belongs_to_many :roles

  attr_accessor :login

  def has_role?(role)
    roles.include? Role.find_by_internal_name(role.to_s)
  end

  def admin?
    has_role? :admin
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.find_for_github_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.find_by_email(data["email"])

    unless user
      user = User.create( username: data["nickname"],
                          email: data["email"],
                          provider: access_token.provider,
                          uid: access_token.uid,
                          password: Devise.friendly_token[0,20],
                        )
    end
    user
  end

  def set_default_role
    self.roles << Role.find_by_internal_name('user')
  end

  def skip_confirmation!
    self.confirmed_at = Time.now
  end
end
