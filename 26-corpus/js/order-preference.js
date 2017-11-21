

function sampleExcept(from, accept) {
  
  for(var i=0; i<50; i++) {
    result = _.sample(from);
    if(accept(result)) {
      return result;
    }
  }
  console.log("Sampling failed");
  console.log(from);
  console.log(accept);
  return result;

}



function make_slides(f) {
  var   slides = {};


var imageNames =[]; 

  preload(
    imageNames,
    {after: function() {console.log("all images loaded")}}
  );


exp.imagesPreloaded = [];

    for (var i = 0; i < imageNames.length; i++) {
        exp.imagesPreloaded[i] = new Image();
        exp.imagesPreloaded[i].src = imageNames[i];
    }


  slides.consent = slide({
     name : "consent",
     start: function() {
      exp.startT = Date.now();
      $("#consent_2").hide();
      exp.consent_position = 0;      
     },
    button : function() {
      if(exp.consent_position == 0) {
         exp.consent_position++;
         $("#consent_1").hide();
         $("#consent_2").show();
      } else {
        exp.go(); //use exp.go() if and only if there is no "present" data.
      }
    }
  });



  slides.i0 = slide({
     name : "i0",
     start: function() {
      exp.startT = Date.now();
     }
  });

  slides.instructions1 = slide({
    name : "instructions1",
    start: function() {
      $(".instruction_condition").html("Between subject intruction manipulation: "+ exp.instruction);
    }, 
    button : function() {
      exp.go(); //use exp.go() if and only if there is no "present" data.
    }
  });




button = function() {
      if(exp.experiment_step == 0) {
        // cut the last sentence to make sure things don't take up too much space
//        final_sentence = this.stim.context[this.stim.context.length-1]
//        // make sure the boldface thing is inside the section
//        final_sentence = (" "+final_sentence+" ").slice(0, final_sentence.indexOf("<u>")+70)
//        final_sentence = final_sentence.slice(0, final_sentence.lastIndexOf(" "))
//        final_sentence = final_sentence.slice(Math.max(0,final_sentence.length-95), final_sentence.length)
//        final_sentence = final_sentence.slice(final_sentence.indexOf(" ")+1, final_sentence.length)
//
//        $(".turn_"+(this.stim.context.length-1)).html(final_sentence);

//        for(var j=1; j<this.stim.context.length; j++) {
  //       $("#turn_row_"+j).hide(); //.style.visibility = 'visible';// 'none' //hide();
    //    }
     //    $("#turn_row_"+(this.stim.context.length)).show(); //.style.visibility = 'visible';// 'none' //hide();

        $("#dialogue_display").show();

        for(j = 1; j<exp.questionsNumber; j++) {
           $("#question"+j).hide();
        }
        $("#free-input").hide();



        exp.experiment_step ++;
      } else if(exp.experiment_step < exp.questionsNumber) {
            if(exp.sliderPost[(exp.experiment_step-1)] == undefined) {
             $(".err").show();
             return 0;
            }

        $("#question"+(exp.experiment_step-1)).hide();
        $("#question"+(exp.experiment_step)).show();

        exp.experiment_step ++;

      } else {
//         for(i=0; i<exp.sliderPost.length; i++) {
//            if(exp.sliderPost[i] == undefined) {
//             $(".err").show();
//             return 0;
//            }
//         }
         this.log_responses();
        _stream.apply(this); //use exp.go() if and only if there is no "present" data.
      }

//           if (exp.sliderPost != null) {
//           } else {
//             $(".err").show();
//             return 0;
//           }

    },


  slides.dialogue = slide({
    name : "dialogue",
    present : stimuli,
    present_handle : function(stim) {

      $(".err").hide();

      exp.experiment_step = 0;


      exp.sliderPost = null;
      this.stim = stim; //FRED: allows you to access stim in helpers
      document.getElementById("dialogue_display").style.display = 'block' //hide();
      //document.getElementById("dialogue_turker").style.display = 'none' //hide();
      //document.getElementById("dialogue_aliens").style.display = 'none' //hide();

      

      $(".object").html('<img id="pngFrame" src="images/'+stim.object+'" style="width:250px;">');

      $(".alien_utterance_1").html('Look at the highlighted word.');
      people = {'FEMALE' : [1, 3, 6], 'MALE' : [2, 4, 5]}

      end = stim.context.length
      stim.context = stim.context.slice(end-10, end)
      
      genderLast = stim.gender_last
      genderPenultimate = stim.gender_penultimate
      if(stim.context.length % 2 == 0) { // last one will be "1"
         peopleEven = people[genderPenultimate]
         peopleOdd = people[genderLast]
      } else {
         peopleOdd = people[genderPenultimate]
         peopleEven = people[genderLast]
      }
      person1 = _.sample(peopleEven)
      person2 = sampleExcept(peopleOdd, function(p) { return p != person1; })
       $(".speaker_0").html('<img id="pngFrame" src="images/avatar'+person1+'.jpg" style="width:20px;">');
       $(".speaker_1").html('<img id="pngFrame" src="images/avatar'+person2+'.jpg" style="width:20px;">');


      for(var i=0; i< stim.context.length; i++) {
         stim.context[i] = stim.context[i].replace("<b>", "<u>")
         stim.context[i] = stim.context[i].replace("</b>", "</u>")

         $(".turn_"+i).html(stim.context[i]);
      }

      questions = [] 
      questions.push('Does it describe the '+stim.noun+'?<span style="color:white">.......................................</span>');
      questions.push('Does it uniquely identify the '+stim.noun+'?<span style="color:white">..............................</span>');
      questions.push('Does it describe how the speaker feels about the '+stim.noun+'?');
//      questions.push('Does it describe the speaker\'s attitude towards the '+stim.noun+'?');
      questions.push('Does it serve to distinguish the '+stim.noun+' from those that are not '+stim.adjective+'?');
      questions.push('Could there be people who disagree that the '+stim.noun+(stim.noun.slice(-1) == 's' ? ' are ' : ' is ')+stim.adjective+'?');
      exp.questionsNumber = questions.length

      questionTable = ''
      for(var i in questions) {
         index = Math.round(parseInt(i)+1.0)
         questionTable += '<tr id="question'+i+'"> <td width="50%" style="font-size:17px;text-align:left;vertical-align:top;"> <span class="question_'+index+'">{{}}</span> </td><td>    <table id="multi_slider_table_dialogue_1" class="slider_table">      <tr><td><span class="low">No</span></td><td>      <div id="slider0_dialogue_'+index+'" class="slider"></div>      </td><td><span class="high">Yes</span></td></tr>    </table></td></tr>'
      }
      $(".question_table").html(questionTable)

      for(var i in questions) {
         index = Math.round(parseInt(i)+1.0)
         $(".question_"+String(index)).html(questions[i])
      }



      this.init_sliders(questions.length);

      $("#turn_rows").show()

      for(var j=1; j<=stim.context.length; j++) {
         $("#turn_row_"+j).show(); //.style.visibility = 'visible';// 'none' //hide();
      }
      for(var j=stim.context.length+1; j <= 18; j++) {
         $("#turn_row_"+j).hide(); //.style.visibility = 'visible';// 'none' //hide();
      }
      console.log("STIMULUS LENGTH "+stim.context.length);

document.getElementById('free_input').value = "";

      document.getElementById("dialogue_display").style.display = 'none';
     
      this.indexInDialogue = 0;
      this.alien = stim.alien; 

    },


    button : button,

    init_sliders : function(length) {
      console.log("RESET SLIDER POST");
      exp.sliderPost = []
      for(var i = 0; i<length; i++) {
       exp.sliderPost.push(undefined);
       (function(){
       var index = i+0.0
       utils.make_slider("#slider0_dialogue_"+(i+1), function(event, ui) {
        console.log("SLIDER "+index)
        exp.sliderPost[index] = ui.value;
        console.log(exp.sliderPost);
      });
        })();
      }
    },
    log_responses : function() {
        console.log(exp.sliderPost);
        exp.data_trials.push({
          "response" : exp.sliderPost,
          "free_input" : $("#free_input").val(),
          "item" : this.stim.item_id,
          "adjective" : this.stim.adjective,
          "slide_number" : exp.phase
        });
    },
  });

  slides.subj_info =  slide({
    name : "subj_info",
    submit : function(e){
      //if (e.preventDefault) e.preventDefault(); // I don't know what this means.
      exp.subj_data = {
        language : $("#language").val(),
        enjoyment : $("#enjoyment").val(),
        asses : $('input[name="assess"]:checked').val(),
        age : $("#age").val(),
        gender : $("#gender").val(),
        education : $("#education").val(),
        comments : $("#comments").val(),
        suggested_pay : $("#suggested_pay").val()
      };
      exp.go(); //use exp.go() if and only if there is no "present" data.
    }
  });

  slides.thanks = slide({
    name : "thanks",
    start : function() {
      exp.data= {
          "trials" : exp.data_trials,
          "catch_trials" : exp.catch_trials,
          "system" : exp.system,
          //"condition" : exp.condition,
          "subject_information" : exp.subj_data,
          "time_in_minutes" : (Date.now() - exp.startT)/60000
      };
      setTimeout(function() {turk.submit(exp.data);}, 1000);
    }
  });

  return slides;
}

