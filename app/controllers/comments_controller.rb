class CommentsController < ApplicationController
  before_filter :login_required, :only => [:destroy, :edit, :update]

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(params[:comment])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.post, :notice => t("flash.comments.create.notice") }
        format.js
      else
        format.html { redirect_to @comment.post }
        format.js
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to @comment.post, :notice => t{"flash.comments.update.notice"}
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @comment.post
  end
end
