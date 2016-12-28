class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    end
    can :read, Game
    can :read, Leaderboard
    can :manage, User, id: user.id
    can :create, Game
    can :create, Move
    can :create, Player
  end
end
