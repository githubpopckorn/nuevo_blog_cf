class Article < ApplicationRecord
	belongs_to :user
	has_many :comments
	validates :title, presence: true, uniqueness: true
	validates :body, presence:true, length: {minimum: 20}
	#validates :username, format: {with: expresion refular}
	before_create :set_visits_count
	#before_save
	#before_validation
	#after_create

	def update_visits_count
		self.update(visits_count: self.visits_count + 1)
		
		
	end

	private
	def set_visits_count
		self.visits_count = 0;
	end
end
