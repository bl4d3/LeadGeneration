class DeliversController < ApplicationController
  load_and_authorize_resource
  layout 'companies'
  # GET /delivers
  # GET /delivers.xml
  def index
    #@delivers = Deliver.all
    @search = Deliver.where(:company_id => params[:company_id]).search(params[:search])
    
    @search.meta_sort ||= 'created_at.desc'
    @delivers = Kaminari.paginate_array(@search.all).page(params[:page])
    
    logger.info "\nindex\n"
  end

  # GET /delivers/1
  # GET /delivers/1.xml
  def show
    @deliver = Deliver.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @deliver }
    end
  end

  # GET /delivers/new
  # GET /delivers/new.xml
  def new
    @deliver = Deliver.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deliver }
    end
  end

  # GET /delivers/1/edit
  def edit
    @deliver = Deliver.find(params[:id])
  end

  # POST /delivers
  # POST /delivers.xml
  def create
    @deliver = Deliver.new(params[:deliver])

    respond_to do |format|
      if @deliver.save
        format.html { redirect_to(@deliver, :notice => 'Deliver was successfully created.') }
        format.xml  { render :xml => @deliver, :status => :created, :location => @deliver }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @deliver.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /delivers/1
  # PUT /delivers/1.xml
  def update
    @deliver = Deliver.find(params[:id])

    respond_to do |format|
      if @deliver.update_attributes(params[:deliver])
        format.html { redirect_to(@deliver, :notice => 'Deliver was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @deliver.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /delivers/1
  # DELETE /delivers/1.xml
  def destroy
    @deliver = Deliver.find(params[:id])
    @deliver.destroy

    respond_to do |format|
      format.html { redirect_to(delivers_url) }
      format.xml  { head :ok }
    end
  end
end
