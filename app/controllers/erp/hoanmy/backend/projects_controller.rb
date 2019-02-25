module Erp
  module Hoanmy
    module Backend
      class ProjectsController < Erp::Backend::BackendController
        before_action :set_project, only: [:move_up, :move_down, :show, :edit, :update, :destroy]
    
        # GET /projects
        def list
          @projects = Project.search(params).paginate(:page => params[:page], :per_page => 20)
          
          render layout: nil
        end
        
        # GET /projects/new
        def new
          @project = Project.new
          
          10.times do
            @project.project_images.build
          end
          
          if request.xhr?
            render '_form', layout: nil, locals: {project: @project}
          end
        end
    
        # GET /projects/1/edit
        def edit
          (10 - @project.project_images.count).times do
            @project.project_images.build
          end
        end
        
        # POST /projects
        def create
          @project = Project.new(project_params)
          @project.creator = current_user
          
          10.times do
            @project.project_images.build
          end

          if @project.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @project.name,
                value: @project.id
              }
            else              
              redirect_to erp_hoanmy.edit_backend_project_path(@project), notice: t('.success')
            end
          else
            if params.to_unsafe_hash['format'] == 'json'
              render '_form', layout: nil, locals: {project: @project}
            else
              render :new
            end            
          end
        end
    
        # PATCH/PUT /projects/1
        def update
          if @project.update(project_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @project.name,
                value: @project.id
              }
            else
              redirect_to erp_hoanmy.edit_backend_project_path(@project), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /projects/1
        def destroy
          @project.destroy
          
          respond_to do |format|
            format.html { redirect_to erp_hoanmy.backend_projects_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        # Move up /projects/up?id=1
        def move_up
          @project.move_up

          respond_to do |format|
          format.json {
            render json: {
            }
          }
          end
        end

        # Move down /projects/up?id=1
        def move_down
          @project.move_down

          respond_to do |format|
          format.json {
            render json: {
            }
          }
          end
        end
        
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_project
            @project = Project.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def project_params
            params.fetch(:project, {}).permit(:image, :name, :content, :alias, :start_time, :investor,
                                              :address, :status, :meta_keywords, :meta_description,
                                              :project_images_attributes => [:id, :image_url, :image_url_cache, :project_id, :_destroy])
          end
      end
    end
  end
end