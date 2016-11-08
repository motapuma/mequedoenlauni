class Question < ActiveRecord::Base
	has_many :answers
	belongs_to :correct_answer, class_name:"Answer"

	accepts_nested_attributes_for :answers, :allow_destroy => true

	def is_it_correct_answer_id?(answer_id)
		#binding.pry debugger
		return answer_id.to_i == self.correct_answer_id.to_i
	end
end
