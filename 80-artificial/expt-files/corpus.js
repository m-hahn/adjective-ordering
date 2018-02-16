// https://tc39.github.io/ecma262/#sec-array.prototype.includes
if (!Array.prototype.includes) {
  Object.defineProperty(Array.prototype, 'includes', {
    value: function(searchElement, fromIndex) {

      // 1. Let O be ? ToObject(this value).
      if (this == null) {
        throw new TypeError('"this" is null or not defined');
      }

      var o = Object(this);

      // 2. Let len be ? ToLength(? Get(O, "length")).
      var len = o.length >>> 0;

      // 3. If len is 0, return false.
      if (len === 0) {
        return false;
      }

      // 4. Let n be ? ToInteger(fromIndex).
      //    (If fromIndex is undefined, this step produces the value 0.)
      var n = fromIndex | 0;

      // 5. If n ≥ 0, then
      //  a. Let k be n.
      // 6. Else n < 0,
      //  a. Let k be len + n.
      //  b. If k < 0, let k be 0.
      var k = Math.max(n >= 0 ? n : len - Math.abs(n), 0);

      function sameValueZero(x, y) {
        return x === y || (typeof x === 'number' && typeof y === 'number' && isNaN(x) && isNaN(y));
      }

      // 7. Repeat, while k < len
      while (k < len) {
        // a. Let elementK be the result of ? Get(O, ! ToString(k)).
        // b. If SameValueZero(searchElement, elementK) is true, return true.
        // c. Increase k by 1. 
        if (sameValueZero(o[k], searchElement)) {
          return true;
        }
        k++;
      }

      // 8. Return false
      return false;
    }
  });
}

exp.condition = 0; //Math.floor(Math.random()*2);
console.log("Condition "+exp.condition)

var ships = _.shuffle(["rocket2_COLOR_NUM.xcf.jpg", "saucer-1_COLOR_feet_NUM.xcf.jpg"]) //, "rocket1.png", "rocket2.png", "rocket3.png", "rocket4.png", "rocket5.png", "rocket-6.jpg", "saucer-2.png", "saucer-3.png", "saucer-4.jpg", "saucer-5.jpg", "saucer-6.png"];

// randomize whether adjective means saucer or rocket

var     shipsGroupB1 = [ships[0]]; //"rocket1.png", "rocket2.png"] //, "rocket3.png", "rocket4.png", "rocket5.png", "rocket-6.jpg"];
var     shipsGroupB2 = [ships[1]]; //, "saucer-2.png"] //, "saucer-3.png", "saucer-4.jpg", "saucer-5.jpg", "saucer-6.png"];


// set the adjective set
// also, should randomize the orders in the questionnaires at the end
//var     adjectives = _.sample(["twell","lann","cref"],2) //_.sample(["broff", "kolch", "muic", "yunt", "plach", "lann", "physs", "scrib", "glab"], 2);

biglist = ["grirped","brirk","clou","fonns","spunes","spyck","fruith","squalf","phoys","jite","dwake","twad","therv","cuint","ghoice","yafs","blef","niege","trunce","preathe","joids","heaned","slalps","twawls","jaund","brame","irv","snurts","duilts","bamn","spraived","praife","juints","crooch","scorcs","fict","ceched","thomps","cref","gwigs","trafes","milbed","anns","toch","rhould","lised","olm","gelt","hafs","twell","broff", "kolch", "muic", "yunt", "plach", "lann", "physs", "scrib", "glab"]

//biglist = ["rofky", "glab"];

var adjectivesPre = _.sample(biglist, 2)

adjectivesPre[0]  =adjectivesPre[0] + "y"

var adjectives = _.shuffle(adjectivesPre)

var     adjectivesOrdered = _.shuffle(adjectives.concat());


// adjective1 is subjective, adjective2 is objective

