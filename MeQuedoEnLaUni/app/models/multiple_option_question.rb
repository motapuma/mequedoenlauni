class MultipleOptionQuestion < ActiveRecord::Base
	has_many :multiple_option_answers
	belongs_to :correct_answer, class_name:"MultipleOptionAnswer"
	belongs_to :paragraph
	belongs_to :question_table_figure
	accepts_nested_attributes_for :multiple_option_answers, :allow_destroy => true
	accepts_nested_attributes_for :correct_answer

	validates :question, presence: true
	validates :subject, presence: true
	validates :correct_answer, presence: true
	validate :validate_multiple_option_answers
	validate :validate_multiple_option_answers_must_be_different

	def validate_multiple_option_answers
		if self.multiple_option_answers.size != 4
    		errors.add(:multiple_option_answers, "Must have 4 answers.")  
    	end
  	end

  	def validate_multiple_option_answers_must_be_different
  		answer_text_array = self.multiple_option_answers.to_a.map(&:answer)
  		errors.add(:multiple_option_answers, "Answers must be differents ") if answer_text_array.uniq.length != answer_text_array.length
  	end


	def is_it_correct_answer_id?(answer_id)
		#binding.pry debugger
		return answer_id.to_i == self.correct_answer_id.to_i
	end
	def correct_answer=(value)
		super(value)
		self.multiple_option_answers << value
	end

	def subject_readable
		return  self.subject.nil? ? "Sin Tema" : Constants::UNAM_SUBJECTS[self.subject]
	end
end
