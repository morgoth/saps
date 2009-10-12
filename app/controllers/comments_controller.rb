class CommentsController < ApplicationController
  before_filter :login_required, :only => [:destroy, :edit, :update]

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(params[:comment])
    respond_to do |format|
      if @comment.save
        @saved = true
        flash[:notice] = t("controllers.comment_created")
        format.html { redirect_to @comment.post }
        format.js
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        @saved = false
        format.html {  redirect_to @comment.post }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = t("controllers.comment_updated")
        format.html { redirect_to @comment.post }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @comment.post }
      format.xml  { head :ok }
    end
  end
end
