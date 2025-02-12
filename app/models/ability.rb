# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.nil?

    return unless user.technician?
    can :read, :all

    return unless user.supervisor?
    can :manage, :all
  end
end