var     shipsGroupA1 = [];
var     shipsGroupA2 = [];
     for(var i = 0; i<shipsGroupB1.length; i++) {
        if(i % 2 == 0) {
          shipsGroupA1.push(shipsGroupB1[i])
          shipsGroupA1.push(shipsGroupB2[i])
        } else {
          shipsGroupA2.push(shipsGroupB1[i])
          shipsGroupA2.push(shipsGroupB2[i])
        }
     }



     // in condition0:
var     shipsGroupC1 = ["rocket5", "saucer-1"] // Adj1, according to Alien1
var     shipsGroupC2 = ["rocket5", "saucer-2"] // Adj1, according to Alien2


var learning_block_1 = [];
var learning_block_2 = [];
var learning_block_3 = [];
var learning_block_4 = [];
var learning_block_5 = [];
var learning_block_6 = [];
var learning_block_7 = [];
var learning_block_8 = [];


var testing_block_1 = [];
var testing_block_2 = [];
var testing_block_3 = [];
var testing_block_4 = [];
var testing_block_5 = [];
var testing_block_6 = [];
var testing_block_7 = [];
var testing_block_8 = [];

moreInformative = _.sample(['subj', 'obj']);



//function allowDrop(ev) {
//    ev.preventDefault();
//}
//
//function drag(ev) {
//    ev.dataTransfer.setData("text", ev.target.id);
//}
//
//function drop(ev) {
//    ev.preventDefault();
//    var data = ev.dataTransfer.getData("text");
//    ev.target.appendChild(document.getElementById(data));
//}

console.log(adjectives);
console.log(ships);

var stimuli =  makeStims();
var learning_stimuli =  makeLearningStims();
var testing_stimuli = makeTestingStims();
var stimuliContext =  makeStimsContext();

//var production_stimuli = makeProductionStims();

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

var production_block_1 = []; // simple, group 1
var production_block_2 = []; // simple, group 2
var production_block_3 = []; // difficult, at most one alien adjective
var production_block_4 = []; // difficult, only alien adjectives

makeProductionStims();

var production_block_click_1 = production_block_1
var production_block_click_2 = production_block_2
var production_block_click_3 = production_block_3
var production_block_click_4 = production_block_4

var production_block_1 = []; // simple, group 1
var production_block_2 = []; // simple, group 2
var production_block_3 = []; // difficult, at most one alien adjective
var production_block_4 = []; // difficult, only alien adjectives

makeProductionStims();

