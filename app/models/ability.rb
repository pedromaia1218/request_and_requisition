# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.nil?

    can :manage, Request

    return if user.user?
    cannot :manage, Request
    can :attend, Request
    can :read, :all

    return unless user.supervisor?
    can :manage, :all
  end
end
