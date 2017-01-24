class MultipleOptionQuestionsController < ApplicationController
  def start
  	@multiple_option_question = MultipleOptionQuestion.order("RANDOM()").first
    init_to_show(@multiple_option_question)

    respond_to do |format|
       format.html { render :template => "multiple_option_questions/show" }
    end

  end

  def show
    @multiple_option_question = MultipleOptionQuestion.find(params[:id])
    init_to_show(@multiple_option_question) 
  end

  def init_to_show(multiple_option_question)
    gon.question_id       = multiple_option_question.id
    gon.correct_answer_id = multiple_option_question.correct_answer_id

    if multiple_option_question.question_table_figure
      @data_json = JSON.parse(multiple_option_question.question_table_figure.table_json)
    end

  end

  def new
  	@multiple_option_question = MultipleOptionQuestion.new
  	@multiple_option_question.multiple_option_answers.build
  	@multiple_option_question.multiple_option_answers.build
  	@multiple_option_question.multiple_option_answers.build

    @multiple_option_question.build_correct_answer
  	#@multiple_option_question.multiple_option_answers.build
  	
  end
  def create  
     @multiple_option_question = MultipleOptionQuestion.new(multiple_option_question_params)
     @multiple_option_question.multiple_option_answers << @multiple_option_question.correct_answer
     
     if @multiple_option_question.save
        redirect_to :action => 'start'
     else
        
        @multiple_option_question.multiple_option_answers.delete(@multiple_option_question.correct_answer)
        
        puts(@multiple_option_question.errors)
        render :action => 'new'
     end

  end

  def check_answer

    is_answer_correct = false
    #binding.pry
    if MultipleOptionQuestion.exists?(id:params[:question])
      multiple_option_question = MultipleOptionQuestion.find(params[:question])
      is_answer_correct = multiple_option_question.is_it_correct_answer_id?(params[:answer])
    end

    respond_to do |format|
      format.json { render json: {isItCorrect: is_answer_correct}.to_json }
    end

  end

  def multiple_option_question_params
     params.require(:multiple_option_question).permit(:question,:subject,correct_answer_attributes:[:answer],multiple_option_answers_attributes:[:answer])
  end
end
