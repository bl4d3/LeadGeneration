class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.role?(:admin)
      can :manage, :all
    elsif user.role?(:company)
      can [:index], Department
      can [:index, :new, :create,:autocomplete_city_name], Company
      can [:show, :edit, :update, :destroy], Company, :user_id => user.id
      can [:index, :show, :create, :new], Question
      
      # TODO set right permission
      can :index, Deliver
      
      can [:index], Post
      can [:show, :edit, :update, :create, :new], Post, :user_id => user.id
    elsif user.role?(:guest)
      can [:index, :show, :create, :new], Question
      can [:autocomplete_city_name], Company
      can [:index], Department
    else
      can [:autocomplete_city_name], Company
      can [:index], Department
    end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
