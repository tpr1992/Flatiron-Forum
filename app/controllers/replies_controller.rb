class RepliesController < ApplicationController

  def index
    @replies = Reply.all.order(updated_at: :desc)
    @posts = Post.all.order(updated_at: :desc)
  end

  def show
    @reply = Reply.find(params[:id])
    @reply.post .order(updated_at: :desc)
  end

  def new
    # byebug
    @reply = Reply.new
  end

  def create
    # byebug
    @reply = Reply.new(content: params[:content], post_id: params[:post_id], user_id: @logged_in_user.id)
    @reply.save
    if @reply.valid?
      redirect_to post_path(@reply.post_id)
    else
      render :new
    end
  end

  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy

    # redirect_to post_path(@reply.post_id)
    # Use this redirect_back Reloads current page after deletion
    redirect_back(fallback_location: root_path)
  end


  private

  def reply_params(*args)
    params.require(:reply).permit(*args)
  end

end
