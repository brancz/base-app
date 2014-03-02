class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  scope :with_role, lambda{ |role| joins(:roles).where(:roles => {:internal_name => role.to_s}) }

  has_and_belongs_to_many :roles

  def has_role?(role)
    roles.include? Role.find_by_internal_name(role.to_s)
  end
end
