class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    else user.regular?
      can :read, User
    end
  end
end
