class CommentsController < ApplicationController
  before_filter :login_required, :only => [:destroy, :edit]

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
		#TODO: validate errors catch in partial
    @comment = Comment.new(params[:comment])
    respond_to do |format|
      if @comment.save
				expire_page posts_path
				@saved = true
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to @comment.post }
				format.js
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
				@saved = false
				flash[:error] = "Content can not be empty"
        format.html {  redirect_to @comment.post }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
				format.js
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to @comment.post }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
		expire_page posts_path

    respond_to do |format|
      format.html { redirect_to @comment.post }
      format.xml  { head :ok }
    end
  end
end
