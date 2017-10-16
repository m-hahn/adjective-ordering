
var stimuli =  makeStims();

function range(start,end, step) {
return Array.apply(null, Array(Math.floor((end-start+1.0)/step))).map(function (_, i) {return (step*i)+start;});
}

function sampleImage(value1, scale, value2, noun) {
   colorIndices = {}
   protoTypes = {}
   console.log("...")
   console.log(scale)
   console.log(value1)
   console.log(value2)
   if(noun == "ball" && value2 == "striped") {
     colorIndices["green"] = range(22,29,1);
     colorIndices["blue"] = range(0,7,1);
     colorIndices["red"] = range(12,19,1);
     protoTypes["green"] = 27
     protoTypes["blue"]  = 3
     protoTypes["red"]   = 16

   } else if(noun == 'cup' && value2 == 'plastic') {

     colorIndices["green"] = range(0,9,1);
     colorIndices["blue"] = range(10,22,1);
     colorIndices["red"] = range(24,29,1);

     protoTypes["green"] = 5
     protoTypes["blue"]  = 16
     protoTypes["red"]   = 27

   } else if(noun == 'cup' && value2 == 'wooden') {

     colorIndices["green"] = range(1,8,1);
     colorIndices["blue"] = range(10,18,1);
     colorIndices["red"] = range(24,29,1);

     protoTypes["green"] = 5
     protoTypes["blue"]  = 17
     protoTypes["red"]   = 27

   } else if(noun == 'ball' && value2 == 'spotted') {

     colorIndices["green"] = range(0,8,1);
     colorIndices["blue"] = range(9,20,1);
     colorIndices["red"] = range(22,29,1);

     protoTypes["green"] = 3
     protoTypes["blue"]  = 16
     protoTypes["red"]   = 27

   } else if(noun == 'ball' && value2 == 'checkered') {

     colorIndices["green"] = range(0,8,1);
     colorIndices["blue"] = range(9,20,1);
     colorIndices["red"] = range(22,29,1);

     protoTypes["green"] = 3
     protoTypes["blue"]  = 14
     protoTypes["red"]   = 26

   } else if(noun == 'ball' && value2 == 'solid') {

     colorIndices["green"] = range(0,8,1);
     colorIndices["blue"] = range(9,20,1);
     colorIndices["red"] = range(21,29,1);

     protoTypes["green"] = 3
     protoTypes["blue"]  = 15
     protoTypes["red"]   = 27

   } else if(noun == 'cup' && value2 == 'glass') {

     colorIndices["green"] = range(0,6,1);
     colorIndices["blue"] = range(7,17,1);
     colorIndices["red"] = range(18,29,1);

     protoTypes["green"] = 2
     protoTypes["blue"]  = 14
     protoTypes["red"]   = 26

   } else if(noun == 'cup' && value2 == 'metal') {

     colorIndices["green"] = range(0,7,1);
     colorIndices["blue"] = range(8,20,1);
     colorIndices["red"] = range(21,29,1);

     protoTypes["green"] = 3
     protoTypes["blue"]  = 14
     protoTypes["red"]   = 28

   } else {

     colorIndices["green"] = range(0,6,1);
     colorIndices["blue"] = range(7,16,1);
     colorIndices["red"] = range(26,29,1);

     protoTypes["green"] = 3
     protoTypes["blue"]  = 12
     protoTypes["red"]   = 27



//     return "blue_"+value2+"_"+noun+"_"+(_.sample(colorIndices[value1]));
   }



     if(scale != 0.5) {
       scales = colorIndices[value1];
       scale = scales[Math.floor(scale * (scales).length)];
     } else {
       scale = protoTypes[value1];
     }
   console.log(scale)
     console.log("return")


   if(noun == "ball" && value2 == "striped") {
     return "red_striped_ball_"+(scale)+"_SMALL.png";
   } else {
     return "blue_"+value2+"_"+noun+"_"+scale+"_SMALL.png";
   }








                      // 0 - 6 green
                   // 7-16 blue
                   // 21-29 red
                   // EXCEPT FOR STRIPED BALL -->
                   // 0-6 blue
                   // 10-18 red
                   // 22-29 green

   return(value1+"_"+value2+"_"+noun+".png");
}

