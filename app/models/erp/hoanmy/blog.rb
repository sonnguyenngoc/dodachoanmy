module Erp::Hoanmy
  class Blog < ApplicationRecord
		mount_uploader :image_url, Erp::Hoanmy::BlogUploader
		
    belongs_to :creator, class_name: "Erp::User"
    belongs_to :blog_category, class_name: "Erp::Hoanmy::BlogCategory"
    validates :name, :presence => true
    
    include Erp::CustomOrder
    
    after_create :create_alias
    
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
      
      # join with categories table for search with category
      query = query.joins(:blog_category)
      
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
    
    # data for dataselect ajax
    def self.dataselect(keyword='')
      query = self.all
      
      if keyword.present?
        keyword = keyword.strip.downcase
        query = query.where('LOWER(name) LIKE ?', "%#{keyword}%")
      end
      
      query = query.limit(20).map{|blog| {value: blog.id, text: blog.name} }
    end
    
    def self.get_blogs(params)
			query = self.all
			query = query.order('erp_hoanmy_blogs.created_at DESC')
    end
    
    def blog_category_id
      blog_category.present? ? blog_category.id : ''
    end

    def blog_category_name
      blog_category.present? ? blog_category.name : ''
    end
    
  end
end
