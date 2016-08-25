class Article < ApplicationRecord
	belongs_to :user
	has_many :comments
	validates :title, presence: true, uniqueness: true
	validates :body, presence:true, length: {minimum: 20}
    after_create :save_categories
    
    def categories=(value)
        @categories = value
    end
    
	#validates :username, format: {with: expresion refular}
	before_create :set_visits_count
	#before_save
	#before_validation
	#after_create
    
    has_attached_file :cover, styles: { medium: "1280x720", thumb:"800x600" }
    
    validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/
    
   
    
    def save_categories
        @categories.each do |category_id|
           HasCategory.create(category_id: category_id, article_id: self.id)
        end
#        raise @categories.to_yaml
    end
        
	def update_visits_count
		self.update(visits_count: self.visits_count + 1)		
	end

	private
	def set_visits_count
		self.visits_count = 0;
	end
end
