



function make_slides(f) {
  var   slides = {};


var imageNames = []; //["images/AUTO-blue-few-0.svg", "images/AUTO-blue-few-1.svg", "images/AUTO-blue-few-2.svg", "images/AUTO-blue-few-3.svg", "images/AUTO-blue-few-4.svg", "images/AUTO-blue-few-5.svg", "images/AUTO-blue-few-6.svg", "images/AUTO-blue-few-7.svg", "images/AUTO-blue-few-8.svg", "images/AUTO-blue-few-9.svg", "images/AUTO-blue-many-0.svg", "images/AUTO-blue-many-1.svg", "images/AUTO-blue-many-2.svg", "images/AUTO-blue-many-3.svg", "images/AUTO-blue-many-4.svg", "images/AUTO-blue-many-5.svg", "images/AUTO-blue-many-6.svg", "images/AUTO-blue-many-7.svg", "images/AUTO-blue-many-8.svg", "images/AUTO-blue-many-9.svg", "images/AUTO-green-few-0.svg", "images/AUTO-green-few-1.svg", "images/AUTO-green-few-2.svg", "images/AUTO-green-few-3.svg", "images/AUTO-red-few-1.svg", "images/AUTO-green-few-4.svg", "images/AUTO-green-few-5.svg", "images/AUTO-green-few-6.svg", "images/AUTO-green-few-7.svg", "images/AUTO-green-few-8.svg", "images/AUTO-green-few-9.svg", "images/AUTO-green-many-0.svg", "images/AUTO-green-many-1.svg", "images/AUTO-green-many-2.svg", "images/AUTO-green-many-3.svg", "images/AUTO-green-many-4.svg", "images/AUTO-green-many-5.svg", "images/AUTO-green-many-6.svg", "images/AUTO-green-many-7.svg", "images/AUTO-green-many-8.svg", "images/AUTO-red-few-0.svg", "images/AUTO-red-few-10.svg", "images/AUTO-red-few-2.svg", "images/AUTO-red-few-3.svg", "images/AUTO-red-few-4.svg", "images/AUTO-red-few-5.svg", "images/AUTO-red-few-6.svg", "images/AUTO-red-few-7.svg", "images/AUTO-red-few-8.svg", "images/AUTO-red-few-9.svg", "images/AUTO-red-many-0.svg", "images/AUTO-red-many-1.svg", "images/AUTO-red-many-2.svg", "images/AUTO-red-many-3.svg", "images/AUTO-red-many-4.svg", "images/AUTO-red-many-5.svg", "images/AUTO-red-many-6.svg", "images/AUTO-red-many-7.svg", "images/AUTO-red-many-8.svg", "images/AUTO-red-many-9.svg"]; 

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


  slides.instructions2 = slide({
    name : "instructions2",
    start: function() {
      $(".instruction_condition").html("Between subject intruction manipulation: "+ exp.instruction);
    }, 
    button : function() {
      exp.go(); //use exp.go() if and only if there is no "present" data.
    }
  });



  slides.instructions3 = slide({
    name : "instructions3",
    start: function() { }, 
    button : function() {
      exp.go(); //use exp.go() if and only if there is no "present" data.
    }
  });

  slides.instructions4 = slide({
    name : "instructions4",
    start: function() { }, 
    button : function() {
      exp.go(); //use exp.go() if and only if there is no "present" data.
    }
  });

  slides.instructions5 = slide({
    name : "instructions5",
    start: function() {  }, 
    button : function() {
      exp.go(); //use exp.go() if and only if there is no "present" data.
    }
  });


  slides.instructions6 = slide({
    name : "instructions6",
    start: function() {  }, 
    button : function() {
      exp.go(); //use exp.go() if and only if there is no "present" data.
    }
  });


  slides.instructions7 = slide({
    name : "instructions7",
    start: function() {  }, 
    button : function() {
      exp.go(); //use exp.go() if and only if there is no "present" data.
    }
  });



  slides.instructions8 = slide({
    name : "instructions8",
    start: function() {  }, 
    button : function() {
      exp.go(); //use exp.go() if and only if there is no "present" data.
    }
  });

  slides.instructions9 = slide({
    name : "instructions9",
    start: function() {  }, 
    button : function() {
      exp.go(); //use exp.go() if and only if there is no "present" data.
    }
  });

//console.log("STIMULI");
//console.log(stimuli.length);


  slides.single_sentence = slide({
    name : "single_sentence",
    present : stimuliDialogue,
    present_handle : function(stim) {

      $(".err").hide();
      //$(".err2").hide();

      this.stim = stim; //FRED: allows you to access stim in helpers
      this.init_sliders();
      exp.sliderPost = [undefined, undefined, undefined];

      document.getElementById("dialogue_display").style.display = 'block' //hide();
      document.getElementById("dialogue_turker").style.display = 'none' //hide();
      document.getElementById("dialogue_aliens").style.display = 'none' //hide();

      $(".object").html('<img id="pngFrame" src="images/'+stim.object+'" style="width:250px;">');

//Wow, so many spikes -- I really love this...

      $(".utterance").html('<p class=triangle-border left"> '+stim.sentence+'</p>');
       $(".noun").html(stim.noun);
    
      $(".alien_1").html('<img src="images/'+aliens[0]+'" style="height:150px;">');
      $(".alien_2").html('<img src="images/'+aliens[1]+'" style="height:150px;">');
      $(".alien_1_b").html('<img src="images/'+aliens[0]+'" style="align:center;height:100px; display: block; margin-left: auto; margin-right: auto;">');
      $(".alien_2_b").html('<img src="images/'+aliens[1]+'" style="align:center;height:100px; display: block; margin-left: auto; margin-right: auto;">');


      this.indexInDialogue = 0;
      this.alien = stim.alien; 

    },


    button : function() {
       for(var i=0; i<exp.sliderPost.length; i++) {
         if(exp.sliderPost[i] == undefined) {
              $(".err").show();
             return 0;
         }
       }
       this.log_responses();
       _stream.apply(this); //use exp.go() if and only if there is no "present" data.
    },

    init_sliders : function() {
      utils.make_slider("#slider0_single", function(event, ui) {
        exp.sliderPost[0] = ui.value;
      });
      utils.make_slider("#slider1_single", function(event, ui) {
        exp.sliderPost[1] = ui.value;
      });
      utils.make_slider("#slider2_single", function(event, ui) {
        exp.sliderPost[2] = ui.value;
      });


    },
    log_responses : function() {
        //console.log(this.stim.condition);
        console.log(exp.sliderPost)
        trial = {
          "noun" : this.stim.noun,
          "adjective" : this.stim.adjective,
          "article" : this.stim.article,
          "pattern" : this.stim.pattern,
          "sentence" : this.stim.sentence,
          "slide_number" : exp.phase
        }
        for(i=0; i<exp.sliderPost.length; i++) {
          trial["response_"+i] = exp.sliderPost[i]
        }
        exp.data_trials.push(trial);
        console.log(exp.sliderPost)

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
//        colorblind : $("#colorblind").val(),
        comments : $("#comments").val(),
        suggested_pay : $("#suggested_pay").val(),
        condition : exp.condition,
        adjective1 : adjectives[0],
        adjective2 : adjectives[1],
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
exp.structure.push('instructions9')

   exp.structure.push('single_sentence')

//exp.structure.push( 'instructions1')
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