function makeStims() {
	stims = [];
        
        nouns = ["cup", "ball"];
        dimensions = { "cup" : ["color", "material"],
                       "ball" : ["color", "texture"]
                     };
        values = { "color" : ["green", "blue", "red"], //, "purple", "yellow"],
                   "material" : ["glass", "wooden", "plastic", "metal"],
                   "texture" : ["spotted", "checkered", "striped", "solid"]
                 };
        
        // an ITEM is defined by noun, valuesDimA, valuesDimB. 
        // noun_index: 0, 1
        // condition_index: 0,1,2
        // order_index: 0,1: this one should better be randomized
        // choice of values for relevant dimension: 

        targets = []
        for(var noun_index = 0; noun_index <= 1; noun_index++) {
		noun = nouns[noun_index] //_.sample(nouns);
                relevant_dimension = dimensions[noun];

                targets[noun] = []
                
                valuesDimA = values[relevant_dimension[0]];
                valuesDimB = values[relevant_dimension[1]];
                for(val1 = 0; val1 < valuesDimA.length; val1++) {
                  for(val2 = 0; val2 < valuesDimB.length; val2++) {
                     targets[noun].push([valuesDimA[val1], valuesDimB[val2]]);
                  }
                }
        }
        console.log(targets);
        
	for(var noun_index = 0; noun_index <= 1; noun_index++) {
		noun = nouns[noun_index] //_.sample(nouns);

          targetsForNoun = _.shuffle(targets[noun])
          if(targetsForNoun.length != 12) {
             console.log("Unexpected length")
          }
                console.log(targetsForNoun[0]); 

          
          for(var condition_index = 0; condition_index <= 2; condition_index++) {
//            itemsForThisCondition = 5; // could differentiate between filler and critical conditions
  //          for(var valuesChoice = 0; valuesChoice <= 5; valuesChoice++) { // this is just to randomize how many items are presented in each the six conditions
            for(var orderCondition = 0; orderCondition <= 1; orderCondition++) {
                // for each of these 3*2 conditions, select 2 targets
              for(var target_num = 0; target_num <= 1; target_num++) {
                relevant_dimension = dimensions[noun];
             
                target = targetsForNoun.pop()

                console.log("....")

                console.log(noun) 
                console.log(target);

                valuesDimA = _.shuffle(values[relevant_dimension[0]]);
                valuesDimB = _.shuffle(values[relevant_dimension[1]]);
                for(var i = 0; i <= valuesDimA.length; i++) {
                   if(valuesDimA[i] == target[0]) {
                     valuesDimA.splice(i,1)
                     break;
                   }
                }
                for(var i = 0; i <= valuesDimB.length; i++) {
                   if(valuesDimB[i] == target[1]) {
                     valuesDimB.splice(i,1)
                     break;
                   }
                }               
                console.log(valuesDimA)
                console.log(valuesDimB)

                value1A = target[0]
                value2A = valuesDimA[0]
                value3A = valuesDimA[1]

                value1B = target[1]
                value2B = valuesDimB[0]
                value3B = valuesDimB[1]               


                if(valuesDimA == "color") {
                   
                }

//                orderCondition = _.sample([0,1]);
                
                imgs = [];
                group = condition_index
                // with massive informativity difference
                        scale1 = 0.5;
                        bound = 0.3;
                        while(scale1 > bound && scale1 < (1.0-bound)) {
                          console.log("+")
                          scale1 = Math.random();
                        }
                        scale2 = 0.5;
                        while(scale2 > bound && scale2 < (1.0-bound)) {
                          console.log("+")

                          scale2 = Math.random();
                        }

			imgs.push([sampleImage(value1A, 0.5, value1B, noun),"target"]);
			imgs.push([sampleImage(value2A, scale2, value1B, noun),"other"]);
			imgs.push([sampleImage(value1A, scale1, value2B, noun),"other"]);
			imgs.push([sampleImage(value1A, scale1, value2B, noun),"other"]);
			imgs.push([sampleImage(value1A, scale1, value2B, noun),"other"]);
			imgs.push([sampleImage(value2A, scale2, value1B, noun),"other"]);
			imgs.push([sampleImage(value2A, scale2, value1B, noun),"other"]);
			imgs.push([sampleImage(value2A, scale2, value2B, noun),"other"]);
			imgs.push([sampleImage(value1A, scale1, value2B, noun),"other"]);
			imgs.push([sampleImage(value2A, scale2, value1B, noun),"other"]);



				stims.push({
					"Predicate1":[value1A, value1B][[0,1][orderCondition]],
					//"Class1":"donotuse",	
					"Predicate2":[value1A, value1B][[1,0][orderCondition]],
					//"Class2":"donotuse",			
					"Noun":noun,
					//"NounClass":"donotuse",
                                        "imgs" : _.shuffle(imgs),
                                        "condition" : ["first_informative", "second_informative", "filler"][group],
//                                        "orderCondition" :   ,
                                        "item" : [value1A, value1B],
                                        "distractorValues" : [value2A, value2B, value3A, value3B]
				}			
			);
	}
}
}
}
		
	return stims;
	
}
