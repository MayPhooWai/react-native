class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  def index
    if params[:keyword]
      @search_keyword = params[:keyword]
      @posts = Post.where("title LIKE :title or details LIKE :cont",
                            { :title => "%#{@search_keyword}%", :cont => "%#{@search_keyword}%" })
      render json: @posts
    else
      @posts = Post.all
      render json: @posts
    end
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end
  # function import_csv
  # create posts by csv
  # @return [<Type>] <redirect>
  def import_csv
    if (params[:file].nil?)
      redirect_to posts_path, notice: :CSV_FILE_IS_REQUIRED
    elsif !File.extname(params[:file]).eql?(".csv")
      redirect_to posts_path, notice: :WRONG_FILE_TYPE
    else
      error = PostsHelper.check_header(Constants::POST_CSV_FORMAT_HEADER, params[:file])
      if error.present?
        redirect_to posts_path, notice: error
      else
        file_result = Post.import(params[:file])
        if (file_result == true)
          redirect_to posts_path, notice: :FILE_UPLOADED_SUCCESSFULLY
        else
          redirect_to posts_path, notice: file_result
        end
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :details)
    end
end
