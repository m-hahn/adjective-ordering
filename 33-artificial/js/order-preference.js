



function make_slides(f) {
  var   slides = {};


var imageNames =["images/alien-1.jpg", "images/alien-2.png", "images/rocket-6.jpg", "images/rocket-6_blue.jpg", "images/rocket-6_blue.xcf.jpg", "images/rocket-6_green.jpg", "images/rocket-6_green.xcf.jpg", "images/rocket-6_red.jpg", "images/rocket-6_red.xcf.jpg", "images/rocket1.png", "images/rocket2.png", "images/rocket2_blue.jpg", "images/rocket2_blue.xcf.jpg", "images/rocket2_blue_1.xcf.jpg", "images/rocket2_blue_2.xcf.jpg", "images/rocket5_red.jpg", "images/saucer-1.jpg", "images/saucer-1_blue.jpg", "images/saucer-1_blue.xcf.jpg", "images/saucer-1_blue_feet.xcf.jpg", "images/saucer-1_blue_feet_0.xcf.jpg", "images/saucer-1_blue_feet_1.xcf.jpg", "images/saucer-1_blue_feet_2.xcf.jpg", "images/saucer-1_blue_feet_3.xcf.jpg", "images/saucer-1_blue_feet_4.xcf.jpg", "images/saucer-1_blue_feet_5.xcf.jpg", "images/saucer-1_blue_feet_6.xcf.jpg", "images/saucer-1_green.jpg", "images/saucer-2_blue.jpg", "images/saucer-2_green.jpg", "images/saucer-2_red.jpg", "images/saucer-3.png", "images/saucer-3_blue.jpg", "images/saucer-3_blue.xcf.jpg", "images/saucer-3_blue_2.xcf.jpg", "images/saucer-3_blue_3.xcf.jpg", "images/saucer-3_blue_4.xcf.jpg", "images/saucer-4.jpg", "images/saucer-5.jpg", "images/saucer-6.png", "images/Spaceship-clipart-2.jpg", "images/rocket2_blue_3.xcf.jpg", "images/rocket2_blue_4.xcf.jpg", "images/rocket2_blue_5.xcf.jpg", "images/rocket2_green_1.xcf.jpg", "images/rocket2_green_2.xcf.jpg", "images/rocket2_green_3.xcf.jpg", "images/rocket2_green_4.xcf.jpg", "images/rocket2_green_5.xcf.jpg", "images/rocket2_red_1.xcf.jpg", "images/rocket2_red_2.xcf.jpg", "images/rocket2_red_3.xcf.jpg", "images/rocket2_red_4.xcf.jpg", "images/rocket2_red_5.xcf.jpg", "images/rocket3.png", "images/rocket4.png", "images/rocket5.png", "images/rocket5_blue.jpg", "images/rocket5_green.jpg", "images/saucer-2.png", "images/saucer-1_green.xcf.jpg", "images/saucer-1_green_feet_1.xcf.jpg", "images/saucer-1_green_feet_1.xcf.jpg.jpg", "images/saucer-1_green_feet_2.xcf.jpg", "images/saucer-1_green_feet_3.xcf.jpg", "images/saucer-1_green_feet_4.xcf.jpg", "images/saucer-1_green_feet_5.xcf.jpg", "images/saucer-1_green_feet_6.xcf.jpg", "images/saucer-1_red.jpg", "images/saucer-1_red.xcf.jpg", "images/saucer-1_red_feet_1.xcf.jpg", "images/saucer-1_red_feet_2.xcf.jpg", "images/saucer-1_red_feet_3.xcf.jpg", "images/saucer-1_red_feet_4.xcf.jpg", "images/saucer-1_red_feet_5.xcf.jpg", "images/saucer-1_red_feet_6.xcf.jpg"]; 

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



  slides.tutorial = slide({
    name : "tutorial",
    start: function() { 
      exp.current_score = 0;
      exp.total_quiz_trials = 0;
      if(exp.hasEnteredInterativeQuiz && (! exp.shouldDoTutorialRevision)) {
         exp.go();
      }
      if(exp.hasEnteredInterativeQuiz) {
        exp.hasDoneTutorialRevision = true; 
      }

      self.progress = 0;
      applyColorRange = function(ship, color, scale) {
        return ship.replace("COLOR", color).replace("NUM",scale);
      }
      colors = ["red", "blue", "green"]
      ranges = [1,2,3,4,5]

      a1 = function() {
         $(".description_tutorial").html('<p class=triangle-border left"> There are two types of spaceships.</p>');
         for(var i=1; i<13; i++) {
            $(".object_tutorial_"+i).html('');
          }
          $(".alien_tutorial").html('<img src="images/'+_.sample(["alien-1.jpg", "alien-2.png"])+'" style="height:80px;">');
      }

      a2 = function() {
         $(".description_tutorial").html('<p class=triangle-border left"> These spaceships are <b>'+adjectives[1]+'</b>.</p>');
         for(var i=1; i<13; i++) {
            $(".object_tutorial_"+i).html('<img id="pngFrame" src="images/'+applyColorRange(ship, _.sample(colors), 3)+'" style="width:70px;">');
          }
          $(".alien_tutorial").html('<img src="images/'+_.sample(["alien-1.jpg", "alien-2.png"])+'" style="height:80px;">');
      }

      a3 = function() {
         $(".description_tutorial").html('<p class=triangle-border left"> These spaceships are not <b>'+adjectives[1]+'</b>.</p>');
         for(var i=1; i<13; i++) {
            $(".object_tutorial_"+i).html('<img id="pngFrame" src="images/'+applyColorRange(ship, _.sample(colors), _.sample([1,2,4,5]))+'" style="width:70px;">');
          }
          $(".alien_tutorial").html('<img src="images/'+_.sample(["alien-1.jpg", "alien-2.png"])+'" style="height:80px;">');
      }

      a4 = function() {
         $(".description_tutorial").html('<p class=triangle-border left"> These spaceships are <b>'+adjectives[1]+'</b>.</p>');
         for(var i=1; i<13; i++) {
            $(".object_tutorial_"+i).html('<img id="pngFrame" src="images/'+applyColorRange(ship, _.sample(colors), 3)+'" style="width:70px;">');
          }
          $(".alien_tutorial").html('<img src="images/'+_.sample(["alien-1.jpg", "alien-2.png"])+'" style="height:80px;">');
      }

      a5 = function() {
         $(".description_tutorial").html('<p class=triangle-border left"> These spaceships are not <b>'+adjectives[1]+'</b>.</p>');
         for(var i=1; i<13; i++) {
            $(".object_tutorial_"+i).html('<img id="pngFrame" src="images/'+applyColorRange(ship, _.sample(colors), _.sample([1,2,4,5]))+'" style="width:70px;">');
          }
          $(".alien_tutorial").html('<img src="images/'+_.sample(["alien-1.jpg", "alien-2.png"])+'" style="height:80px;">');
      }


      a6 = function() {
         $(".description_tutorial").html('<p class=triangle-border left">Spaceships differ by how <b>'+adjectives[0]+'</b> they are.</p>');
         for(var i=1; i<13; i++) {
            $(".object_tutorial_"+i).html('');
          }
          $(".alien_tutorial").html('<img src="images/'+_.sample(["alien-1.jpg", "alien-2.png"])+'" style="height:80px;">');
      }

      a7 = function() {
         $(".description_tutorial").html('<p class=triangle-border left"> These spaceships are quite <b>'+adjectives[0]+'</b>.</p>');
         for(var i=1; i<13; i++) {
            $(".object_tutorial_"+i).html('<img id="pngFrame" src="images/'+applyColorRange(ship, _.sample(colors), _.sample([3,4,5]))+'" style="width:70px;">');
          }
          $(".alien_tutorial").html('<img src="images/'+_.sample(["alien-1.jpg", "alien-2.png"])+'" style="height:80px;">');
      }

      a8 = function() {
         $(".description_tutorial").html('<p class=triangle-border left"> These spaceships are not <b>'+adjectives[0]+'</b> at all.</p>');
         for(var i=1; i<13; i++) {
            $(".object_tutorial_"+i).html('<img id="pngFrame" src="images/'+applyColorRange(ship, _.sample(colors), _.sample([1]))+'" style="width:70px;">');
          }
          $(".alien_tutorial").html('<img src="images/'+_.sample(["alien-1.jpg", "alien-2.png"])+'" style="height:80px;">');
      }



      a9 = function() {
         $(".description_tutorial").html('<p class=triangle-border left"> These spaceships are very <b>'+adjectives[0]+'</b>.</p>');
         for(var i=1; i<13; i++) {
            $(".object_tutorial_"+i).html('<img id="pngFrame" src="images/'+applyColorRange(ship, _.sample(colors), _.sample([5]))+'" style="width:70px;">');
          }
          $(".alien_tutorial").html('<img src="images/'+_.sample(["alien-1.jpg", "alien-2.png"])+'" style="height:80px;">');
      }

      a10 = function() {
         $(".description_tutorial").html('<p class=triangle-border left"> These spaceships are not so <b>'+adjectives[0]+'</b>.</p>');
         for(var i=1; i<13; i++) {
            $(".object_tutorial_"+i).html('<img id="pngFrame" src="images/'+applyColorRange(ship, _.sample(colors), _.sample([2,3]))+'" style="width:70px;">');
          }
          $(".alien_tutorial").html('<img src="images/'+_.sample(["alien-1.jpg", "alien-2.png"])+'" style="height:80px;">');
      }


      a11 = function() {
         $(".description_tutorial").html('<p class=triangle-border left"> These spaceships are extremely <b>'+adjectives[0]+'</b>.</p>');
         for(var i=1; i<13; i++) {
            $(".object_tutorial_"+i).html('<img id="pngFrame" src="images/'+applyColorRange(ship, _.sample(colors), _.sample([5]))+'" style="width:70px;">');
          }
          $(".alien_tutorial").html('<img src="images/'+_.sample(["alien-1.jpg", "alien-2.png"])+'" style="height:80px;">');
      }



      a12 = function() {
         $(".description_tutorial").html('<p class=triangle-border left"> These spaceships are arranged<br> from least <b>'+adjectives[0]+'</b> to most <b>'+adjectives[0]+'</b>.</p>');
         for(var i=1; i<13; i++) {
            $(".object_tutorial_"+i).html('<img id="pngFrame" src="images/'+applyColorRange(ship, _.sample(colors), (Math.round(4.0 * i / 11.0 + 7.0/11.0  )))+'" style="width:70px;">');
          }
          $(".alien_tutorial").html('<img src="images/'+_.sample(["alien-1.jpg", "alien-2.png"])+'" style="height:80px;">');
      }



      a13 = function() {
         $(".description_tutorial").html('<p class=triangle-border left"> These spaceships are arranged<br> from least <b>'+adjectives[0]+'</b> to most <b>'+adjectives[0]+'</b>.</p>');
         for(var i=1; i<13; i++) {
            $(".object_tutorial_"+i).html('<img id="pngFrame" src="images/'+applyColorRange(ship, _.sample(colors), (Math.round(4.0 * i / 11.0 + 7.0/11.0  )))+'" style="width:70px;">');
          }
          $(".alien_tutorial").html('<img src="images/'+_.sample(["alien-1.jpg", "alien-2.png"])+'" style="height:80px;">');
      }



      a14 = function() {
         $(".description_tutorial").html('<p class=triangle-border left"> These spaceships are arranged<br> from least <b>'+adjectives[0]+'</b> to most <b>'+adjectives[0]+'</b>.</p>');
         for(var i=1; i<13; i++) {
            $(".object_tutorial_"+i).html('<img id="pngFrame" src="images/'+applyColorRange(ship, _.sample(colors), (Math.round(4.0 * i / 11.0 + 7.0/11.0  )))+'" style="width:70px;">');
          }
          $(".alien_tutorial").html('<img src="images/'+_.sample(["alien-1.jpg", "alien-2.png"])+'" style="height:80px;">');
      }

      a15 = function() {
         $(".description_tutorial").html('<p class=triangle-border left"> These spaceships are <b>'+adjectives[1]+'</b>.</p>');
         for(var i=1; i<13; i++) {
            $(".object_tutorial_"+i).html('<img id="pngFrame" src="images/'+applyColorRange(ship, _.sample(colors), 3)+'" style="width:70px;">');
          }
          $(".alien_tutorial").html('<img src="images/'+_.sample(["alien-1.jpg", "alien-2.png"])+'" style="height:80px;">');
      }

      a16 = function() {
         $(".description_tutorial").html('<p class=triangle-border left"> These spaceships are not <b>'+adjectives[1]+'</b>.</p>');
         for(var i=1; i<13; i++) {
            $(".object_tutorial_"+i).html('<img id="pngFrame" src="images/'+applyColorRange(ship, _.sample(colors), _.sample([1,2,4,5]))+'" style="width:70px;">');
          }
          $(".alien_tutorial").html('<img src="images/'+_.sample(["alien-1.jpg", "alien-2.png"])+'" style="height:80px;">');
      }

      a17 = function() {
         $(".description_tutorial").html('<p class=triangle-border left"> These spaceships are <b>'+adjectives[1]+'</b>.</p>');
         for(var i=1; i<13; i++) {
            $(".object_tutorial_"+i).html('<img id="pngFrame" src="images/'+applyColorRange(ship, _.sample(colors), 3)+'" style="width:70px;">');
          }
          $(".alien_tutorial").html('<img src="images/'+_.sample(["alien-1.jpg", "alien-2.png"])+'" style="height:80px;">');
      }

      a18 = function() {
         $(".description_tutorial").html('<p class=triangle-border left"> These spaceships are not <b>'+adjectives[1]+'</b>.</p>');
         for(var i=1; i<13; i++) {
            $(".object_tutorial_"+i).html('<img id="pngFrame" src="images/'+applyColorRange(ship, _.sample(colors), _.sample([1,2,4,5]))+'" style="width:70px;">');
          }
          $(".alien_tutorial").html('<img src="images/'+_.sample(["alien-1.jpg", "alien-2.png"])+'" style="height:80px;">');
      }

      self.tutorial_functions = [undefined, a2, a3, a4, a5,a2, a3, a4, a5,  a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18];

      a1();
    }, 
    button : function() {
      self.progress ++;

      if(self.progress +1 >= self.tutorial_functions.length) {
        exp.go(); //use exp.go() if and only if there is no "present" data.
      }
      //console.log(self.progress);
      //console.log(self.tutorial_functions);
      self.tutorial_functions[self.progress]();
        
   }
  });





//console.log("STIMULI");
//console.log(stimuli.length);


   var buttonFunction = function() {
       	//console.log(exp.sliderPost);
           //this.log_responses();
           _stream.apply(this); //use exp.go() if and only if there is no "present" data.
       }
   
   
   var learningPresentHandle = function(stim) {
         $(".err").hide();
         this.init_sliders();
         exp.sliderPost = null;
         this.stim = stim; //FRED: allows you to access stim in helpers
   
         $(".alien").html('<img id="pngFrame" src="images/'+stim.alien_image+'" style="height:130px;">');
   
         $(".object").html('<img id="pngFrame" src="images/'+stim.object_image+'" style="width:250px;">');

         article = "a"; //(["a","e","i","o","u"].includes(stim.adjective.substring(0,1))) ? "an" : "a"

   
         if(stim.negation == 1) {
           negation = "<b>not ";
         } else {
           negation = "<b>";
         }
         phrasing = negation+article+' '+stim.adjective+'</b>'
         if(stim.scalar_modifier != "SHOULD_NOT_BE_DISPLAYED") {
            phrasing = negation+article+''+['', '', '', ' very', 'n extremely'][stim.scalar_modifier-1]+' '+stim.adjective+'</b>'
         }

         $(".description").html('<p class=triangle-border left"> This is '+phrasing+' spaceship.</p>');
   
       }
   
   var init_slidersFunction_ctxt = function() {
         utils.make_slider("#slider0_ctxt", function(event, ui) {
           exp.sliderPost = ui.value;
         });
       }
   var init_slidersFunction = function() {
         utils.make_slider("#slider0", function(event, ui) {
           exp.sliderPost = ui.value;
         });
       }
   
   var present_handleSpeakerChoice = function(stim) {
         $("#choose_speaker_table").hide();
         $("#choice_request").hide()
         $("#choice_continue_1").hide()
         $("#choice_continue_2").hide()
   
         $("#speaker_choice_feedback").hide();
   
         
            $("#choose_speaker_table").show();
            $("#choice_request").show()
            $("#choice_continue_1").show()
            
         $(".err").hide();
         this.init_sliders();
         exp.sliderPost = null;
         this.stim = stim; //FRED: allows you to access stim in helpers
  
         $(".object").html('<img id="pngFrame" src="images/'+stim.alien_image+'" style="width:150px;">');

 
         var names_list = _.shuffle(names);
         console.log(stim.object_image1)
         console.log(stim.object_image2)

         $(".object1").html('<input type="image" onclick="_s.button_1(\'first\')" id="myimage_first" src="images/'+stim.object_image1+'" style="height:190px;"/>');
         $(".object2").html('<input type="image" onclick="_s.button_1(\'second\')" id="myimage_first" src="images/'+stim.object_image2+'" style="height:190px;"/>');

         if(stim.adj_index == 0) {
            modifier = "more "
         } else {
            modifier = ""
         }
         $(".description").html('<p class=triangle-border left"> Click on the <b>'+modifier+''+stim.adjective+'</b> spaceship.</p>');
         this.has_decided = false;
   
         for(w = 0; w < 2; w++) {
             document.getElementById("myimage_"+["first","second"][w]+"_out").style.border = "0px solid white";
         }
         this.response = undefined;
       }
   
   //console.log("MAYBE MAKE THE ADJECTIVE THING A GAME: PUT UP A FEW SPACESHIPS; AND PRODUCE A DESCRIPTION");
   
   
   var buttonSpeakerChoice = function(result) {
        if(this.response != undefined) {
           return 0;
        }
        this.response = result;
        $("#speaker_choice_feedback").show();

          document.getElementById("myimage_"+this.stim.correct_answer+"_out").style.border = "5px solid blue";


        if(this.stim.correct_answer == result) {
          document.getElementById("speaker_choice_feedback_p").style.color = "blue";
          feedback = "Correct!"

        } else {
          document.getElementById("speaker_choice_feedback_p").style.color = "red";
          feedback = "Incorrect!"
        }

       
        $("#speaker_choice_feedback").html(feedback);
        $("#choice_continue_1").hide()
        $("#choice_continue_2").show()

        this.log_responses();
    }

    var button2SpeakerChoice = function() {   
            _stream.apply(this); //use exp.go() if and only if there is no "present" data.
        }
    
    var init_slidersSpeakerChoice = function() {
          utils.make_slider("#slider0", function(event, ui) {
            exp.sliderPost = ui.value;
          });
        }
    
    
    learning_blocks = []
    learning_blocks.push(_.shuffle([].concat(_.sample(learning_block_1,30), _.sample(learning_block_2, 30), _.sample([].concat(learning_block_1, learning_block_2), 30)  )))
    learning_blocks.push(_.shuffle([].concat(_.sample(learning_block_5,30), _.sample(learning_block_6, 30), _.sample([].concat(learning_block_1, learning_block_2, learning_block_5, learning_block_6), 30)  )))
    
   
    log_responsesSpeakerChoice = function() {
        exp.data_trials.push({
          "quiz_response" : this.response,
          "correct_response" : this.stim.correct_answer,
          "object" : this.stim.object_image,
          "adjective" : this.stim.adjective,
          "slide_number" : exp.phase,
      //    "condition" : this.stim.condition,
//          "imgs" : this.stim.imgs,
  //        "item" : this.stim.item,
    //      "distractorValues" : this.stim.distractorValues
        });
    };


 
    for(var i=1; i<=learning_blocks.length; i++) {
       slides["learning"+i] = slide({
           name : "learning",
           present : learning_blocks[i-1],
           present_handle : learningPresentHandle,
           button : function() {
              _stream.apply(this); //use exp.go() if and only if there is no "present" data.
           },
           init_sliders : init_slidersFunction
         });
         //console.log("learning"+i);
    }
    
    testing_blocks = [];
    
    testing_blocks = []
    testing_blocks.push(_.shuffle([].concat(_.sample(testing_block_1,30), _.sample(testing_block_2, 30), _.sample([].concat(testing_block_1, testing_block_2), 30)  )))
    testing_blocks.push(_.shuffle([].concat(_.sample(testing_block_5,30), _.sample(testing_block_6, 30), _.sample([].concat(testing_block_1, testing_block_2, testing_block_5, testing_block_6), 30)  )))
    
    
    
    for(var i=1; i<=testing_blocks.length; i++) {
       slides["speaker_choice"+i] = slide({
           name : "speaker_choice",
           present : testing_blocks[i-1],
           present_handle : present_handleSpeakerChoice,
           button_1 : buttonSpeakerChoice,
           button_2 : button2SpeakerChoice,
           init_sliders : init_slidersSpeakerChoice,
           log_responses : log_responsesSpeakerChoice
         });
    }

 
  present_handle_production = function(stim) {
      if(!exp.hasDoneTutorialRevision && (exp.current_score / exp.total_quiz_trials < 0.5) && exp.total_quiz_trials > 8) {
          console.log("DOING REVISION");
          exp.shouldDoTutorialRevision = true;
          _stream.apply(this);
      }
      if(exp.hasDoneTutorialRevision && (!exp.shouldDoTutorialRevision)) {
           _stream.apply(this);
      }
      exp.hasEnteredInterativeQuiz = true;
      $("#score_field").html(exp.current_score+" Points <br>"+Math.floor(((exp.total_quiz_trials > 0) ? ((exp.current_score*100)/exp.total_quiz_trials) : 100))+"% Correct");
      $(".alien_production").html('<img id="pngFrame" src="images/'+(_.sample(["alien-1.jpg", "alien-2.png"]))+'" style="width:130px;">');


      this.stim = stim; //FRED: allows you to access stim in helpers

      $(".object1").html('<img id="pngFrame" src="images/'+this.stim.ships[0].fileName+'" style="width:140px;">');
      $(".object2").html('<img id="pngFrame" src="images/'+this.stim.ships[1].fileName+'" style="width:140px;">');
      $(".object3").html('<img id="pngFrame" src="images/'+this.stim.ships[2].fileName+'" style="width:140px;">');
      $(".object4").html('<img id="pngFrame" src="images/'+this.stim.ships[3].fileName+'" style="width:140px;">');

      for(var i = 1; i<=4; i++) {
         document.getElementById("object"+(i)+"_td").style.border = "5px solid white";
      }

      //console.log(stim.ships);
      targetElement = ([0,1,2,3].filter(function(x) { return stim.ships[x].index == 0}))[0]
      //console.log("object"+(targetElement+1))

      document.getElementById("object"+(targetElement+1)+"_td").style.border = "5px solid blue";

      document.getElementById("production_input").value = ""; 

        $("#prod_continue_2").hide()
        $("#prod_continue_3").hide()
        $("#prod_continue_4").hide()

        $("#prod_continue_1").show()
       $("#prod_feedback").hide();

    }

  button_production = function() {
        this.log_responses();
        _stream.apply(this); //use exp.go() if and only if there is no "present" data.
    }

  button_3_production = function() {

      for(var i = 1; i<=4; i++) {
         document.getElementById("object"+(i)+"_td").style.border = "5px solid white";
      }
      stim = this.stim;
      targetElement = ([0,1,2,3].filter(function(x) { return stim.ships[x].index == 0}))[0]
      document.getElementById("object"+(targetElement+1)+"_td").style.border = "5px solid blue";


       words = [];

       colors = [];
       alien = [];

       //console.log(this.stim);
       description = $("#production_input").val().replace("."," ").replace(","," ").toLowerCase();
       words = description.split(" ");

       //console.log(description);

       this.position = 0;
       for(var i=0; i < words.length; i++) {
         word = words[i];
         if(["red", "green", "blue"].includes(word)) {
           colors.push(word);
         } else if(adjectives.includes(word)) {
           alien.push(word);
         }

       }
       
       //console.log(words);
       //console.log(alien);
       //console.log(colors);
      
       maxrange = Math.max.apply(null, this.stim.ships.map(function(x) { return x.range }))
//       console.log(this.stim.ships.map(function(x) { return x.range }))
  //     console.log(maxrange);
       function isCompatible(local_ship) {
          negated = false;
          for(var i=0; i<words.length; i++) {
             word = words[i];
             if(["red", "green", "blue"].includes(word)) {
               if(word != local_ship.color) {
                  return negated ? true : false;
               }
             } else if(adjectives[0] == word) { // subjective
               if(maxrange > local_ship.range) {
                  return negated ? true : false;
               }
             } else if(adjectives[1] == word) {
               if(local_ship.range != 3) {
                 return negated ? true : false;
               }
             } else if(word == "not") {
                negated = true;
             }
           }
         return true;
       }
       compatibleShips = []
       for(var i=0; i<4; i++) {
          if(isCompatible(this.stim.ships[i])) {
            compatibleShips.push(i);
            document.getElementById("object"+(i+1)+"_td").style.border = "5px solid orange";
          }
       }
       if(compatibleShips.length > 1) {
          feedback = "Your tutor couldn't figure out what you meant! The highlighted spaceships all seem to fit your description. Try to make it more precise."
          feedbackColor = "red";
          this.answer_status = "underspecified";
       }
       if(compatibleShips.length == 0) {
          feedback = "Your tutor couldn't figure out what you meant! Your description doesn't seem to match any ship."
          feedbackColor = "red";
          this.answer_status = "inconsistent";

//          compatibleShips = this.stim;
       }
       if(compatibleShips.length == 1) {
         if(this.stim.ships[compatibleShips[0]].index == 0) {
           feedback = _.sample(["That's right!", "Good job!", "You succeeded!", "That is a good description!", "You're on track!"])
           feedbackColor = "green";
          this.answer_status = "correct";

         } else {
           feedback = "Your tutor chose the wrong spaceship! Your description doesn't match."
           feedbackColor = "red";
          this.answer_status = "wrong";

         }
       }
       //console.log(this.stim.suggestion);
       if(this.stim.suggestion != undefined && feedbackColor == "red") {
         feedback += "<br/> Hint: You could say: &nbsp;<b>"+this.stim.suggestion.replace("ship", "spaceship")+"</b>"
       } else if(feedbackColor == "red") {
         feedback += "<br/> Hint: Combine multiple descriptions if necessary. You're allowed to use:<br/> <b>"+(["the", "spaceship", adjectivesOrdered[0], adjectivesOrdered[1], "red", "green", "blue"]).join(", ")+"</b>"
       }
       if(feedbackColor != "green") {
         feedback += '<br/>Press "Skip" to move on, or change your response and try again.'
       }
       //console.log(compatibleShips);
       chosenShip = _.sample(compatibleShips);
    //   console.log(chosenShip);

//       isCorrect = (this.stim.ships[chosenShip].index == 0);
       //frameColor = (isCorrect ? "green" : "red")
       //document.getElementById("object"+(chosenShip+1)).style.border = "5px solid "+frameColor;
       //feedback = isCorrect ? "You've succeeded!" : "Your partner has chosen the wrong spaceship."
       $("#prod_feedback").html(feedback);
       //console.log(feedback);
       document.getElementById("prod_feedback_p").style.color = feedbackColor;

       $("#prod_feedback").show();


        $("#prod_continue_1").hide()
        $("#prod_continue_3").show()
        if(this.answer_status != "correct") {
          $("#prod_continue_2").show()
          $("#prod_continue_3").show()
          $("#prod_continue_4").hide()

          document.getElementById("object"+(targetElement+1)+"_td").style.border = "5px solid blue";
        } else {
          $("#prod_continue_2").hide()
          $("#prod_continue_3").hide()
          $("#prod_continue_4").show()
        }

    }
 
  log_responses_production = function() {
        //console.log(this.stim.condition);
        exp.current_score += ((this.answer_status == "correct") ? 1 : 0)
        exp.total_quiz_trials += 1
        exp.data_trials.push({
          "enteredText" : $("#production_input").val().replace('\n',' NEW_LINE '),
          "correct" : this.answer_status,
          "slide_number" : exp.phase
        });
    }

  slides.production = slide({
    name : "production",
    present : _.shuffle(production_block_1).concat(_.shuffle(production_block_2.concat(production_block_3, production_block_4))),
    present_handle : present_handle_production,
    button : button_production,
    button_3 : button_3_production,
    log_responses : log_responses_production,
  });


  slides.production2 = slide({
    name : "production",
    present : _.shuffle(production_block_1).concat(_.shuffle(production_block_2.concat(production_block_3, production_block_4))),
    present_handle : present_handle_production,
    button : button_production,
    button_3 : button_3_production,
    log_responses : log_responses_production,
  });



  slides.production_click = slide({
    name : "production_click",
    present : _.shuffle(production_block_1).concat(_.shuffle(production_block_2.concat(production_block_3, production_block_4))),
    present_handle : function(stim) {
      $("#score_field_click").html(exp.current_score_click+" Points <br>"+Math.floor(((exp.total_quiz_trials_click > 0) ? ((exp.current_score_click*100)/exp.total_quiz_trials_click) : 100))+"% Correct");
      $(".alien_production").html('<img id="pngFrame" src="images/'+(_.sample(["alien-1.jpg", "alien-2.png"]))+'" style="width:130px;">');

       this.position = 0;
       for(var i=1; i < 4; i++) {
         $("#textfield"+i).html("");
       }
      this.stim = stim; //FRED: allows you to access stim in helpers

      $(".object1").html('<img id="pngFrame" src="images/'+this.stim.ships[0].fileName+'" style="width:140px;">');
      $(".object2").html('<img id="pngFrame" src="images/'+this.stim.ships[1].fileName+'" style="width:140px;">');
      $(".object3").html('<img id="pngFrame" src="images/'+this.stim.ships[2].fileName+'" style="width:140px;">');
      $(".object4").html('<img id="pngFrame" src="images/'+this.stim.ships[3].fileName+'" style="width:140px;">');

      for(var i = 1; i<=4; i++) {
         document.getElementById("object"+(i)+"_td_click").style.border = "5px solid white";
      }

         document.getElementById("myimage_ADJ1").value = adjectivesOrdered[0];
         document.getElementById("myimage_ADJ2").value = adjectivesOrdered[1];


      //console.log(stim.ships);
      targetElement = ([0,1,2,3].filter(function(x) { return stim.ships[x].index == 0}))[0]
      //console.log("object"+(targetElement+1))

      document.getElementById("object"+(targetElement+1)+"_td_click").style.border = "5px solid blue";

      document.getElementById("production_input").value = ""; 

        $("#prod_click_continue_2").hide()
        $("#prod_click_continue_4").hide() // continue
        $("#prod_click_continue_3").show() // skip

        $("#prod_click_continue_1").show()
       $("#prod_click_feedback").hide();

        $("#prod_click_continue_0").show()


      this.position = 0;
    },

/*    button : function() {
    	//console.log(exp.sliderPost);
      if (exp.sliderPost != null) {
        this.log_responses();
        _stream.apply(this); //use exp.go() if and only if there is no "present" data.
      } else {
        $(".err").show();
      }
    },*/


   button : function() {
        this.log_responses();
        _stream.apply(this); //use exp.go() if and only if there is no "present" data.
    },

    button_1 : function(word) {
       this.position++;
       if(word == "ADJ1") {
          word = adjectivesOrdered[0]
       } else if(word == "ADJ2") {
          word = adjectivesOrdered[1]
       }
       $(".textfield"+this.position).html(word);
       $("#textfield"+this.position).html(word);
    },

    button_2 : function(word) {
       this.position = 0;
       for(var i=1; i < 4; i++) {
         $("#textfield"+i).html("");
       }

    },



    button_3 : function() {
       words = [];

      
       for(var i=1; i < 4; i++) {
         word = (document.getElementById("textfield"+i).innerHTML);
         words.push(word);

       }
       
       console.log(words);




      for(var i = 1; i<=4; i++) {
         document.getElementById("object"+(i)+"_td_click").style.border = "5px solid white";
      }
      stim = this.stim;
      targetElement = ([0,1,2,3].filter(function(x) { return stim.ships[x].index == 0}))[0]
      document.getElementById("object"+(targetElement+1)+"_td_click").style.border = "5px solid blue";


   //    words = [];

       colors = [];
       alien = [];

       //console.log(this.stim);
//       description = $("#production_input").val().replace("."," ").replace(","," ");
  //     words = description.split(" ");

       //console.log(description);

//       this.position = 0;
       for(var i=0; i < words.length; i++) {
         word = words[i];
         if(["red", "green", "blue"].includes(word)) {
           colors.push(word);
         } else if(adjectives.includes(word)) {
           alien.push(word);
         }

       }
       
       //console.log(words);
       //console.log(alien);
       //console.log(colors);
      
       maxrange = Math.max.apply(null, this.stim.ships.map(function(x) { return x.range }))
//       console.log(this.stim.ships.map(function(x) { return x.range }))
  //     console.log(maxrange);
       function isCompatible(ship) {
          negated = false;
          for(var i=0; i<words.length; i++) {
             word = words[i];
             if(["red", "green", "blue"].includes(word)) {
               if(word != ship.color) {
                  return negated ? true : false;
               }
             } else if(adjectives[0] == word) {
               if(maxrange > ship.range) {
                  return negated ? true : false;
               }
             } else if(adjectives[1] == word) {
               if(ship.range != 3) {
                 return negated ? true : false;
               }
             } else if(word == "not") {
                negated = true;
             }
           }
         return true;
       }
       compatibleShips = []
       for(var i=0; i<4; i++) {
          if(isCompatible(this.stim.ships[i])) {
            compatibleShips.push(i);
            document.getElementById("object"+(i+1)+"_td_click").style.border = "5px solid orange";
          }
       }
       if(compatibleShips.length > 1) {
          feedback = "Your tutor couldn't figure out what you meant! The highlighted spaceships all seem to fit your description. Try to make it more precise."
          feedbackColor = "red";
          this.answer_status = "underspecified";
       }
       if(compatibleShips.length == 0) {
          feedback = "Your tutor couldn't figure out what you meant! Your description doesn't seem to match any ship."
          feedbackColor = "red";
          this.answer_status = "inconsistent";

//          compatibleShips = this.stim;
       }
       if(compatibleShips.length == 1) {
         if(this.stim.ships[compatibleShips[0]].index == 0) {
           feedback = _.sample(["That's right!", "Good job!", "You succeeded!", "That is a good description!", "You're on track!"])
           feedbackColor = "green";
          this.answer_status = "correct";

         } else {
           feedback = "Your tutor chose the wrong spaceship! Your description doesn't match."
           feedbackColor = "red";
          this.answer_status = "wrong";

         }
       }
       //console.log(this.stim.suggestion);
       if(this.stim.suggestion != undefined && feedbackColor == "red") {
         feedback += "<br/> Hint: You could say: &nbsp;<b>"+this.stim.suggestion.replace("ship", "spaceship")+"</b>"
       } else if(feedbackColor == "red") {
         feedback += "<br/> Hint: Combine multiple descriptions if necessary."
       }
       if(feedbackColor != "green") {
         feedback += '<br/>Press "Skip" to move on, or change your response and try again.'
       }
       //console.log(compatibleShips);
       chosenShip = _.sample(compatibleShips);
    //   console.log(chosenShip);

//       isCorrect = (this.stim.ships[chosenShip].index == 0);
       //frameColor = (isCorrect ? "green" : "red")
       //document.getElementById("object"+(chosenShip+1)).style.border = "5px solid "+frameColor;
       //feedback = isCorrect ? "You've succeeded!" : "Your partner has chosen the wrong spaceship."
       $("#prod_click_feedback").html(feedback);
       //console.log(feedback);
       document.getElementById("prod_click_feedback_p").style.color = feedbackColor;

       $("#prod_click_feedback").show();

        $("#prod_click_continue_0").show()

        $("#prod_click_continue_1").hide()
        $("#prod_click_continue_3").show()
        if(this.answer_status != "correct") {
          $("#prod_click_continue_2").show()
          document.getElementById("object"+(targetElement+1)+"_td_click").style.border = "5px solid blue";
        } else {
          $("#prod_click_continue_2").hide()
          $("#prod_click_continue_0").hide()
        $("#prod_click_continue_3").hide()
        $("#prod_click_continue_4").show()

        }
      
        
    },




 
  log_responses : function() {
        //console.log(this.stim.condition);
        exp.current_score_click += ((this.answer_status == "correct") ? 1 : 0)
        exp.total_quiz_trials_click += 1

       words = [];
       for(var i=1; i < 4; i++) {
         word = (document.getElementById("textfield"+i).innerHTML);
         words.push(word);
       }
             

        exp.data_trials.push({
          "enteredText" : words.join(" "),
          "correct" : this.answer_status,
          "slide_number" : exp.phase
        });
    },



    init_sliders : function() {
      utils.make_slider("#slider0", function(event, ui) {
        exp.sliderPost = ui.value;
      });
    },

  });











  slides.what_things_mean = slide({
    name : "what_things_mean",
    start : function(stim) {
      console.log(stim);
      $(".err").hide();
      document.getElementById("rofky_input").value = "";
      document.getElementById("glab_input").value = "";

      document.getElementById("adjective_1").textContent = (adjectives[0])
      document.getElementById("adjective_2").textContent = (adjectives[1])

    },

    button : function() {
    	//console.log(exp.sliderPost);
      result1 = document.getElementById("rofky_input").value;
      result2 = document.getElementById("glab_input").value;

      if (result1 != "" && result2 != "") {
        this.log_responses();
        exp.go(); //use exp.go() if and only if there is no "present" data.
      } else {
        $(".err").show();
      }
    },

    log_responses : function() {
        //console.log(this.stim.condition);
        exp.data_trials.push({
          "adj1_response" : document.getElementById("rofky_input").value,
          "adj2_response" : document.getElementById("glab_input").value,
          "slide_number" : exp.phase
        });
    },
  });




  slides.disagreement = slide({
    name : "disagreement",
    start : function(stim) {
      console.log(stim);
      $(".err").hide();

      this.init_sliders();
      exp.sliderPost1 = null;
      exp.sliderPost2 = null;

      document.getElementById("adjective_1_d").textContent = (adjectives[0])
      document.getElementById("adjective_2_d").textContent = (adjectives[1])

    },

    button : function() {
      if (exp.sliderPost1 != null && exp.sliderPost2 != null) {
        this.log_responses();
        exp.go(); //use exp.go() if and only if there is no "present" data.
      } else {
        $(".err").show();
      }

    },

    log_responses : function() {
        //console.log(this.stim.condition);
        exp.data_trials.push({
          "adj1_disagreement" : exp.sliderPost1,
          "adj2_disagreement" : exp.sliderPost2,
          "slide_number" : exp.phase
        });
    },


    init_sliders : function() {
      utils.make_slider("#slider_disag_1", function(event, ui) {
        exp.sliderPost1 = ui.value;
      });
      utils.make_slider("#slider_disag_2", function(event, ui) {
        exp.sliderPost2 = ui.value;
      });
    },
  });



  slides.subjectivity = slide({
    name : "subjectivity",
    start : function(stim) {
      console.log(stim);
      $(".err").hide();

      this.init_sliders();
      exp.sliderPost1 = null;
      exp.sliderPost2 = null;

      document.getElementById("adjective_1_s").textContent = (adjectives[0])
      document.getElementById("adjective_2_s").textContent = (adjectives[1])

    },

    button : function() {
    	//console.log(exp.sliderPost);
      result1 = document.getElementById("rofky_input").value;
      result2 = document.getElementById("glab_input").value;

      if (exp.sliderPost1 != null && exp.sliderPost2 != null) {
        this.log_responses();
        exp.go(); //use exp.go() if and only if there is no "present" data.
      } else {
        $(".err").show();
      }

    },

    log_responses : function() {
        //console.log(this.stim.condition);
        exp.data_trials.push({
          "adj1_subj" : exp.sliderPost1,
          "adj2_subj" : exp.sliderPost2,
          "slide_number" : exp.phase
        });
    },


    init_sliders : function() {
      utils.make_slider("#slider_subj_1", function(event, ui) {
        exp.sliderPost1 = ui.value;
      });
      utils.make_slider("#slider_subj_2", function(event, ui) {
        exp.sliderPost2 = ui.value;
      });
    },
  });





  slides.multi_slider_context = slide({
    name : "multi_slider_context",
    present : _.sample(stimuliContext,30),
    present_handle : function(stim) {
      console.log(stim);
      $(".err").hide();
      //$(".err2").hide();
      this.init_sliders();
      exp.sliderPost = null;
      this.stim = stim; //FRED: allows you to access stim in helpers

      $(".object").html('<img id="pngFrame" src="images/'+stim.object+'" style="width:250px;">');

      $(".low").html(" "+ stim.Predicate2 + " " + stim.Predicate1 + " " + "spaceship" + "");

      $(".high").html(" "+ stim.Predicate1 + " " + stim.Predicate2 + " " + "spaceship" + "");
//Wow, so many spikes -- I really love this...
      $(".alien_utterance").html('<p class=triangle-border left"> '+stim.text+'</p>');
          $(".alien").html('<img src="images/'+stim.alien+'" style="height:150px;">');
      console.log("DONE PRESENTING");

    },

    button : function() {
    	//console.log(exp.sliderPost);
      if (exp.sliderPost != null) {
        this.log_responses();
        _stream.apply(this); //use exp.go() if and only if there is no "present" data.
      } else {
        $(".err").show();
      }
    },

    init_sliders : function() {
      utils.make_slider("#slider0_ctxt", function(event, ui) {
        exp.sliderPost = ui.value;
      });
    },
    log_responses : function() {
        //console.log(this.stim.condition);
        exp.data_trials.push({
          "response" : exp.sliderPost,
          "predicate1" : this.stim.Predicate1,
          "predicate2" : this.stim.Predicate2,
          "text" : this.stim.text,
          "relevant_adjective" : this.stim.relevant_adjective,                     
          "slide_number" : exp.phase
        });
    },
  });




  slides.multi_slider = slide({
    name : "multi_slider",
    present : _.sample(stimuli,30),
    present_handle : function(stim) {
      $(".err").hide();
      //$(".err2").hide();
      this.init_sliders();
      exp.sliderPost = null;
      // $('input[name="sense"]:checked').attr('checked',false);
      this.stim = stim; //FRED: allows you to access stim in helpers


      var names_list = _.shuffle(names);

      var man1 = names_list[0];
      var man2 = names_list[1];

      //console.log(stim);
      $(".man1").html(man1);

      $(".man2").html(man2);

      $(".noun").html("spaceship");

      $(".object").html('<img id="pngFrame" src="images/'+stim.object+'" style="width:250px;">');

      $(".low").html("\"the "+ stim.Predicate2 + " " + stim.Predicate1 + " " + "spaceship" + "\"");

      $(".high").html("\"the "+ stim.Predicate1 + " " + stim.Predicate2 + " " + "spaceship" + "\"");


    },

    button : function() {
    	//console.log(exp.sliderPost);
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
    log_responses : function() {
        //console.log(this.stim.condition);
        exp.data_trials.push({
          "response" : exp.sliderPost,
          "noun" : this.stim.Noun,  
          "predicate1" : this.stim.Predicate1, // the version on the left has the order predicate1-predicate2-noun. The version on the right has the order predicate2-predicate1-noun
          "predicate2" : this.stim.Predicate2,
          "condition1" : this.stim.condition1,
          "condition2" : this.stim.condition2,                     
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
exp.structure.push( 'instructions1')
exp.structure.push( 'tutorial')
exp.structure.push('instructions2')
exp.structure.push('speaker_choice1')
exp.structure.push('instructions7')
exp.structure.push( 'production_click')
exp.structure.push('instructions6')
exp.structure.push( 'production')
exp.structure.push( 'tutorial')
exp.structure.push( 'production2')
exp.structure.push( 'instructions3')
exp.structure.push( 'multi_slider')
exp.structure.push('instructions8')
exp.structure.push( 'multi_slider_context')
exp.structure.push('subjectivity')
exp.structure.push('disagreement')
exp.structure.push('what_things_mean')
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
