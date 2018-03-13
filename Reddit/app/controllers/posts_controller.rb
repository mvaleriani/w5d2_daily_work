class PostsController < ApplicationController
  before_action :require_log_in

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.sub_id = params[:sub_id]
    @post.author_id = current_user.id

    if @post.save
      params[:sub][:cross_posts].each do |sub|
        PostSub.create!(post: @post, sub: Sub.find(sub.to_i))
      end
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub)
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :cross_subs)
  end
end
