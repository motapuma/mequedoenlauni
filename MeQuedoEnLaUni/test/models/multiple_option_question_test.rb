require 'test_helper'
require 'securerandom'

class MultipleOptionQuestionTest < ActiveSupport::TestCase
   test "should not allow Multiple Ooption Questions without questiontext" do
     
     	moq = MultipleOptionQuestion.new
		3.times{
			moa = MultipleOptionAnswer.new(answer:"moa quest" +SecureRandom.hex)
			moq.multiple_option_answers << moa
		}
		moq.correct_answer = MultipleOptionAnswer.new(answer:"moa quest!")
 		assert_not moq.save, "Saved the question without a question text"
   end

   test "should have  4 answers" do
     	moq = MultipleOptionQuestion.new(question:"is this the question?")
		2.times{
			moa = MultipleOptionAnswer.new(answer:"moa quest"+SecureRandom.hex)
			moq.multiple_option_answers << moa
		}
		moq.correct_answer = MultipleOptionAnswer.new(answer:"moa quest!")

 	 	assert_not moq.save, "Saved a question with only 3 questions"
   end


   test "should have a correct answer" do
     	moq = MultipleOptionQuestion.new(question:"is this the question?")
		4.times{
			moa = MultipleOptionAnswer.new(answer:"moa quest"+SecureRandom.hex )
			moq.multiple_option_answers << moa
		}
		
 	 	assert_not moq.save, "Saved a question without correct answer"
   end

   test "should save it with 4 answers and the correct" do
    	moq = MultipleOptionQuestion.new(question:"is this the question?")
		3.times{
			moa = MultipleOptionAnswer.new(answer:"moa quest"+SecureRandom.hex)
			moq.multiple_option_answers << moa
		}
		moq.correct_answer = MultipleOptionAnswer.new(answer:"moa quest!")

 	 	assert moq.save, "I cannot save a normal Multiple Option Question"
   end

   test "should not save questions with equal answers" do
    	moq = MultipleOptionQuestion.new(question:"is this the question?")
		3.times{
			moa = MultipleOptionAnswer.new(answer:"moa quest")
			moq.multiple_option_answers << moa
		}
		moq.correct_answer = MultipleOptionAnswer.new(answer:"moa quest!")

 	 	assert_not moq.save, "I should not save question with the same question"
   end


end
