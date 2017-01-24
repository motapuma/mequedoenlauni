class MultipleOptionAnswer < ActiveRecord::Base
	belongs_to :multiple_option_question
	validates :answer, presence: true
	#validates_associated :answers
end
