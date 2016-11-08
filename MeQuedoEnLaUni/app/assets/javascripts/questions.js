$( document ).ready(function() {
    console.log( "ready!" );
    $( "input.answer_radio_button" ).click(function(eventObject) {
  		//alert( "Handler for .click() called." );
  		var answer_id= eventObject.currentTarget.value;
  		$.post("v1/questions/checkAnswer",{ question: gon.question_id, answer: answer_id },"json").done(function(data){
			if(data.isItCorrect){
				console.log("bien hecho!!");
			}else{
				console.log("intenta de nuevo");
			};

		}).fail(function(){
			alert("post FAIL");
		});
	});


});