function makeProductionStims() {
  stims = [];

  function addProductionStimulus(shipsList, suggestion, block) {
       if(suggestion != "undefined") {
         //console.log(suggestion)
         suggestionText = "the "+suggestion.suggestion+" ship"
       } else {
         suggestionText = undefined;
       }
     for(i=0; i<shipsList.length; i++) {
       color_i = shipsList[i][2]
       range_i = shipsList[i][3]

       fileName = shipsList[i][1].replace("COLOR", color_i).replace("NUM", range_i)
       //console.log(fileName);
       //console.log(shipsList[i]);
       shipsList[i] = {"index" : shipsList[i][0], "type" : shipsList[i][1], "color" : shipsList[i][2], "range" : shipsList[i][3], "fileName" : fileName}
     }
     stimulus = {"ships" : _.shuffle(shipsList), "suggestion" : suggestionText};
     stims.push(stimulus);
     block.push(stimulus);
  }



  // one alien, one color are both necessary
  colors = ["red", "green", "blue"];
  ranges = [1,2,3,4,5];
  rangesWithoutLowest = [2,3,4,5];
  for(var color=0; color<3; color++) {
    // stimulus where only color is necessary
     for(var repetition = 0; repetition < 1; repetition++) {
        range = _.sample(rangesWithoutLowest);
        type = _.sample(ships)
        objects = [[0, type, colors[color], range]]

        // others
        for(var w = 0; w < 3; w++) {
          if(moreInformative == 'subj') {
             type2 =  type
             if(range > 2) {
                range2 = sampleExcept(ranges, function(newRange) { return newRange +1 < range })
             } else {
               range2 = sampleExcept(ranges, function(newRange) { return newRange > range })
            }
          } else {
             if(type == ships[1]) {
                type2 =  sampleExcept(ships, function(newType) { return type != newType })
             } else {
                type2 = type
             }
             range2 = range
          }
          color2 = sampleExcept(colors, function(newColor) { return newColor != colors[color] })
          objects.push([1+w, type2, color2, range2])
        }
//        console.log("197")
        //console.log(objects);
  //      console.log(production_block_1);
    //    console.log(production_block_1);
        addProductionStimulus(objects, {"suggestion" : colors[color]}, (Math.random() < 0.5) ? production_block_1 : production_block_2);
     }

    for(var q =0; q<2; q++) {
      // version where one adjective is enough
      for(var repetition = 0; repetition < 1; repetition++) {
        if(q == 0) {
          range = _.sample([3,4,5]);
          type = _.sample(ships)
          objects = [[0, type, colors[color], range]]

          // others
          for(var w = 0; w < 3; w++) {
            range2 = sampleExcept([1,2,3,4,5], function(newRange) { return newRange + 1 < range })
            if(moreInformative == "subj") { // make sure the type is uninformative
                 type2 = type
            } else { // make sure the type is informative
                 type2 = sampleExcept(ships, function(newType) { return newType!= type })
            }
            color2 = _.sample(colors)
            objects.push([1+w, type2, color2, range2])
          }

        } else {
           type = ships[1] 
           range = _.sample(rangesWithoutLowest)
           objects = [[0, type, colors[color], range]]

          // others
          for(var w = 0; w < 3; w++) {
           // get fourth object
           type4 = ships[0];
           if(moreInformative == "subj") { // make sure the range is informative
             if(range > 2) {
                range4 = sampleExcept(ranges, function(newRange) { return newRange + 1 < range })
             } else {
                range = _.sample(ranges)
             }
           } else { // make sure the range is uninformative
                range4 = range
           }
//           range4 = _.sample(ranges)
           color4 = _.sample(colors)
           objects.push([1+w, type4, color4, range4])
         }
        }
        //console.log("232")
        //console.log(objects);
        addProductionStimulus(objects, {"suggestion" : adjectives[q]}, (Math.random() < 0.5) ? production_block_1 : production_block_2);
      }

      for(var repetition = 0; repetition < 2; repetition++) {
         // version where need two adjectives
         if(q == 0) {
           range = _.sample([3,4,5]);
           type = _.sample(ships)
           objects = [[0, type, colors[color], range]]
   
           // get one confusable object with same color
           range2 = sampleExcept([1,2,3,4,5], function(newRange) { return newRange + 1 < range })
           if(moreInformative == "subj") {
              type2 = type
           } else {
              type2 = sampleExcept(ships, function(newType) { return type != newType })
           }
           color2 = color
           objects.push([1, type2, colors[color2], range2])
   
           // get one confusable object with same range
           range3 = range
           if(moreInformative == "subj") {
              type3 = type
           } else {
              type3 = sampleExcept(ships, function(newType) { return type != newType })
           }
           color3 = sampleExcept(colors, function(newColor) { return newColor != colors[color] })
           objects.push([2, type3, color3, range3]);
   
           // get fourth object
           range4 = sampleExcept([1,2,3,4,5], function(newRange) { return newRange + 1 < range })
           if(moreInformative == "subj") {
              type4 = type
           } else {
              type4 = sampleExcept(ships, function(newType) { return type != newType })
           }
           color4 = sampleExcept(colors, function(newColor) { return newColor != colors[color] })
           objects.push([3, type4, color4, range4]);
   
         } else {
            type = ships[1] 
            range = _.sample(rangesWithoutLowest)
            objects = [[0, type, colors[color], range]]
   
            // get one confusable object with the same color
            type2 = ships[0]

            if(moreInformative == "subj") {
               if(range > 2) {
                  range2 = sampleExcept(ranges, function(newRange) { return newRange + 1 < range })
               } else {
                  range2 = _.sample(ranges)
               }
            } else {
               range2 = range
            }
            objects.push([1, type2, colors[color], range2])
   
            // get one confusable object of the same type
            type3 = ships[1];
            if(moreInformative == "subj") {
               if(range > 2) {
                  range3 = sampleExcept(ranges, function(newRange) { return newRange + 1 < range })
               } else {
                  range3 = _.sample(ranges)
               }
            } else {
               range3 = range
            }
            color3 = sampleExcept(colors, function(newColor) { return newColor != colors[color] })
            objects.push([2, type3, color3, range3])
   
            // get fourth object
            type4 = ships[0];
            if(moreInformative == "subj") {
               if(range > 2) {
                  range4 = sampleExcept(ranges, function(newRange) { return newRange + 1 < range })
               } else {
                  range4 = _.sample(ranges)
               }
            } else {
               range4 = range
            }
            color4 = sampleExcept(colors, function(newColor) { return newColor != colors[color] })
            objects.push([3, type4, color4, range4])
   
         }
         addProductionStimulus(objects, "undefined", production_block_3);
      }
    }
  }


// need both alien adjectives
// NOTE the choice of colors was buggy in the 15 version of this section
  for(var repetition = 0; repetition < 5; repetition++) {
     // version where need two adjectives
       range = _.sample([3,4,5]);
       type = ships[1]
       color = _.sample(colors);
       objects = [[0, type, color, range]]
  
       // get one confusable object with same type
       range2 = sampleExcept([1,2,3,4,5], function(newRange) { return newRange + 1 < range })
       type2 =  ships[1]
       color2 = color
       objects.push([1, type2, color2, range2])
  
       // get one confusable object with same range
       range3 = range
       type3 = ships[0]
       color3 = color
       objects.push([2, type3, color3, range3]);
  
       // get fourth object with the same color
       range4 = sampleExcept([1,2,3,4,5], function(newRange) { return newRange + 1 < range })
       type4 = ships[0]
       color4 = color
       objects.push([3, type4, color4, range4]);


       addProductionStimulus(objects, "undefined", production_block_4);
  }


  return _.shuffle(stims);

}

