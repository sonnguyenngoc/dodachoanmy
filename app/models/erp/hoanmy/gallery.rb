module Erp::Hoanmy
  class Gallery < ApplicationRecord
    belongs_to :creator, class_name: "Erp::User"
    validates :name, :presence => true
    
    include Erp::CustomOrder
    
    has_many :gallery_images, dependent: :destroy
    accepts_nested_attributes_for :gallery_images, :reject_if => lambda { |a| a[:image_url].blank? and a[:image_url_cache].blank? }, :allow_destroy => true
		
		after_create :create_alias
		after_save :destroy_images_url_nil?
		
		def destroy_images_url_nil?
			self.gallery_images.where(image_url: nil).destroy_all
		end
    
    def create_alias
			name = self.name
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
    
    def get_first_image
			if self.gallery_images.count > 0
				self.gallery_images.first.image_url
			end
		end
    
    def self.get_galleries(params)
			query = self.all
			query = query.order('erp_hoanmy_galleries.created_at DESC')
    end
  end
end
