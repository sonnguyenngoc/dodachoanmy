module Erp::Hoanmy
  class Service < ApplicationRecord
		mount_uploader :icon_url, Erp::Hoanmy::ServiceUploader
		
    validates :name, :presence => true
    belongs_to :creator, class_name: "Erp::User"
    
    include Erp::CustomOrder
    
		CONSULTANT = 'consultant'
		PROCEDURE = 'procedure'
		
		# get type method options
    def self.get_service_category_options()
      [
        {text: I18n.t('.consultant'), value: Erp::Hoanmy::Service::CONSULTANT},
        {text: I18n.t('.procedure'), value: Erp::Hoanmy::Service::PROCEDURE}
      ]
    end
    
    after_create :create_alias
    
    def create_alias
			name = self.show_name
			self.update_column(:alias, name.to_ascii.downcase.to_s.gsub(/[^0-9a-z ]/i, '').gsub(/ +/i, '-').strip)
		end
    
    def self.filter(query, params)
      params = params.to_unsafe_hash
      and_conds = []
			
			#filters
			if params["filters"].present?
				params["filters"].each do |ft|
					or_conds = []
					ft[1].each do |cond|
						# in case filter is show archived
						if cond[1]["name"] == 'show_archived'
							# show archived items
							show_archived = true
						else
							or_conds << "#{cond[1]["name"]} = '#{cond[1]["value"]}'"
						end
					end
					and_conds << '('+or_conds.join(' OR ')+')' if !or_conds.empty?
				end
			end
      
      #keywords
      if params["keywords"].present?
        params["keywords"].each do |kw|
          or_conds = []
          kw[1].each do |cond|
            or_conds << "LOWER(#{cond[1]["name"]}) LIKE '%#{cond[1]["value"].downcase.strip}%'"
          end
          and_conds << '('+or_conds.join(' OR ')+')'
        end
      end
      
      # join with users table for search creator
      query = query.joins(:creator)
      
      query = query.where(and_conds.join(' AND ')) if !and_conds.empty?
      
      return query
    end
    
    def self.get_home_consultant_services(params)
			query = self.where(is_show: true).where(category: Erp::Hoanmy::Service::CONSULTANT)
			query = query.order('erp_hoanmy_services.created_at DESC')
		end
    
    def self.get_home_procedure_services(params)
			query = self.where(is_show: true).where(category: Erp::Hoanmy::Service::PROCEDURE)
			query = query.order('erp_hoanmy_services.created_at DESC')
		end
    
    def self.get_consultant_services(params)
			query = self.where(category: Erp::Hoanmy::Service::CONSULTANT)
			query = query.order('erp_hoanmy_services.created_at DESC')
		end
    
    def self.get_procedure_services(params)
			query = self.where(category: Erp::Hoanmy::Service::PROCEDURE)
			query = query.order('erp_hoanmy_services.created_at DESC')
		end
    
    def self.search(params)
      query = self.all
      query = self.filter(query, params)
      
      # order
      if params[:sort_by].present?
        order = params[:sort_by]
        order += " #{params[:sort_direction]}" if params[:sort_direction].present?
        
        query = query.order(order)
      end
      
      return query
    end
  end
end
