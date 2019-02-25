module Erp
  module Hoanmy
    module Backend
      class BlogsController < Erp::Backend::BackendController
        before_action :set_blog, only: [:move_up, :move_down, :show, :edit, :update, :destroy]
    
        # GET /blogs
        def list
          @blogs = Blog.search(params).paginate(:page => params[:page], :per_page => 20)
          
          render layout: nil
        end
        
        # GET /blogs/new
        def new
          @blog = Blog.new
          
          if request.xhr?
            render '_form', layout: nil, locals: {blog: @blog}
          end
        end
    
        # GET /blogs/1/edit
        def edit
        end
        
        # POST /blogs
        def create
          @blog = Blog.new(blog_params)
          @blog.creator = current_user

          if @blog.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @blog.name,
                value: @blog.id
              }
            else              
              redirect_to erp_hoanmy.edit_backend_blog_path(@blog), notice: t('.success')
            end
          else
            if params.to_unsafe_hash['format'] == 'json'
              render '_form', layout: nil, locals: {blog: @blog}
            else
              render :new
            end            
          end
        end
    
        # PATCH/PUT /blogs/1
        def update
          if @blog.update(blog_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @blog.name,
                value: @blog.id
              }
            else
              redirect_to erp_hoanmy.edit_backend_blog_path(@blog), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /blogs/1
        def destroy
          @blog.destroy
          
          respond_to do |format|
            format.html { redirect_to erp_hoanmy.backend_blogs_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        def dataselect
          respond_to do |format|
            format.json {
              render json: Blog.dataselect(params[:keyword])
            }
          end
        end
        
        # Move up /blogs/up?id=1
        def move_up
          @blog.move_up

          respond_to do |format|
          format.json {
            render json: {
            }
          }
          end
        end

        # Move down /blogs/up?id=1
        def move_down
          @blog.move_down

          respond_to do |format|
          format.json {
            render json: {
            }
          }
          end
        end
        
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_blog
            @blog = Blog.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def blog_params
            params.fetch(:blog, {}).permit(:image_url, :name, :content, :meta_keywords, :meta_description, :blog_category_id)
          end
      end
    end
  end
end