class PostsController < ApplicationController
  load_and_authorize_resource
  uses_tiny_mce(:options => AppConfig.default_mce_options)
	layout "companies"
  # GET /posts
  # GET /posts.xml
  def index
    
    #@posts = Post.order(:created_at).page params[:page]
    
    @posts = Post.all(current_user)
    @posts = Kaminari.paginate_array(@posts).page(params[:page])
    logger.info "\n size #{@posts.size}\n"
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id unless current_user.blank?

    respond_to do |format|
      if @post.save
        if SEND_MAIL && current_user.role?(:company)
          args = [MAIL_TO,MAIL_FROM,"[ADMIN] Nuovo post","<h1>TITLE</h1>#{@post.title}<h1>BODY</h1>#{@post.body}<h1>USER</h1>#{@post.user.email}"]
          QueuedEmails.add("Notification","notify_raw", args, 0)
        end
        
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
end
