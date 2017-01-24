var ready = function() {
	$("div.alertCorrect").hide();
	$("div.alertIncorrect").hide();
	var alreadyTried = false;

	function incrementInOne(key_method){
		var questionTrack = JSON.parse(sessionStorage.getItem( 'questionsTrack'));
		if(!questionTrack) 
			questionTrack = {};
		questionTrack[key_method] = questionTrack[key_method] ? questionTrack[key_method] + 1 : 1
		sessionStorage.setItem( 'questionsTrack', JSON.stringify(questionTrack) );
		updateRadialIndicatorValue(null,null);
	};

	function getValueForSessionByKey(key_method){
		var questionTrack = JSON.parse(sessionStorage.getItem( 'questionsTrack'));
		if(!questionTrack) 
			return null;
		return questionTrack[key_method]
	}

	function correctAnswerChoossen(){
		console.log("bien hecho!!");
		$("div.alertIncorrect").hide();
		$("div.alertCorrect").show();

		if(!alreadyTried){
			incrementInOne("correct_questions");
		}

		setTimeout(function(){
			location.href ="/";
		},3000);
	};
	function incorrectAnswerChoossen(){
		console.log("intenta de nuevo");
		$("div.alertIncorrect").show();
		setTimeout(function(){
			$("div.alertIncorrect").hide();
			
			if(!alreadyTried ){
				incrementInOne("incorrect_questions");
				alreadyTried = true;
			}
				
		},2000);
	};

	$("button.answerButtonJQ").click(function(eventObject) {
    	//console.log("QUE PASSAAAA");
    	var answer_id= eventObject.currentTarget.value;
  		//$.post("/v1/questions/checkAnswer",{ question: gon.question_id, answer: answer_id },"json").done(function(data){
		// 	if(data.isItCorrect){
		// 		correctAnswerChoossen();	
		// 	}else{
		//		incorrectAnswerChoossen();
		// 	};

		// }).fail(function(){
		// 	alert("post FAIL");
		// });
		$(eventObject.currentTarget).removeClass("mqeluAnswerButton");
		if(answer_id == gon.correct_answer_id){
			$(eventObject.currentTarget).addClass("mqeluCorrectAnswerButton");
			correctAnswerChoossen();

		}else{
			$(eventObject.currentTarget).addClass("mqeluIncorrectAnswerButton");
			incorrectAnswerChoossen();
		}
	});

	function readSessionStorage(){
		var corrects = 0;
		var incorrects = 0;
		var questionTrack = JSON.parse(sessionStorage.getItem( 'questionsTrack'));

		if(questionTrack){
			incorrects = questionTrack.incorrect_questions ? questionTrack.incorrect_questions: 0;
			corrects   = questionTrack.correct_questions ? questionTrack.correct_questions : 0;
		}

		$("span#correctQuestions").text(corrects);
		$("span#totalQuestions").text(corrects+incorrects);

		updateRadialIndicatorValue(corrects, incorrects);	
	};

	function initRadialIndicator(){
		$('#indicatorContainer').radialIndicator({
			barColor: {
				0:  "#FF0000",
				70: '#FFD700',
				100: "#008000"
			},
			barWidth: 10,
			initValue: 0,
			roundCorner : true,
			percentage: true
		});
	}
	
	function updateRadialIndicatorValue(corrects, incorrects){

		if(!corrects || !incorrects){
			incorrects = getValueForSessionByKey("incorrect_questions");
			corrects   = getValueForSessionByKey("correct_questions");
		}

		var total = corrects + incorrects;
		var average = corrects > 0 ? (corrects/total)*100 : 0;
		//radialIndicator.animate(average);
		indicator = $('#indicatorContainer').data('radialIndicator')

		if(indicator)
			indicator.animate(average);
	};

	initRadialIndicator();
	readSessionStorage();

}

function checkLoginState() {
  FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
  });
}

//$(document).ready(ready);
//$(document).on('page:change', ready);
$(document).on('turbolinks:load',ready);