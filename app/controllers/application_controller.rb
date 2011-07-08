class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
  
  def after_sign_in_path_for(resource)
      logger.info "\n ...... #{current_user.role}\n"
      if !current_user.role?(:guest)
        stored_location_for(resource) || companies_path
      else
        if cookies[:question_id].blank? && cookies[:post_id].blank?
          # no cookie? rediret to new question page
          @container = Container.where(:place_holder => "new_question").first
          @question = Question.new
          stored_location_for(resource) || frontend_path(Container.where(:place_holder => "new_question").first)
        else
          if !cookies[:question_id].blank?
            # redirect to question page
            @question = Question.find(cookies[:question_id].to_i)
            stored_location_for(resource) || frontend_question_question_path(@question)
          elsif !cookies[:post_id].blank?
            # redirect to question page
            @post = Post.find(cookies[:post_id].to_i)
            stored_location_for(resource) || blog_post_frontend_path(@post)
          end
          
        end
      end
  end
  

  private

    def layout
        # only turn it off for login pages:
        #is_a?(Devise::SessionsController) ? "companies" : "companies"
        logger.info "\n  --> #{params[:action]} \n"
        if is_a?(Devise::SessionsController) || is_a?(Devise::RegistrationsController) || is_a?(Devise::PasswordsController)|| is_a?(Devise::UsersController)
          if ["new", "create"].include?(params[:action])
            @container = Container.first
            "user"
          else
            "companies"            
          end
        else 
          "companies"           
        end
        
        # or turn layout off for every devise controller:
        # devise_controller? && "application"
    end

end
