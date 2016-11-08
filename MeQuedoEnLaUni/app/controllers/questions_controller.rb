class QuestionsController < ApplicationController
  def start
  	@random_question = Question.order("RANDOM()").first
    gon.question_id = @random_question.id
  end

  def new
  	@question = Question.new
  	@question.answers.build
  	@question.answers.build
  	@question.answers.build
  	@question.answers.build
  	

  end
  def create
  	@question = Question.new(question_params)
	
   if @question.save
      redirect_to :action => 'start'
   else
      render :action => 'new'
   end

  end

  def check_answer

    is_answer_correct = false

    if Question.exists?(id:params[:question])
      question = Question.find(params[:question])
      is_answer_correct = question.is_it_correct_answer_id?(params[:answer])
    end

    respond_to do |format|
      format.json { render json: {isItCorrect: is_answer_correct}.to_json }
    end

  end

  def question_params
     params.require(:question).permit(:question, answers_attributes: [:answer])
  end
end
