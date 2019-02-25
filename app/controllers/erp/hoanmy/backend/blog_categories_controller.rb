module Erp
  module Hoanmy
    module Backend
      class BlogCategoriesController < Erp::Backend::BackendController
        before_action :set_blog_category, only: [:move_up, :move_down, :show, :edit, :update, :destroy]
    
        # GET /blog_categories
        def list
          @blog_categories = BlogCategory.search(params).paginate(:page => params[:page], :per_page => 20)
          
          render layout: nil
        end
        
        # GET /blog_categories/new
        def new
          @blog_category = BlogCategory.new
          
          if request.xhr?
            render '_form', layout: nil, locals: {blog_category: @blog_category}
          end
        end
    
        # GET /blog_categories/1/edit
        def edit
        end
        
        # POST /blog_categories
        def create
          @blog_category = BlogCategory.new(blog_category_params)
          @blog_category.creator = current_user
          
          if @blog_category.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @blog_category.name,
                value: @blog_category.id
              }
            else
              redirect_to erp_hoanmy.edit_backend_blog_category_path(@blog_category), notice: t('.success')
            end
          else
            if params.to_unsafe_hash['format'] == 'json'
              render '_form', layout: nil, locals: {blog_category: @blog_category}
            else
              render :new
            end            
          end
        end
    
        # PATCH/PUT /blog_categories/1
        def update
          if @blog_category.update(blog_category_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @blog_category.name,
                value: @blog_category.id
              }
            else
              redirect_to erp_hoanmy.edit_backend_blog_category_path(@blog_category), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /blog_categories/1
        def destroy
          @blog_category.destroy
          
          respond_to do |format|
            format.html { redirect_to erp_hoanmy.backend_blog_categories_path, notice: t('.success') }
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
              render json: BlogCategory.dataselect(params[:keyword])
            }
          end
        end
        
        # Move up /blog_categories/up?id=1
        def move_up
          @blog_category.move_up

          respond_to do |format|
          format.json {
            render json: {
            }
          }
          end
        end

        # Move down /blog_categories/up?id=1
        def move_down
          @blog_category.move_down

          respond_to do |format|
          format.json {
            render json: {
            }
          }
          end
        end
        
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_blog_category
            @blog_category = BlogCategory.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def blog_category_params
            params.fetch(:blog_category, {}).permit(:name, :description, :parent_id)
          end
        
      end
    end
  end
end