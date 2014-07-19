class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :omniauthable

  before_create :set_default_role

  scope :with_role, lambda{ |role| joins(:roles).where(:roles => {:internal_name => role.to_s}) }

  has_and_belongs_to_many :roles

  def has_role?(role)
    roles.include? Role.find_by_internal_name(role.to_s)
  end


  def self.find_for_github_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create( email: data["email"],
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
