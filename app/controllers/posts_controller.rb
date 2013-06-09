class PostsController < ApplicationController

  def index
    @posts = Post.professional.order("created_at DESC").page(params[:page]).per(10)
    @recent_posts = @posts.limit(10)
    @tags = Tag.professional
  end

  def personal_index
    @posts = Post.personal.order("created_at DESC").page(params[:page]).per(10)
    @recent_posts = @posts.limit(10)
    @tags = Tag.personal
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(params[:post])

    if @post.save
      flash[:notice] = "Post created!"
      redirect_to root_path
    else
      flash[:notice] = "Unable to create post."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])

    if @post.save
      flash[:notice] = "Post updated!"
      redirect_to post_path(@post)
    else
      flash[:notice] = "Unable to update post."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Post '#{@post.title}' was deleted."
    redirect_to root_path
  end
end