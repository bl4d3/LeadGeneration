class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
  
  def after_sign_in_path_for(resource)
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
  
  def humanize_estimate(estimate)
    r = "<table width='100%'>"
    r += "<tr><td width='150'>ID: </td><td>#{estimate.id}</td></tr>"
    r += "<tr><td>Nome: </td><td>#{estimate.name}</td></tr>"
    r += "<tr><td>Cognome: </td><td>#{estimate.lastname}</td></tr>"
    r += "<tr><td>Indirizzo: </td><td>#{estimate.address}</td></tr>"
    r += "<tr><td>Citt&agrave;: </td><td>#{estimate.city.name}</td></tr>"
    r += "<tr><td>E-mail: </td><td>#{estimate.email}</td></tr>"
    r += "<tr><td>Telefono: </td><td>#{estimate.phone}</td></tr>"
    r += "<tr><td>Note: </td><td>#{estimate.note}</td></tr>"
    r += "<tr><td>Categorie: </td><td>#{estimate.categories.map(&:title).join(",")}</td></tr>"
    r += "</table>"
    return r.html_safe
  end
  
  def humanize_companies(companies)
    r = "<table width='100%'>"
    r += "<tr><td>ID</td><td>NAME</td><td>SITE</td><td>EMAIL</td><td>CITY</td><td>DEPARTMENT</td><td>CATEGORIES</td><td>ZONES</td></tr>"
    companies.each do |company|
      r += "<tr>"
      r += "<td>#{company.id}</td>"
      r += "<td>#{company.name}</td>"
      r += "<td>#{company.url_site}</td>"
      r += "<td>#{company.email_address}</td>"
      r += "<td>#{company.city.name}</td>"
      r += "<td>#{company.city.department.name}</td>"
      r += "<td>#{company.categories.map(&:title).join(",")}</td>"
      r += "<td>#{company.departments.map(&:name).join(",")}</td>"
      r += "</tr>"
    end
    r += "</table>"
    return r.html_safe
  end
  
  def humanize_company(company)
    r = "<table width='100%'>"
    r += "<tr><td>ID</td><td>NAME</td><td>SITE</td><td>EMAIL</td><td>CITY</td><td>DEPARTMENT</td><td>CATEGORIES</td><td>ZONES</td></tr>"
      r += "<tr>"
      r += "<td>#{company.id}</td>"
      r += "<td>#{company.name}</td>"
      r += "<td>#{company.url_site}</td>"
      r += "<td>#{company.email_address}</td>"
      r += "<td>#{company.city.name}</td>"
      r += "<td>#{company.city.department.name}</td>"
      r += "<td>#{company.categories.map(&:title).join(",")}</td>"
      r += "<td>#{company.departments.map(&:name).join(",")}</td>"
      r += "</tr>"
    r += "</table>"
    return r.html_safe
  end
  
  private

    def layout
        # only turn it off for login pages:
        #is_a?(Devise::SessionsController) ? "companies" : "companies"
        logger.info "\n  --> #{params[:action]} \n"
        if is_a?(Devise::SessionsController) || is_a?(Devise::RegistrationsController) || is_a?(Devise::PasswordsController) || is_a?(Devise::UsersController)
          if ["new", "create"].include?(params[:action])
            @container = Container.first
            "user"
          else
            if is_a?(Devise::PasswordsController) && ["edit","update"].include?(params[:action])
              @container = Container.first              
              "user"
            else
              "companies"            
            end
          end
        else 
          "companies"           
        end
        
        # or turn layout off for every devise controller:
        # devise_controller? && "application"
    end

end