/// init ///
function init() {
repeatWorker = false;
  (function(){
      var ut_id = "adj-order-preference";
      if (UTWorkerLimitReached(ut_id)) {
        $('.slide').empty();
        repeatWorker = true;
        alert("You have already completed the maximum number of HITs allowed by this requester. Please click 'Return HIT' to avoid any impact on your approval rating.");
      }
})();

  exp.current_score_click = 0;
  exp.total_quiz_trials_click = 0;

  exp.current_score = 0;
  exp.total_quiz_trials = 0;
  exp.hasDoneTutorialRevision = false;
  exp.shouldDoTutorialRevision = false;
  exp.hasEnteredInterativeQuiz = false;

  exp.trials = [];
  exp.catch_trials = [];
  exp.instruction = _.sample(["instruction1","instruction2"]);
  exp.system = {
      Browser : BrowserDetect.browser,
      OS : BrowserDetect.OS,
      screenH: screen.height,
      screenUH: exp.height,
      screenW: screen.width,
      screenUW: exp.width
    };
  //blocks of the experiment:
 // exp.structure=["i0", "instructions1",'learning', 'multi_slider', 'subj_info', 'thanks'];//exp.structure=['multi_slider', 'subj_info', 'thanks'];
//   exp.structure=['i0', 'instructions1', 'learning1','instructions2', 'speaker_choice1','instructions4', 'learning2', 'instructions5', 'speaker_choice2','instructions3', 'multi_slider', 'subj_info', 'thanks'];//exp.structure=['multi_slider', 'subj_info', 'thanks'];
//   exp.structure=['i0', 'instructions1', 'learning1','instructions2','speaker_choice1','instructions3', 'multi_slider', 'subj_info', 'thanks'];//exp.structure=['multi_slider', 'subj_info', 'thanks'];
   exp.structure=[];
 exp.structure.push('i0')
   exp.structure.push('consent')
exp.structure.push( 'instructions1')
   exp.structure.push('dialogue')

//exp.structure.push( 'tutorial')
//exp.structure.push('instructions2')
//exp.structure.push('speaker_choice1')
//exp.structure.push('instructions7')
//exp.structure.push( 'production_click')
//exp.structure.push('instructions6')
//exp.structure.push( 'production')
//exp.structure.push( 'tutorial')
//exp.structure.push( 'production2')
//exp.structure.push('instructions8')
//exp.structure.push( 'multi_slider_context')
//exp.structure.push( 'instructions3')
//exp.structure.push( 'multi_slider')
//exp.structure.push('what_things_mean')
exp.structure.push( 'subj_info')
exp.structure.push( 'thanks');


//exp.structure=['multi_slider') exp.structure.push( 'subj_info') exp.structure.push( 'thanks'];
//   exp.structure=['learning1', 'production'] //, 'instructions6', 'production', 'thanks'];//exp.structure=['multi_slider', 'subj_info', 'thanks'];
//   exp.structure=['production', 'tutorial', 'production2', 'instructions3', 'multi_slider', 'subj_info', 'thanks'];//exp.structure=['multi_slider', 'subj_info', 'thanks'];

//   exp.structure=['instructions8', 'multi_slider_context', 'subj_info', 'thanks'];//exp.structure=['multi_slider', 'subj_info', 'thanks'];

//    exp.structure=['multi_slider', 'subj_info', 'thanks'];//exp.structure=['multi_slider', 'subj_info', 'thanks'];
//   exp.structure=['speaker_choice',  'multi_slider', 'subj_info', 'thanks'];//exp.structure=['multi_slider', 'subj_info', 'thanks'];

  exp.data_trials = [];
  //make corresponding slides:
  exp.slides = make_slides(exp);

  exp.nQs = utils.get_exp_length(); //this does not work if there are stacks of stims (but does work for an experiment with this structure)
                    //relies on structure and slides being defined

  $('.slide').hide(); //hide everything

  //make sure turkers have accepted HIT (or you're not in mturk)
  $("#start_button").click(function() {
    if (turk.previewMode) {
      $("#mustaccept").show();
    } else {
      $("#start_button").click(function() {$("#mustaccept").show();});
      exp.go();
    }
  });

  exp.go(); //show first slide
}
