QuestionsList = new Mongo.Collection('questions');

if (Meteor.isClient) {
  Session.setDefault('counter', 0);

  Template.addQuestion.events({ 'submit #addQuestionForm': function(event){
      event.preventDefault();

      var ques = event.target.questionText.value;
      var ans1 = event.target.answer1.value;
      var ans2 = event.target.answer2.value;
      var ans3 = event.target.answer3.value;
      var ans4 = event.target.answer4.value;
      var exp  = event.target.explanation.value;
      var area  = event.target.area.value;
      var corrAnswer  = $("input[name=ansCorr]:checked").val();

      QuestionsList.insert({
            question: ques,
            answer1: ans1,
            answer2: ans2,
            answer3: ans3,
            answer4: ans4,
            explanation:exp,
            area:area,
            correctAnswer:corrAnswer
        });
     
      event.target.questionText.value = "";
      event.target.answer1.value      = "";
      event.target.answer2.value      = "";
      event.target.answer3.value      = "";
      event.target.answer4.value      = "";
      event.target.explanation.value  = "";

  } });

  Template.listQuestions.events({
      'click .remove': function(){
              var questionId = this._id;
              //console.log("hola")
              QuestionsList.remove(questionId);
            }

  });


  Template.listQuestions.helpers({ 

      'questionsList':function(){

        return QuestionsList.find({});
      },

      'getQuestion':function(){
        var questions = QuestionsList.find({}).fetch();
        var question  = questions[Session.get('counter')];

        return question.question;
      },


  });
  
  Template.ansQuestions.helpers({ 

      'getQuestion':function(){
        var questions = QuestionsList.find({}).fetch();
        var question  = questions[Session.get('counter')];

        return question;
      },


  });

  Template.ansQuestions.events({
      'click .answering': function(event){
              var qs        = QuestionsList.find({})
              var questions = qs.fetch();
              var realCount = Session.get('counter');
              var question  = questions[realCount];
              var total     = qs.count();
              var counter   = Session.get('counter');
              var pseudoAns = event.target.getAttribute("res");

              if(question.correctAnswer == pseudoAns ){
                  alert(question.explanation);

                  realCount = (realCount+1 == total ) ? 0 : realCount+1;

                  Session.set('counter', realCount);


              }else{
                alert("Respuesta Incorrecta");
              }



            }

  });


}





if (Meteor.isServer) {
  Meteor.startup(function () {
    // code to run on server at startup
  });
}