function makeTestingStims() {
   stims = [];
   
     negation = 0;
     function addStimulus(adjective, ships, correctAnswer, stimulusSets, adjIndex) {
             stimulus = {};
             stimulus.adj_index = adjIndex;
             stimulus.object_image1 = ships[0];
             stimulus.object_image2 = ships[1];
             stimulus.adjective = adjective;
             stimulus.alien_image = _.sample(["alien-1.jpg", "alien-2.png"],1);
             stimulus.correct_answer = correctAnswer
             stims.push(stimulus);
             for(var set = 0; set < stimulusSets.length; set++) {
                stimulusSets[set].push(stimulus);
             }
     }
        // AdjA1
     for(var repetition = 0; repetition < 2; repetition++) {
     for(var q=0; q<2; q++) { // adjective
        adjective = adjectives[q];

        for(var scale1 = 1; scale1 < 6; scale1++) {
          for(var scale2 = scale1+2; scale2<6; scale2++) {
            if(q == 0) {
                ship1 = _.sample(ships,1)[0];
                ship2 = _.sample(ships,1)[0];
                color1 = _.sample(["red", "green", "blue"],1)[0];
                color2 = _.sample(["red", "green", "blue"],1)[0];
                stimulusSets = [];
                stimulusSets.push(testing_block_1);
   
                ship1 = ship1.replace("COLOR", color1).replace("NUM", scale1)
                ship2 = ship2.replace("COLOR", color2).replace("NUM", scale2)
   
                if(scale1 == scale2) {
                    console.log("ERROR")
                }
                ordering = _.shuffle([[ship1, scale1], [ship2, scale2]])
                 // the correct adjective
                ship1 = ordering[0][0]
                ship2 = ordering[1][0]
                scale1a = ordering[0][1]
                scale2a = ordering[1][1]    
                // adj2 means few, adj1 means many     !!!!!
                correctAnswer = ((adjective == adjectives[1]) == (scale1a < scale2a)) ? "first" : "second"
                addStimulus(adjective, [ship1, ship2], correctAnswer, stimulusSets, q);

           } else {
                 shipName1 = _.sample(((q == 0) ? shipsGroupB1 : shipsGroupB2),1)[0]
      //console.log(shipName1);
      //console.log((shipsGroupB1 ? (adj == 0) : shipsGroupB2))
      //console.log((shipsGroupB1 ? true : shipsGroupB2))
      
                 shipName2 = _.sample(((q == 1) ? shipsGroupB1 : shipsGroupB2),1)[0]
      
                 colors = _.sample(["red", "green", "blue"],2)
                 scales = _.sample(_.range(1,6),2)
      //console.log(shipName1);
                   shipName1 = shipName1.replace("COLOR", colors[0]).replace("NUM", scales[0])
                   shipName2 = shipName2.replace("COLOR", colors[1]).replace("NUM", scales[1])
               
                 stimuli_temp = [[shipName1, true], [shipName2, false]]
                 stimuli_temp = _.shuffle(stimuli_temp)
                 correctAnswer = stimuli_temp[0][1] ? "first" : "second"
      
                   stimulusSets = [];
                   stimulusSets.push(testing_block_1);
      
                 addStimulus(adjective, [stimuli_temp[0][0], stimuli_temp[1][0]], correctAnswer, stimulusSets, q)
      } 
          }
        }
     }
}
      return _.shuffle(stims);
}

