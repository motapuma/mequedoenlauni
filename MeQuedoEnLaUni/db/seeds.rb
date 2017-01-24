# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
require 'pry'

preguntas = true
figures   = false
paragraph = false

if preguntas
	csv_text = File.read(Rails.root.join('lib', 'seeds', 'questions.csv'))
	csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
	succesful = 0

	MultipleOptionQuestion.delete_all
	MultipleOptionAnswer.delete_all

	csv.each do |row|
		moq = MultipleOptionQuestion.exists?(row['id'])  ? MultipleOptionQuestion.find(row['id']) : MultipleOptionQuestion.new
		moq.id           = row['id']
		moq.question     = row['question']
		moq.subject      = row['subject']
		moq.paragraph_id = row['paragraph'] 
		moq.question_table_figure_id = row['figure'] 
		puts row['figure']

		correct_answer = row['correct_answer']
		answers = []
		4.times do |i|
			ans = MultipleOptionAnswer.new
			ans.answer = row['answer' + (i+1).to_s]
			#puts "the ans text#{ans.answer}"
			#ans.multiple_option_question = moq
			ans.save
			
			if (i+1) == correct_answer.to_i
				#puts "MUST BEE SAVED CORRECT"
				moq.correct_answer = ans

			else
				#puts "ADD NORMAL CORRECT"
				moq.multiple_option_answers << ans
			end
			#puts " total is: " + moq.multiple_option_answers.size.to_s
			answers << ans
		end
		if moq.save
			succesful +=1
			puts "Exito!"
		else
			#puts "Erroress!"
			#puts row
			binding.pry
			puts moq.errors.full_messages
			answers.each do |a|
				a.destroy
			end
		end
	end
	puts "EXITO en #{succesful}/#{csv.size}"
end

if figures
	csv_text = File.read(Rails.root.join('lib', 'seeds', 'figures.csv'))
	csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
	succesful = 0
	previous_id = -1
	figure = {}
	csv.each do |row|
		id   = row['id']
		type = row['type'].to_s
		text = row['text']

		if previous_id == id || previous_id == -1
			
			if !figure[type]
				figure[type] = [text]
			else
				figure[type].append(text)
			end
		else
			#save the previous figure
			qtf = QuestionTableFigure.exists?(id)  ? QuestionTableFigure.find(id) : QuestionTableFigure.new
			qtf.id = previous_id
			qtf.table_json = figure.to_json

			if qtf.save
				succesful +=1
			else
				puts "error"
				puts moq.errors.full_messages
			end

			figure = {}
			if !figure[type]
				figure[type] = [text]
			else
				figure[type].append(text)
			end
		end

		previous_id = id
	end

	#save_the_last
	qtf = QuestionTableFigure.exists?(previous_id)  ? QuestionTableFigure.find(previous_id) : QuestionTableFigure.new
	qtf.id = previous_id
	qtf.table_json = figure.to_json

	if qtf.save
		succesful +=1
	else
		puts "error"
		puts moq.errors.full_messages
	end

	puts "EXITO en #{succesful}/#{csv.size}"
end

if paragraph
	csv_text = File.read(Rails.root.join('lib', 'seeds', 'parrafos.csv'))
	csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
	succesful = 0
	previous_id = -1
	figure = {}
	csv.each do |row|
		postparrafo = row['postparrafo']
		parrafo     = row['parrafo']
		p = Paragraph.exists?(row['id'])  ? Paragraph.find(row['id']) : Paragraph.new
		p.id = row['id']
		p.paragraph =  parrafo
		p.post_paragraph = postparrafo

		if p.save
			succesful +=1
		else
			puts moq.errors.full_messages
		end

	end
	puts "EXITO en #{succesful}/#{csv.size}"
end