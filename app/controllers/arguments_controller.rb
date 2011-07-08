class ArgumentsController < ApplicationController
  load_and_authorize_resource
	layout "companies"
  # GET /arguments
  # GET /arguments.xml
  def index
    @arguments = Argument.order(:name).page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @arguments }
    end
  end

  # GET /arguments/1
  # GET /arguments/1.xml
  def show
    @argument = Argument.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @argument }
    end
  end

  # GET /arguments/new
  # GET /arguments/new.xml
  def new
    @argument = Argument.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @argument }
    end
  end

  # GET /arguments/1/edit
  def edit
    @argument = Argument.find(params[:id])
  end

  # POST /arguments
  # POST /arguments.xml
  def create
    @argument = Argument.new(params[:argument])

    respond_to do |format|
      if @argument.save
        format.html { redirect_to(@argument, :notice => 'Argument was successfully created.') }
        format.xml  { render :xml => @argument, :status => :created, :location => @argument }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @argument.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /arguments/1
  # PUT /arguments/1.xml
  def update
    @argument = Argument.find(params[:id])

    respond_to do |format|
      if @argument.update_attributes(params[:argument])
        format.html { redirect_to(@argument, :notice => 'Argument was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @argument.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /arguments/1
  # DELETE /arguments/1.xml
  def destroy
    @argument = Argument.find(params[:id])
    @argument.destroy

    respond_to do |format|
      format.html { redirect_to(arguments_url) }
      format.xml  { head :ok }
    end
  end
end
