class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
      can :access, :rails_admin
      can :dashboard 
    end
    if user.teacher?
      can :create, Section if user.created_sections.blank? || user.created_sections.last.created_at < 1.hours.ago
      can :read, Section
      can :edit, Section, user_id: user.id
      can :assign, Section, assignee_id: nil
      can :create, Modification
      can :update, Modification, user_id: user.id
    end
    if user.persisted? && user.student?
      # to prevent spam
      can :create, Section if user.created_sections.blank? || user.created_sections.last.modification 
      can [:read, :edit], Section, user_id: user.id
      can :read, Section, visiable: true
    end
    if !user.persisted?
      can :read, Section, visiable: true
    end
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
