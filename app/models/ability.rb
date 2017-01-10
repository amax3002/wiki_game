class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.id
      can :create, Game
      can :manage, User, id: user.id
      can :create, Move
      can :create, Player
      can :manage, Challenge
      can :read, Wiki
      can :read, Game
    else
      can :read, Game, only: :index
      can :read, Leaderboard
    end
  end
end
