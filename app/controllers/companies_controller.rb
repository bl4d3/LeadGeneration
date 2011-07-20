class CompaniesController < ApplicationController
  
	# AUTOCOMPLETE
	autocomplete :city, :name, :extra_data => [:created_at]
  before_filter :authenticate_user!, :except => [:index, :show, :autocomplete_city_name]
  load_and_authorize_resource
  uses_tiny_mce(:options => AppConfig.default_mce_options)
  
  layout "companies"
  
  # GET /companies
  # GET /companies.xml
  def index
    #@companies = Company.all(current_user)
    
    #@companies = Company.all(current_user)
    #@companies = Kaminari.paginate_array(@companies).page(params[:page])


    @companies = Company.all(current_user)
    @search = @companies.search(params[:search])
    @search.meta_sort ||= 'created_at.desc'
    @companies = Kaminari.paginate_array(@search.all).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.xml
  def show
    @company = Company.find(params[:id])
    @search = @company.delivers.search(params[:search])
    @search.meta_sort ||= 'created_at.desc'
    @delivers = Kaminari.paginate_array(@search.all).page(params[:page])    
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new

    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
  end

  # POST /companies
  # POST /companies.xml
  def create
    @company = Company.new(params[:company])
    logger.info "\nin controller #{params[:company][:city_id]}\n"

    respond_to do |format|
      if @company.save
        if SEND_MAIL
          args = [MAIL_TO, MAIL_FROM,"[BACKEND] Nuova azienda inserita",humanize_company(@company)]
          QueuedEmails.add("Notification","notify_raw", args, 0)
        end
        format.html { redirect_to(@company, :notice => 'Company was successfully created.') }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  def update
    @company = Company.find(params[:id])

    was_enabled = @company.is_enabled
    logger.info "\n--> was_enabled #{was_enabled}\n"
    
    respond_to do |format|
      if @company.update_attributes(params[:company])
        if !was_enabled
          if @company.is_enabled
            args = [@company.email_address,MAIL_FROM,"Abilitazione azienda su MatrimonioIdee.it","#{@company.id}"]
            QueuedEmails.add("Notification","company_enabled", args, 0)
          end
        end
        format.html { redirect_to(@company, :notice => 'Company was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.xml
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(companies_url) }
      format.xml  { head :ok }
    end
  end
end
