class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :user
      can :read, User do |u|
        u && u == user
      end
      can :update, User do |u|
        u && u == user
      end
      can :destroy, User do |u|
        u && u == user
      end
    else
      can :create, User
    end
  end
end
