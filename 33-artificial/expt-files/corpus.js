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

var ship = _.sample(["rocket2_COLOR_NUM.xcf.jpg", "saucer-1_COLOR_feet_NUM.xcf.jpg"]) //, "rocket1.png", "rocket2.png", "rocket3.png", "rocket4.png", "rocket5.png", "rocket-6.jpg", "saucer-2.png", "saucer-3.png", "saucer-4.jpg", "saucer-5.jpg", "saucer-6.png"];

// randomize whether adjective means saucer or rocket

var     adjectives = _.sample(["broff", "kolch", "muic", "yunt", "plach", "lann", "physs", "scrib", "glab"], 2);
var     adjectivesOrdered = _.shuffle(adjectives.concat());

// adjective1 is subjective, adjective2 is objective


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
console.log(ship);

var stimuli =  makeStims();
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
  for(var color=0; color<3; color++) {
    // stimulus where only color is necessary
     for(var repetition = 0; repetition < 1; repetition++) {
        range = _.sample(ranges);
        type = ship
        objects = [[0, type, colors[color], range]]

        // others
        for(var w = 0; w < 3; w++) {
          range2 = _.sample(ranges)
          type2 =  ship
          color2 = sampleExcept(colors, function(newColor) { return newColor != colors[color] })
          objects.push([1+w, type2, color2, range2])
        }
        addProductionStimulus(objects, {"suggestion" : colors[color]}, (Math.random() < 0.5) ? production_block_1 : production_block_2);
     }

    for(var q =0; q<2; q++) {
      // version where one adjective is enough
      for(var repetition = 0; repetition < 1; repetition++) {
        if(q == 0) { 'subjective'
          range = _.sample([3,4,5]);
          type = ship
          objects = [[0, type, colors[color], range]]

          // others
          for(var w = 0; w < 3; w++) {
            range2 = sampleExcept([1,2,3,4,5], function(newRange) { return newRange + 1 < range })
            type2 =  ship
            color2 = _.sample(colors)
            objects.push([1+w, type2, color2, range2])
          }

        } else { // 'objective'
           type = ship
           range = 3
           objects = [[0, type, colors[color], range]]

          // others
          for(var w = 0; w < 3; w++) {
           // get fourth object
           type4 = ship;
           range4 = sampleExcept([1,2,3,4,5], function(newRange) { return newRange != 3 })
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
         if(q == 0) { // subjective
           range = _.sample([3,4,5]);
           type = ship 
           objects = [[0, type, colors[color], range]]
   
           // get one confusable object with same color
           range2 = sampleExcept([1,2,3,4,5], function(newRange) { return newRange + 1 < range })
           type2 =  ship
           color2 = color
           objects.push([1, type2, colors[color2], range2])
   
           // get one confusable object with same range
           range3 = range
           type3 = ship
           color3 = sampleExcept(colors, function(newColor) { return newColor != colors[color] })
           objects.push([2, type3, color3, range3]);
   
           // get fourth object
           range4 = sampleExcept([1,2,3,4,5], function(newRange) { return newRange + 1 < range })
           type4 = ship
           color4 = sampleExcept(colors, function(newColor) { return newColor != colors[color] })
           objects.push([3, type4, color4, range4]);
   
         } else { // 'objective'
            type = ship 
            range = 3
            objects = [[0, type, colors[color], range]]
   
            // get one confusable object with the same color
            type2 = ship
            range2 = sampleExcept([1,2,3,4,5], function(newRange) { return newRange != 3 })
            objects.push([1, type2, colors[color], range2])
   
            // get one confusable object of the same type
            type3 = ship;
            range3 = _.sample(ranges)
            color3 = sampleExcept(colors, function(newColor) { return newColor != colors[color] })
            objects.push([2, type3, color3, range3])
   
            // get fourth object
            type4 = ship;
            range4 = sampleExcept([1,2,3,4,5], function(newRange) { return newRange != 3 })
            color4 = sampleExcept(colors, function(newColor) { return newColor != colors[color] })
            objects.push([3, type4, color4, range4])
   
         }
         addProductionStimulus(objects, "undefined", production_block_3);
      }
    }
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
            if(q == 0) { // subjective
                ship1 = ship;
                ship2 = ship;
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

           } else { // objective
                 shipName1 =ship 
      //console.log(shipName1);
      
                 shipName2 =ship 
      
                 colors = _.sample(["red", "green", "blue"],2)
                 scale0 = 3
                 scale1 = sampleExcept([1,2,3,4,5], function(newRange) { return newRange != 3 })

      //console.log(shipName1);
                   shipName1 = shipName1.replace("COLOR", colors[0]).replace("NUM", scale0)
                   shipName2 = shipName2.replace("COLOR", colors[1]).replace("NUM", scale1)
               
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
            if(i == 0) { // subjective
               ranges = [[1,2],[4,5]][1] // TODO confirm that the adjective means `many'
               scale = _.sample(ranges)
               ship0 = ship.replace("COLOR", color).replace("NUM", scale)
            } else { // objective
                 scale = 3
                 ship0 = ship.replace("COLOR", color).replace("NUM", scale)
            }
            addStimulus(adjective, color, ship0);
          }
          adjective = adjectives[i];
          distractors = ["big", "small"];
          for(distractor in distractors) {
             color = _.sample(["red", "green", "blue"],1)[0];
             // sample a compatible object
             if(exp.condition == 0) {
                  ship0 = ship.replace("COLOR", color).replace("NUM", scale)
             } else {
                    ship0 = ship.replace("COLOR", color).replace("NUM", scale)
             }
             addStimulus(adjective, distractors[distractor], ship0);

          }

       }

          ranges = _.sample([1,2,3,4,5],3)
          for(var range in ranges) {
             scale = ranges[range]
             color = _.sample(["red", "green", "blue"],1)[0];
             distractor = _.sample(["big", "small"],1)[0];
             // sample a compatible object
             ship0 = ship.replace("COLOR", color).replace("NUM", scale)
             addStimulus(color, distractor, ship0);
          }

          



         
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
          ship0 = ship.replace("COLOR", color).replace("NUM", range)

          stimulus = {
                      "relevant_adjective":relevant_adjective,
                      "text":text,
                      "Predicate1":adj1,
                      "Predicate2":adj2,
                      "object":ship0,
                      "alien":alien
                 };
          stims.push(stimulus);

     }
     colors = ["red", "green", "blue"];
     aliens = _.shuffle(["alien-1.jpg", "alien-2.png"]);

     text = "Wow, so many fins &#8210; I like this..."
     relevant_adjective = adjectives[0]
     alien = aliens[0];
     color = _.sample(colors);
     
     addStimulus(relevant_adjective, relevant_adjective, color, text, ship, alien, color, 5)

     text = "I like ships with exactly "+(ship[0] == "s" ? "three" : "six")  +" spikes. My favorite one is this..."
     relevant_adjective = adjectives[1]
     alien = aliens[0];
     color = _.sample(colors);
     
     addStimulus(relevant_adjective, relevant_adjective, color, text, ship, alien, color, 3)

     text = "Ugh, too many fins &#8210; I hate flying this..."
     relevant_adjective = adjectives[0]
     alien = aliens[1];
     color = _.sample(colors);
     
     addStimulus(relevant_adjective, relevant_adjective, color, text, ship, alien, color, 5)

     text = "I really don't like ships with many spikes, like this..."
     relevant_adjective = adjectives[0]
     alien = aliens[1];
     color = _.sample(colors);
     
     addStimulus(relevant_adjective, relevant_adjective, color, text, ship, alien, color, 5)

     text = "What a nice color. I like flying this..."
     color = _.sample(colors);
     relevant_adjective = color
     alien = aliens[0];
     
     addStimulus(relevant_adjective, relevant_adjective, adjectives[0], text, ship, alien, color, _.sample([3,4,5]))

     text = "I like ships that have the same color as I have, like this..."
     alien = aliens[1];
     color = (aliens[1][6] == '1' ? 'blue' : 'green')
     relevant_adjective = color
     
     addStimulus(relevant_adjective, relevant_adjective, adjectives[1], text, ship, alien, color, 3)

     text = "My first ship had the same shape as this..."
     alien = _.sample(aliens);
     relevant_adjective = adjectives[1] // + COLOR
     color = _.sample(colors);
     
     addStimulus(relevant_adjective, relevant_adjective, color, text, ship, alien, color, 3)

     text = "On our planet, many aliens fly ships like this..."
     alien = _.sample(aliens);
     relevant_adjective = "NONE"
     color = _.sample(colors);
     
     addStimulus("NONE", color, adjectives[0], text, ship, alien, color, _.sample([3,4,5]))
   

     if(ship[0] == "s") {
       text = "Humans think all our ships look like saucers, like this..."
     } else {
       text = "Humans think all our ships look like rockets, like this..."
     }
     alien = _.sample(aliens);
     relevant_adjective = "NONE"
     color = _.sample(colors);
     
     addStimulus(relevant_adjective, color, adjectives[1], text, ship, alien, color, 3)

     text = "My friend likes ships with "+(ship[0] == "s" ? "three" : "six")  +" fins. She used to fly this..."
     alien = _.sample(aliens);
     relevant_adjective = "NONE"
     color = _.sample(colors);
     
     addStimulus("NONE", color, adjectives[1], text, ship, alien, color, 3)


     text = "For long distances, I use ships with "+(ship[0] == "s" ? "three" : "six")  +" spikes. The best one is this..."
     alien = _.sample(aliens);
     relevant_adjective = adjectives[1]
     color = _.sample(colors);
     
     addStimulus(relevant_adjective, color, adjectives[1], text, ship, alien, color, 3)




     if(ship[0] == "s") {
       text = "For short distances, I use saucers. The best one is this..."
     } else {
       text = "For short distances, I use rockets. The best one is this..."
     }
     alien = _.sample(aliens);
     relevant_adjective = "NONE"
     color = _.sample(colors);
     
     addStimulus(relevant_adjective, color, adjectives[0], text, ship, alien, color, _.sample([4,5]))


         
     return _.shuffle(stims);
     
}

