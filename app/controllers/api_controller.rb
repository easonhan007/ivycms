class ApiController < ActionController::API
  before_action :verify_api_key

  def create_post
    post = Post.new(post_params)
    post.is_md = true
    post.category_id = 4

    if post.save
      render json: { status: 'SUCCESS', message: 'Post created successfully', data: post }, status: :created
    else
      render json: { status: 'ERROR', message: 'Post creation failed', data: post.errors }, status: :unprocessable_entity
    end
  end

  def post_exists
    slug = slug_params[:slug]
    res = Post.where(display_title: slug).exists? 
    render json: { status: 'SUCCESS', message: 'Post created successfully', data: res }, status: :created
  end

  private
    def verify_api_key
      predefine_key = ENV["API_KEY"] || "uENDNmLWOk"
      key = params[:api_key]
      if key
        if key.strip().eql?(predefine_key)
          return true
        end #if
      end #if
      render json: {message: "FORBIDDEN"}, status: :forbidden
    end

    def post_params
      params.require(:post).permit(:title, :md_content, :desc, :image, :display_title, :content)
    end

    def slug_params
      params.require(:post).permit(:slug)
    end

end

