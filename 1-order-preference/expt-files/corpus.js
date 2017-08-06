// 40 most frequent noun-predicate combinations in the BNC

//[
//		{"Sentence": "box red", "Predicate": "red", "Noun": "box"},
//		{"Sentence": "box big", "Predicate": "big", "Noun": "box"}
//		]

var adjectives = _.shuffle([
		{"Predicate":"red", "Class":"color"},
		{"Predicate":"yellow", "Class":"color"},
		{"Predicate":"green", "Class":"color"},
		{"Predicate":"blue", "Class":"color"},
		{"Predicate":"purple", "Class":"color"},
		{"Predicate":"brown", "Class":"color"},											
		{"Predicate":"big", "Class":"size"},
		{"Predicate":"small", "Class":"size"},					
		{"Predicate":"huge", "Class":"size"},					
		{"Predicate":"tiny", "Class":"size"},					
		{"Predicate":"short", "Class":"size"},					
		{"Predicate":"long", "Class":"size"},							
		{"Predicate":"wooden", "Class":"material"},
		{"Predicate":"plastic", "Class":"material"},
		{"Predicate":"metal", "Class":"material"},
		{"Predicate":"smooth", "Class":"texture"},
		{"Predicate":"hard", "Class":"texture"},
		{"Predicate":"soft", "Class":"texture"},
		{"Predicate":"old", "Class":"age"},
		{"Predicate":"new", "Class":"age"},
		{"Predicate":"rotten", "Class":"age"},
		{"Predicate":"fresh", "Class":"age"},
		{"Predicate":"good", "Class":"quality"},
		{"Predicate":"bad", "Class":"quality"},
		{"Predicate":"round", "Class":"shape"},						
		{"Predicate":"square", "Class":"shape"}
]);

var nouns = [
		{"Noun":"apple", "NounClass":"food"},
		{"Noun":"banana", "NounClass":"food"},
		{"Noun":"carrot", "NounClass":"food"},
		{"Noun":"cheese", "NounClass":"food"},
		{"Noun":"tomato", "NounClass":"food"},								
		{"Noun":"chair", "NounClass":"furniture"},								
		{"Noun":"couch", "NounClass":"furniture"},								
		{"Noun":"fan", "NounClass":"furniture"},								
		{"Noun":"TV", "NounClass":"furniture"},								
		{"Noun":"desk", "NounClass":"furniture"}								
];

var stimuli =  makeStims();

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
        
	for(var noun_index = 0; noun_index <= 1; noun_index++) {
          for(var condition_index = 0; condition_index <= 2; condition_index++) {
            itemsForThisCondition = 5; // could differentiate between filler and critical conditions
            for(var valuesChoice = 0; valuesChoice <= 5; valuesChoice++) { // this is just to randomize how many items are presented in each the six conditions
		noun = nouns[noun_index] //_.sample(nouns);
                relevant_dimension = dimensions[noun];

                
                valuesDimA = _.shuffle(values[relevant_dimension[0]]);
                valuesDimB = _.shuffle(values[relevant_dimension[1]]);
                
                
                value1A = valuesDimA[0]
                value2A = valuesDimA[1]
                value3A = valuesDimA[2]

                value1B = valuesDimB[0]
                value2B = valuesDimB[1]
                value3B = valuesDimB[2]               

                orderCondition = _.sample([0,1]);

                
                        imgs = [];
                group = condition_index
                if(group == 0) {// A is informative
			imgs.push([value1A+"_"+value1B+"_"+noun+".png","target"]);
			imgs.push([value1A+"_"+value2B+"_"+noun+".png","other"]);
			imgs.push([value2A+"_"+value1B+"_"+noun+".png","other"]);
			imgs.push([value2A+"_"+value1B+"_"+noun+".png","other"]);
			imgs.push([value2A+"_"+value1B+"_"+noun+".png","other"]);
			imgs.push([value2A+"_"+value2B+"_"+noun+".png","other"]);
			imgs.push([value3A+"_"+value2B+"_"+noun+".png","other"]);
			imgs.push([value3A+"_"+value2B+"_"+noun+".png","other"]);
			imgs.push([value3A+"_"+value3B+"_"+noun+".png","other"]);
			imgs.push([value3A+"_"+value3B+"_"+noun+".png","other"]);
                } else if(group == 1) {// B is informative
			imgs.push([value1A+"_"+value1B+"_"+noun+".png","target"]);
			imgs.push([value2A+"_"+value1B+"_"+noun+".png","other"]);
			imgs.push([value1A+"_"+value2B+"_"+noun+".png","other"]);
			imgs.push([value1A+"_"+value2B+"_"+noun+".png","other"]);
			imgs.push([value1A+"_"+value2B+"_"+noun+".png","other"]);
			imgs.push([value2A+"_"+value2B+"_"+noun+".png","other"]);
			imgs.push([value2A+"_"+value3B+"_"+noun+".png","other"]);
			imgs.push([value2A+"_"+value3B+"_"+noun+".png","other"]);
			imgs.push([value3A+"_"+value3B+"_"+noun+".png","other"]);
			imgs.push([value3A+"_"+value3B+"_"+noun+".png","other"]);
                } else if(group == 2) {// both equally uninformative
			imgs.push([value1A+"_"+value1B+"_"+noun+".png","target"]);
			imgs.push([value2A+"_"+value1B+"_"+noun+".png","other"]);
			imgs.push([value1A+"_"+value2B+"_"+noun+".png","other"]);
			imgs.push([value1A+"_"+value2B+"_"+noun+".png","other"]);
			imgs.push([value1A+"_"+value2B+"_"+noun+".png","other"]);
			imgs.push([value2A+"_"+value3B+"_"+noun+".png","other"]);
			imgs.push([value2A+"_"+value1B+"_"+noun+".png","other"]);
			imgs.push([value2A+"_"+value2B+"_"+noun+".png","other"]);
			imgs.push([value3A+"_"+value3B+"_"+noun+".png","other"]);
			imgs.push([value3A+"_"+value1B+"_"+noun+".png","other"]);
                }





console.log(imgs)
				stims.push({
					"Predicate1":[value1A, value1B][[0,1][orderCondition]],
					"Class1":"HALLO",	
					"Predicate2":[value1A, value1B][[1,0][orderCondition]],
					"Class2":"HALLO",			
					"Noun":noun,
					"NounClass":"HALLO",
                                        "imgs" : _.shuffle(imgs),
                                        "condition" : group,
                                        "orderCondition" : orderCondition,
                                        "item" : [valuesDimA, valuesDimB]
				}			
			);
	}
}
}
		
	return stims;
	
}