function makeLearningStims() {
     stims = [];
    
     adjA1 = adjectives[0]
     adjA2 = adjectives[1]
     adjB1 = adjectives[0]
     adjB2 = adjectives[1]

     negation = 0;
     function addStimulus(alien, negation, adjective, ship, stimulusSets, adjIndex, scalarModifier) {
             stimulus = {};
             stimulus.adj_index = adjIndex;
             stimulus.alien_image = ["alien-1.jpg", "alien-2.png"][alien];
             stimulus.object_image = ship;
             stimulus.negation = negation;
             stimulus.adjective = adjective;
             stimulus.scalar_modifier = scalarModifier;
             stims.push(stimulus);

             for(var set = 0; set < stimulusSets.length; set++) {
                stimulusSets[set].push(stimulus);
             }
     }
     for(var alien in [0,1]) {
        // AdjA1
        //if(exp.condition == 0) {
        for(var ship in ships) {
          for(var q = 0; q < 2; q++) { // the adjective
            for(var scale = 1; scale < 6; scale++) {
             colors = _.sample(["red", "green", "blue"],1);
             for(col in colors) {
               color = colors[col];
               shipName = ships[ship];
               //color = _.sample(["red", "green", "blue"],1)[0];
  
               negation = 0;
  
               stimulusSets = [];

               agreement = false;
               if(q == 0) { // the scalar adjective

                  agreement = true;
//                  if(scale == 3) {
  //                   continue;
    //              }
                  isSmall = (scale < 3)
     //             console.log(scale);
                  negation = (isSmall * (1-q)) + (1-isSmall)*(q)
                  scalarModifier = scale
               } else { // adjectives mean rocket vs saucer
                   agreement = true;

                   if(shipsGroupB1.includes(shipName)) {
                      negation = q
                  } else {
                      negation = (1-q)
                  }               
                  scalarModifier ="SHOULD_NOT_BE_DISPLAYED"
                  //console.log(shipName+"  "+negation);
               }
               
               if(true && (negation == 0) && q == 0) {
                   stimulusSets.push(learning_block_1);
               }
               if(true && (negation == 0) && q == 1) {
                   stimulusSets.push(learning_block_2);
               }

               if(true && (negation == 1) && q == 0) {
                   stimulusSets.push(learning_block_1);
               }
               if(true && (negation == 1) && q == 1) {
                   stimulusSets.push(learning_block_2);
               }

  
               shipName = shipName.replace("COLOR", color).replace("NUM", scale)
  
               adjective = adjectives[q];
               addStimulus(alien, negation, adjective, shipName, stimulusSets, q, scalarModifier);
             }
             }
          }
        }
      }
     
     return _.sample(stims,30);
     
}
function makeStims() {
     stims = [];

     // color
     // A or B, with matching adjective

     // distractor adjectives:
     // big, small
     
     function addStimulus(adjective, color, ship) {
          if(Math.random() > 0.5) {
             adj1 = adjective;
             adj2 = color;
          } else {
             adj2 = adjective;
             adj1 = color;
          }
             stimulus = {
                         "Predicate1":adj1,
                         "Predicate2":adj2,
                         "object":ship
                    };
             //console.log("STIMULUS");
             //console.log(stimulus)
             stims.push(stimulus);

     }
     colors = ["red", "green", "blue"];
       for(var i=0; i<2; i++) {
          adjective = adjectives[i];

          for(var colorIndex in colors) {
            color = colors[colorIndex]
            if(i == 0) {
               ranges = [[1,2],[4,5]][1] // TODO confirm that the adjective means `many'
               scale = _.sample(ranges)
               ship = _.sample(ships).replace("COLOR", color).replace("NUM", scale)
            } else { // i = 1
                 scale = _.sample([1,2,4,5])
                 ship = _.sample([shipsGroupB1, shipsGroupB2][i]).replace("COLOR", color).replace("NUM", scale)
            }
            addStimulus(adjective, color, ship);
          }


          // some bugs in this section were fixed November 13, 2017, after a worker pointed out that there was an incorrect ship image in one trial
          adjective = adjectives[i];
          distractors = ["big", "small"];
          for(distractor in distractors) {
             color = _.sample(["red", "green", "blue"],1)[0];
             // sample a compatible object
             if(i == 0) {
                  ranges = [[1,2],[4,5]][1]
                  scale = _.sample(ranges)
                  ship = _.sample(ships).replace("COLOR", color).replace("NUM", scale)
             } else {
                    scale = _.sample([1,2,3,4,5])
                    ship = _.sample([shipsGroupB1, shipsGroupB2][i]).replace("COLOR", color).replace("NUM", scale)
             }
             addStimulus(adjective, distractors[distractor], ship);

          }

       }

          ranges = _.sample([1,2,3,4,5],3)
          for(var range in ranges) {
             scale = ranges[range]
             color = _.sample(["red", "green", "blue"],1)[0];
             distractor = _.sample(["big", "small"],1)[0];
             // sample a compatible object
             ship = _.sample(ships).replace("COLOR", color).replace("NUM", scale)
             addStimulus(color, distractor, ship);
          }

          // a single item for the adjective pair
          range = _.sample([4,5])
          color = _.sample(["red", "green", "blue"]);
          ship = _.sample(shipsGroupB2).replace("COLOR", color).replace("NUM", scale)
          addStimulus(adjectives[0], adjectives[1], ship);
          



         
     return _.sample(stims,30);
     
}




