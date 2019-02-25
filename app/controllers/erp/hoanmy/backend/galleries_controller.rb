module Erp
  module Hoanmy
    module Backend
      class GalleriesController < Erp::Backend::BackendController
        before_action :set_gallery, only: [:move_up, :move_down, :show, :edit, :update, :destroy]
    
        # GET /galleries
        def list
          @galleries = Gallery.search(params).paginate(:page => params[:page], :per_page => 20)
          
          render layout: nil
        end
        
        # GET /galleries/new
        def new
          @gallery = Gallery.new
          
          20.times do
            @gallery.gallery_images.build
          end
          
          if request.xhr?
            render '_form', layout: nil, locals: {gallery: @gallery}
          end
        end
    
        # GET /galleries/1/edit
        def edit
          (20 - @gallery.gallery_images.count).times do
            @gallery.gallery_images.build
          end
        end
        
        # POST /galleries
        def create
          @gallery = Gallery.new(gallery_params)
          @gallery.creator = current_user
          
          20.times do
            @gallery.gallery_images.build
          end

          if @gallery.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @gallery.name,
                value: @gallery.id
              }
            else              
              redirect_to erp_hoanmy.edit_backend_gallery_path(@gallery), notice: t('.success')
            end
          else
            if params.to_unsafe_hash['format'] == 'json'
              render '_form', layout: nil, locals: {gallery: @gallery}
            else
              render :new
            end            
          end
        end
    
        # PATCH/PUT /galleries/1
        def update
          if @gallery.update(gallery_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @gallery.name,
                value: @gallery.id
              }
            else
              redirect_to erp_hoanmy.edit_backend_gallery_path(@gallery), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /galleries/1
        def destroy
          @gallery.destroy
          
          respond_to do |format|
            format.html { redirect_to erp_hoanmy.backend_galleries_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        # Move up /galleries/up?id=1
        def move_up
          @gallery.move_up

          respond_to do |format|
          format.json {
            render json: {
            }
          }
          end
        end

        # Move down /galleries/up?id=1
        def move_down
          @gallery.move_down

          respond_to do |format|
          format.json {
            render json: {
            }
          }
          end
        end
        
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_gallery
            @gallery = Gallery.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def gallery_params
            params.fetch(:gallery, {}).permit(:name, :description,
                                              :gallery_images_attributes => [:id, :image_url, :image_url_cache, :gallery_id, :_destroy])
          end
      end
    end
  end
end