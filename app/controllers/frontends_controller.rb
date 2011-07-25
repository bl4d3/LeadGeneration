class FrontendsController < ApplicationController
  
  after_filter :cookie_qustion, :only => [:frontend_question]
  after_filter :cookie_post, :only => [:blog_post]
  layout "companies"

  def index
    @container = Container.first
    @contact = Contact.new
    render :template => "frontends/index", :layout => "layouts/frontends/index"
  end
  
  def show
    @container = Container.find(params[:id])
    @contact = Contact.new
    
    # create a new qestion
    if @container.place_holder == "new_question"
      @question = Question.new 
      cookies.delete :question_id
      cookies.delete :post_id
    end
    
    if @container.place_holder == "questions_in_relevance"
      @questions = Question.all :select => "count(*) as count, questions.id, questions.title, questions.created_at, questions.user_id ", :joins => :comments, :group => 'comments.commentable_id', :order => 'count desc', :limit => 3
    end
    
    if @container.place_holder == "user_questions"
      @questions = current_user.questions.order("created_at DESC").page(params[:page]).per(PP_QUESTIONS)
    end
    
    if @container.place_holder == "search_companies"
      @search = Company.search(params[:search])
      @search.meta_sort ||= 'created_at.desc'
      @companies = Kaminari.paginate_array(@search.all).page(params[:page]).per(PP_COMPANIES)
    end
    
    if @container.place_holder == "companies_map"
      @companies = Company.find(:all)
    end
    
    # show all question
    if @container.place_holder == "show_questions"      
      @search = Question.search(params[:search])
      @search.meta_sort ||= 'created_at.desc'
      @questions = Kaminari.paginate_array(@search.all).page(params[:page]).per(PP_QUESTIONS)
    end
    
    render :template => "frontends/#{@container.template}", :layout => "layouts/frontends/#{@container.template}"
  end
  
  
  def new_company
    @company = Company.new
    @container = Container.where(:name=>"Segnala azienda").first
    render :template => "frontends/signal_company", :layout => "layouts/frontends/signal_company"
  end
  
  def create_company
      @container = Container.where(:template => :signal_company).first
      @company = Company.new(params[:company])
      
      respond_to do |format|
        if @company.save
          if SEND_MAIL
            args = [MAIL_TO, MAIL_FROM, "[ADMIN] Nuova azienda segnalata",humanize_company(@company)]
            QueuedEmails.add("Notification","notify_raw", args, 0)
          end
          format.html { render :action => "signaled_company",:layout => "layouts/frontends/signal_company" }
        else
          format.html { render :action => "signal_company",:layout => "layouts/frontends/signal_company" }
        end
      end
  end
  
  def new_estimate
    @estimate = Estimate.new
    @container = Container.where(:name=>"Preventivi").first
    logger.info "\n container #{@container.id}\n"
    render :template => "frontends/estimate", :layout => "layouts/frontends/estimate"
  end
  
  def create_estimate
      @container = Container.where(:template => :estimate).first
      @estimate = Estimate.new(params[:estimate])
      
      respond_to do |format|
        if @estimate.save
          if SEND_MAIL
            args = [MAIL_TO,MAIL_FROM,"[ADMIN] Richiesta di preventivo",humanize_estimate(@estimate)]
            QueuedEmails.add("Notification","notify_raw", args, 0)
          end
          
          if SEND_REPORT_ADMIN
            @companies = @estimate.calculate_categories
            unless @companies.blank?
              
              if SEND_MAIL
                # send email to admin
                args = [MAIL_TO,MAIL_FROM,"[ADMIN] Richiesta di preventivo","<h3>PREVENTIVO:</h3>#{humanize_estimate(@estimate)}<br/><br/><h3>DA SPEDIRE A:</h3>#{humanize_companies(@companies)}"]
                QueuedEmails.add("Notification","notify_raw", args, 0)
                # send email to company
                @companies.each do |company|
                  args = [company.email_address,MAIL_FROM,"[MatrimonioIdee] Richiesta di preventivo","#{humanize_estimate(@estimate)}"]
                  QueuedEmails.add("Notification","estimate_request", args, 0)
                end
                
              end
            else
              logger.info "\n --- no companies \n"
            end
          end
          
          format.html { render :action => "estimated",:layout => "layouts/frontends/estimate" }
        else
          format.html { render :action => "estimate",:layout => "layouts/frontends/estimate" }
        end
      end
  end
  
  def create_question
    @question = Question.new(params[:question])
    
    respond_to do |format|
      if @question.save
        if SEND_MAIL
          args = [MAIL_TO,MAIL_FROM,"[ADMIN] Nuova domanda","#{@question.title}<br>#{@question.body}"]
          QueuedEmails.add("Notification","notify_raw", args, 0)
        end
        @container = Container.where(:place_holder => "created_question").first
        #format.html { render :template => "frontends/#{@container.template}", :layout => "layouts/frontends/#{@container.template}" }    
        format.html { redirect_to frontend_question_question_path(@question) }
      else
        @container = Container.where(:place_holder => "new_question").first
        format.html { render :template => "frontends/questions",:layout => "layouts/frontends/#{@container.template}" }
      end
    end
  end
  
  def create_reply
    @question = Question.find(params[:id])
    commentable = @question.comments.new(params[:comment])
    
    @container = Container.where(:place_holder => "show_question").first
    
    
      if commentable.save
        @comment = Comment.new
        if SEND_MAIL
          args = [MAIL_TO,MAIL_FROM,"[ADMIN] Domanda commentata","#{@question.title}<br>#{@question.body}<h3>COMMENTO:</h3>#{commentable.title}<br/>#{commentable.comment}"]
          QueuedEmails.add("Notification","notify_raw", args, 0)
          
          args = [@question.user.email,MAIL_FROM,"[MatrimonioIdee.it] Risposta alla domanda #{@question.title}","#{@question.id}"]
          QueuedEmails.add("Notification","reply_to_question", args, 0)
          
        end
        redirect_to frontend_question_question_path(@question) 
      else
        @comment = commentable
        respond_to do |format|
          format.html { render :template => "frontends/blog_post", :layout => "layouts/frontends/blog" }
        end
      end
  end  
  
  def create_blog_reply
    @post = Post.find(params[:id])
    commentable = @post.comments.new(params[:comment])
    
    @container = Container.where(:place_holder => "show_question").first
    @contact = Contact.new
    
      if commentable.save
        @comment = Comment.new
        if SEND_MAIL
          args = [MAIL_TO,MAIL_FROM,"[ADMIN] Post commentato","#{@post.title}<br>#{@post.intro}<h3>COMMENTO:</h3>#{commentable.title}<br/>#{commentable.comment}"]
          QueuedEmails.add("Notification","notify_raw", args, 0)
        end
          
        render :template => "frontends/blog_post", :layout => "layouts/frontends/blog"
        
      else
        @comment = commentable
        render :template => "frontends/blog_post", :layout => "layouts/frontends/blog"
      end
  end
  
  # show all the companies associated at the category
  def category_frontend
    @category = Category.find(params[:id])
    @companies = @category.companies.where(:is_enabled => 1).order(:name).page(params[:page]).per(10)
    @contact = Contact.new
    logger.info "\n --> #{@category.companies.size}\n"
    # TODO select the right container
    render :template => "frontends/dir_companies", :layout => "layouts/frontends/index"
  end
  
  #show a specified company
  def frontend_company
    @company = Company.find(params[:id])
    @contact = Contact.new
    render :template => "frontends/frontend_company", :layout => "layouts/frontends/index"
  end
  
  # show question
  def frontend_question
    @question = Question.find(params[:id])
    @question.hit_one
    @comment = Comment.new
    @container = Container.where(:place_holder => "show_question").first
    render :template => "frontends/#{@container.template}", :layout => "layouts/frontends/#{@container.template}"
  end
  
  # show all the posts
  def blog
    @container = Container.where(:name => "Blog").first
    @posts = Post.where(:is_public => 1).page(params[:page])
    @posts= @posts.order("created_at DESC")
     
    @contact = Contact.new
    render :template => "frontends/blog", :layout => "layouts/frontends/blog"
  end
  
  # show a specified post
  def blog_post
    @post = Post.find(params[:id])
    @post.hit_one
    @contact = Contact.new
    @comment = Comment.new
    render :template => "frontends/blog_post", :layout => "layouts/frontends/blog"
  end
  
  # show posts by specified argument
  def blog_argument
    @container = Container.where(:name => "Blog").first
    @argument = Argument.find(params[:id])
    @posts = @argument.posts.where(:is_public => 1).page(params[:page])
    
    @contact = Contact.new
    render :template => "frontends/blog", :layout => "layouts/frontends/blog"
  end
  
  def create_contact
    @contact = Contact.new(params[:contact])
    if SEND_MAIL
      args = [MAIL_TO,MAIL_FROM,"[ADMIN] Nuovo contatto per newsletter","#{@contact.email}"]
      QueuedEmails.add("Notification","notify_raw", args, 0)
    end    
    @container = Container.first
  end
  
  def sitemap
    @containers = Container.where(:is_public => 1)
    @posts = Post.where(:is_public => 1)
    @categories = Category.all
    @companies = Company.where(:is_enabled => 1)
    @questions = Question.all
  end
  
  def blogfeed
    @posts = Post.where(:is_public => 1)
  end
  
  # set cookie to redirect at question page after login process
  def cookie_qustion
    cookies.delete :post_id
    cookies[:question_id] = @question.id
  end

  def cookie_post
    cookies.delete :question_id
    cookies[:post_id] = @post.id
  end
  
  def send_mail
    QueuedEmails.send_email
    render :inline => ""
  end
  
  def aggregator_show
    @company = Company.find(params[:id])
  end
  
  
  def search_on_map
    if !params[:companies].blank? && !params[:companies][:category_ids].blank?
      @companies = Company.includes(:categories).where(:is_enabled => 1, :categories => {:id=>params[:companies][:category_ids]}).near(params[:company][:city_name],70)
    else
      @companies = Company.where(:is_enabled => 1).near(params[:company][:city_name],70)
    end
    
	  render :update do |page|
	    if !@companies.blank?
  		  page << " Gmaps4Rails.replace_markers(#{@companies.to_gmaps4rails}); "
  		  page << "$('#company_detail').html('')"
  		  page << "$('#error_search').html('')"
  		  page << "$('html,body').animate({scrollTop: $('#maps_aggregator_anchor').offset().top},'slow');"
  			
		  else
		    page << "$('#error_search').html('<h2>Oops! Nessuna azienda trovata in questa citt&agrave;</h2>')"
	    end
  	end
  end
  
  def public_geocode
    Company.find(:all).each do |c|
	    if c.latitude.blank? and c.longitude.blank?
        geo=c.geocode
        unless geo.blank?
          c.update_attribute(:latitude, geo[0])
          c.update_attribute(:longitude, geo[1])
        end
      end
    end
    render :inline => ""
  end
  
end