function makeStimsContext() {
     stims = [];

     // color
     // A or B, with matching adjective

     // distractor adjectives:
     // big, small
    

     // Wow, so many spikes -- I really love this ...
     // I really don't like ships with many spikes, like this ...
     // Such a nice color -- I like this ...
     // 
 
     function addStimulus(relevant_adjective, adjective1, adjective2, text, ship, alien, color, range) {
          if(Math.random() > 0.5) {
             adj1 = adjective1;
             adj2 = adjective2;
          } else {
             adj2 = adjective1;
             adj1 = adjective2;
          }
          ship = ship.replace("COLOR", color).replace("NUM", range)

          stimulus = {
                      "relevant_adjective":relevant_adjective,
                      "text":text,
                      "Predicate1":adj1,
                      "Predicate2":adj2,
                      "object":ship,
                      "alien":alien
                 };
          stims.push(stimulus);

     }
     colors = ["red", "green", "blue"];
     aliens = _.shuffle(["alien-1.jpg", "alien-2.png"]);

     sentences = ["Wow -- I like this...", "I like ships of this type. My favorite one is this...", "Ugh, I hate flying this...", "I really don't like ships like this...", "What a nice color. I like flying this...", "I like ships that have this color, like this...", "My first ship had the same shape as this...", "Humans think all of our ships look like this...", "My friend used to fly this...", "For long distances, I use this...", "On our planet, many aliens fly ships like this..."]
     sentences = _.shuffle(sentences)

  ranges = [1,2,3,4,5];
  rangesHigh = [4,5];

     text = sentences.pop()
     relevant_adjective = adjectives[1]
     alien = aliens[0];
     color = _.sample(colors);
     ship = ships[1];
     range = _.sample(ranges)
     addStimulus(relevant_adjective, relevant_adjective, color, text, ship, alien, color, range)

     text = sentences.pop()
     relevant_adjective = adjectives[1]
     alien = aliens[0];
     color = _.sample(colors);
     ship = ships[1]
     range = _.sample(rangesHigh)
     addStimulus(relevant_adjective, relevant_adjective, adjectives[0], text, ship, alien, color, range)

     text = sentences.pop()
     relevant_adjective = adjectives[1]
     alien = aliens[1];
     color = _.sample(colors);
     ship = ships[1] 
     range = _.sample(ranges)
     addStimulus(relevant_adjective, relevant_adjective, color, text, ship, alien, color, range)

     text = sentences.pop()
     relevant_adjective = adjectives[1]
     alien = aliens[1];
     color = _.sample(colors);
     ship = ships[1]
     range = _.sample(rangesHigh)
     addStimulus(relevant_adjective, relevant_adjective, adjectives[0], text, ship, alien, color, range)

     text = sentences.pop()
     color = _.sample(colors);
     relevant_adjective = color
     alien = aliens[0];
     ship = ships[1] 
     range = _.sample(ranges)
     addStimulus(relevant_adjective, relevant_adjective, adjectives[1], text, ship, alien, color, range)

     text = sentences.pop()
     alien = aliens[1];
     color = _.sample(colors);
     relevant_adjective = color
     ship = _.sample(ships)
     range = _.sample(rangesHigh)
     addStimulus(relevant_adjective, relevant_adjective, adjectives[0], text, ship, alien, color, range)

     text = sentences.pop()
     alien = _.sample(aliens);
     relevant_adjective = adjectives[0] // + COLOR
     color = _.sample(colors);
     ship = _.sample(ships)
     range = _.sample(rangesHigh)
     addStimulus(relevant_adjective, relevant_adjective, color, text, ship, alien, color, range)

     text = sentences.pop()
     alien = _.sample(aliens);
     relevant_adjective = "NONE"
     color = _.sample(colors);
     ship = _.sample(ships)
     range = _.sample(rangesHigh)
     addStimulus("NONE", color, adjectives[0], text, ship, alien, color, range)
   
     text = sentences.pop()
     alien = _.sample(aliens);
     relevant_adjective = adjectives[0]
     color = _.sample(colors);
     ship = _.sample(ships);
     range = _.sample(rangesHigh)
     addStimulus(relevant_adjective, color, adjectives[0], text, ship, alien, color, range)

     text = sentences.pop()
     alien = _.sample(aliens);
     relevant_adjective = "NONE"
     color = _.sample(colors);
     ship = ships[1]
     range = _.sample(ranges)
     addStimulus("NONE", color, adjectives[1], text, ship, alien, color, range)


     text = sentences.pop()
     alien = _.sample(aliens);
     relevant_adjective = adjectives[0]
     color = _.sample(colors);
     ship = _.sample(ships);
     range = _.sample(rangesHigh)
     addStimulus(relevant_adjective, color, adjectives[0], text, ship, alien, color, range)


         
     return _.shuffle(stims);
     
}

