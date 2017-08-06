



function make_slides(f) {
  var   slides = {};



  preload(
    ["images/kleibait product2394_image2_size2.png", "images/279_striped_balls_by_tigers_stock-d3l9ssp.png", "images/blue-checkered-ball.png", "images/blue_checkered_ball.png", "images/blue_glass_cup.png", "images/blue_metal_cup.png", "images/blue_plastic_cup.png", "images/blue_solid_ball.png", "images/blue_spotted_ball.png", "images/blue_spotted_ball_old.png", "images/blue_striped_ball.png", "images/blue_wooden_cup.png", "images/frame.png", "images/green_checkered_ball.png", "images/green_glass_cup.png", "images/green_metal_cup.png", "images/green_plastic_cup.png", "images/green_solid_ball.png", "images/green_spotted_ball.png", "images/green_spotted_ball_old.png", "images/green_striped_ball.png", "images/green_wooden_cup.png", "images/orange_checkered_ball.png", "images/purple_plastic_cup.png", "images/purple_spotted_ball.png", "images/purple_wooden_cup.png", "images/red-checkered-ball.png", "images/red_checkered_ball.png", "images/red_glass_cup.png", "images/red_metal_cup.png", "images/red_plastic_cup.png", "images/red_solid_ball.png", "images/red_spotted_ball.png", "images/red_spotted_ball_old.png", "images/red_striped_ball.png", "images/red_wooden_cup.png", "images/wooden_cup.png", "images/yellow_checkered_ball.png", "images/yellow_spotted_ball.png", "images/yellow_wooden_cup.png"],
    {after: function() {console.log("all images loaded")}}
  );

var imageNames = ["images/kleibait product2394_image2_size2.png", "images/279_striped_balls_by_tigers_stock-d3l9ssp.png", "images/blue-checkered-ball.png", "images/blue_checkered_ball.png", "images/blue_glass_cup.png", "images/blue_metal_cup.png", "images/blue_plastic_cup.png", "images/blue_solid_ball.png", "images/blue_spotted_ball.png", "images/blue_spotted_ball_old.png", "images/blue_striped_ball.png", "images/blue_wooden_cup.png", "images/frame.png", "images/green_checkered_ball.png", "images/green_glass_cup.png", "images/green_metal_cup.png", "images/green_plastic_cup.png", "images/green_solid_ball.png", "images/green_spotted_ball.png", "images/green_spotted_ball_old.png", "images/green_striped_ball.png", "images/green_wooden_cup.png", "images/orange_checkered_ball.png", "images/purple_plastic_cup.png", "images/purple_spotted_ball.png", "images/purple_wooden_cup.png", "images/red-checkered-ball.png", "images/red_checkered_ball.png", "images/red_glass_cup.png", "images/red_metal_cup.png", "images/red_plastic_cup.png", "images/red_solid_ball.png", "images/red_spotted_ball.png", "images/red_spotted_ball_old.png", "images/red_striped_ball.png", "images/red_wooden_cup.png", "images/wooden_cup.png", "images/yellow_checkered_ball.png", "images/yellow_spotted_ball.png", "images/yellow_wooden_cup.png"];

var imagesPreloaded = [];

    for (var i = 0; i < imageNames.length; i++) {
        imagesPreloaded[i] = new Image();
        imagesPreloaded[i].src = imageNames[i];
    }







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

  slides.multi_slider = slide({
    name : "multi_slider",
    present : _.shuffle(stimuli),
    present_handle : function(stim) {
      $(".err").hide();
      this.init_sliders();      
      exp.sliderPost = null;
      // $('input[name="sense"]:checked').attr('checked',false);
      this.stim = stim; //FRED: allows you to access stim in helpers
      //var noun_data = _.sample(corpus.Noun)
      //this.noun_data = noun_data;
      //var noun = noun_data.noun;
      //var animacy = noun_data.animacy;

      var testimagehtml = '<div style="position:relative"><table class="visualStimulus" style="border-collapse:separate; border-spacing: 0 2em;"><tr>';
      // frame
      // first line
      for(var imageNum=0; imageNum<10; imageNum++) {
         if(imageNum == 5) {
            testimagehtml = testimagehtml + '</tr><tr>'
         }
        testimagehtml = testimagehtml + '<td>'
        topOffset = 20
        topOffsetFrame = -50
        if(imageNum < 5) {
          topOffset = 20 //20
          topOffsetFrame = 0
        }
        if (stim.imgs[imageNum][1] == "target") {
         testimagehtml = testimagehtml + '<div style="position: relative; width:0; height:0"> <img id="pngFrame" src="images/frame.png" style="position:absolute; left:-16px; top='+topOffsetFrame+'px; height:130px;"></div>';
        }
        
        testimagehtml = testimagehtml + '<img id="pngTarget" src="images/'+stim.imgs[imageNum][0]+'" style="position:relative; top:'+topOffset+'px; left:0px; height:100px; width:100px;"></td>'
      }
        testimagehtml = testimagehtml + '</tr> </table><br/><br/>  </div>';
      $("#testimage").html(testimagehtml);



      // this.verbs = _.shuffle(["is","is not"])

      var names_list = _.shuffle(names);

      var man1 = names_list[0];
      var man2 = names_list[1];

      $(".man1").html(man1);

      $(".man2").html(man2);

      $(".noun").html(stim.Noun);

      //$(".woman1").html(woman1);

      //$(".woman2").html(man2);

      $(".low").html("\"the "+ stim.Predicate2 + " " + stim.Predicate1 + " " + stim.Noun + "\"");

      $(".high").html("\"the "+ stim.Predicate1 + " " + stim.Predicate2 + " " + stim.Noun + "\"");

      // $(".utterance1").html("\"That "+ stim.Noun + " " + this.verbs[0] + " " + stim.Predicate + ".\"");

      // $(".utterance2").html("\"You're wrong. That "+ stim.Noun + " " + this.verbs[1] + " "  + stim.Predicate + ".\"");

//      this.sentence_types = _.shuffle(["yes","no"]);
//      this.sentence_types = ["no","yes"];
//      var sentences = {
//        "yes": "Yes, it's a matter of opinion.",
//        "no": "No, somebody must be wrong.",
//      };

//      this.n_sliders = this.sentence_types.length;
		this.n_sliders = 1;
//      $(".slider_row").remove();
//      for (var i=0; i<this.n_sliders; i++) {
//        var sentence_type_left = this.sentence_types[0];
//        var sentence_type_left = this.sentence_types[1];        
//        var sentence_left = sentences[sentence_type_left];
//        var sentence_right = sentences[sentence_type_right];        
//        $("#multi_slider_table").append('<tr class="slider_row"><td class="slider_target" id="sentence0">' + "<font size='4'>" + sentence_left + "</font>" + '</td><td colspan="2"><div id="slider0" class="slider">-------[ ]--------</div></td><td class="slider_target" id="sentence1">' + "<font size='4'>" + sentence_right + "</font>" + '</td></tr>');
//        utils.match_row_height("#multi_slider_table", ".slider_target");
//      }

    },

    button : function() {
    	console.log(exp.sliderPost);
      if (exp.sliderPost != null) {
        this.log_responses();
        _stream.apply(this); //use exp.go() if and only if there is no "present" data.
      } else {
        $(".err").show();
      }
    },

    init_sliders : function() {
      utils.make_slider("#slider0", function(event, ui) {
        exp.sliderPost = ui.value;
      });
    },
//    make_slider_callback : function(i) {
//      return function(event, ui) {
//        exp.sliderPost[i] = ui.value;
//      };
//    },
    log_responses : function() {
        exp.data_trials.push({
          "response" : exp.sliderPost,
          "noun" : this.stim.Noun,  
          "nounclass" : this.stim.NounClass,        
          "predicate1" : this.stim.Predicate1,
          "predicate2" : this.stim.Predicate2,
          "class1" : this.stim.Class1,
          "class2" : this.stim.Class2,                     
          "slide_number" : exp.phase,
          "condition" : this.stim.condition,
          "orderCondition" : this.stim.orderCondition,
          "imgs" : this.stim.imgs,
          "item" : this.stim.item
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
   exp.structure=["i0", "instructions1",'multi_slider', 'subj_info', 'thanks'];
 //exp.structure=['multi_slider', 'subj_info', 'thanks'];
  
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
