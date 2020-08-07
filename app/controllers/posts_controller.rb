class PostsController < ApplicationController

  def index
    @posts = Post.all
    @authors = Author.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params.require(:post))
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end

  # app/controllers/posts_controller.rb

def index
  # provide a list of authors to the view for the filter control
  @authors = Author.all

  # filter the @posts list based on user input
  if !params[:author].blank?
    @posts = Post.where(author: params[:author])
  elsif !params[:date].blank?
    if params[:date] == "Today"
      @posts = Post.where("created_at >=?", Time.zone.today.beginning_of_day)
    else
      @posts = Post.where("created_at <?", Time.zone.today.beginning_of_day)
    end
  else
    # if no filters are applied, show all posts
    @posts = Post.all
  end
end
end
