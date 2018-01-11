// webppl 14-base.js

// the number of adjectives
var n_adj = 4;

// the number of objects
var n_obj = 4;

// the number of speakers
// The utterance whose interpretation is simulated here is uttered by speaker 1
var n_speaker = 2;


// The set of possible utterances: every combination of two adjectives and nouns that is within the bounds given by n_adj (for the adjectives), n_obj (for the nouns)
var utterances = [[0, 0, 0], [0, 0, 1], [0, 0, 2], [0, 0, 3], [0, 1, 0], [0, 1, 1], [0, 1, 2], [0, 1, 3], [0, 2, 0], [0, 2, 1], [0, 2, 2], [0, 2, 3], [0, 3, 0], [0, 3, 1], [0, 3, 2], [0, 3, 3], [1, 0, 0], [1, 0, 1], [1, 0, 2], [1, 0, 3], [1, 1, 0], [1, 1, 1], [1, 1, 2], [1, 1, 3], [1, 2, 0], [1, 2, 1], [1, 2, 2], [1, 2, 3], [1, 3, 0], [1, 3, 1], [1, 3, 2], [1, 3, 3], [2, 0, 0], [2, 0, 1], [2, 0, 2], [2, 0, 3], [2, 1, 0], [2, 1, 1], [2, 1, 2], [2, 1, 3], [2, 2, 0], [2, 2, 1], [2, 2, 2], [2, 2, 3], [2, 3, 0], [2, 3, 1], [2, 3, 2], [2, 3, 3], [3, 0, 0], [3, 0, 1], [3, 0, 2], [3, 0, 3], [3, 1, 0], [3, 1, 1], [3, 1, 2], [3, 1, 3], [3, 2, 0], [3, 2, 1], [3, 2, 2], [3, 2, 3], [3, 3, 0], [3, 3, 1], [3, 3, 2], [3, 3, 3]]

// The two utterances under considerations: either the subjective adjective comes first, or the objective one 
var options = [[1,0,1], [0,1,1]]



/////////////////////////////

// Numerical parameters: Parameters in this section can be changed. As long as the adjectives differ in the inter-speaker correlations and loss probability increases with distance, the effects should come out in the predicted direction.

// the prior marginal probability of any judgment A(s,x)
var C = .2;

// the between-speaker correlations by adjectives, between-speaker agreement
// Adjective 1 is more "subjective", adjective 2 is more "objective"
var agreement = [.3, .9]

// Loss probabilities: lossProb2 should be larger than lossProb1.
// the probability that the word two words before the end of the current prefix is lost
var lossProb2 = .99
// the probability that the second-to-last word in the current prefix is lost
var lossProb1 = .00
// we could also allow the last word in the current prefix to be lost


///////////////////////////////

// Given an inter-speaker correlation, samples truth values for judgments A(s,x), A(s',x)
var prior_adj = function(agree) {
   return function(x) {    var j1 = flip(C)
                           var j2 = agree * (j1 ? 1 : 0) + (1-agree) * C;
                           return [j1, flip(j2)] };
}

// Samples from the prior over worlds
// Worlds are encoded as 3D arrays of truth values indexed as follows: world[Adjective][Object][Speaker] holds the truth value for the judgment Adjective(Speaker, Object)
var world_prior = function() {
 return [map(prior_adj(agreement[0]), _.range(n_adj)),map(prior_adj(agreement[1]), _.range(n_adj)),map(prior_adj(agreement[0]), _.range(n_adj)),map(prior_adj(agreement[1]), _.range(n_adj))];
}

// The meaning function, for complete utterances without loss.
// An utterance uttered by `person' is true in `world' if this person judges both adjectives to apply to the object
var meaning = function(utterance, world, person) {
     // utterance[0], utterance[1] are adjectives
     // utterance[2] is the noun, which we assume uniquely identified the object
     if(world[utterance[0]][utterance[2]][person] == false) {
       return 0;
     }
     if(world[utterance[1]][utterance[2]][person] == false) {
       return 0;
     }
     return 1;
}


// Takes a prefix and randomly replaces earlier words with -1
var corrupt = function(utterance) {
   if(utterance.length == 3) {
       var corruptFirst = flip(lossProb2)
       var corruptSecond = flip(lossProb1)
       var entry1 = (corruptFirst ? -1 : utterance[0])
       var entry2 = (corruptSecond ? -1 : utterance[1])
       return [entry1, entry2, utterance[2]]
   } else if(utterance.length == 2) {
       var corruptFirst = flip(lossProb1)
       var entry1 = (corruptFirst ? -1 : utterance[0])
       return [entry1, utterance[1]]
   }
   return utterance
}

// Checks whether a (possibly corrupted) prefix (e.g., [0,1] or [-1,1,1]) matches a full utterance (e.g., [0,1,1])
var is_compatible = function(full, partial) {
   if(partial[0] != -1 && partial[0] != full[0]) {
      return false;
   }
   if(partial.length == 1) {
      return true
   }
   if(partial[1] != -1 && partial[1] != full[1]) {
      return false;
   }
   if(partial.length == 2) {
      return true
   }
   if(partial[2] != full[2]) {
      return false;
   }
   return true;
}

// Collects and caches utterance compatible with a (possibly corrupted) prefix
var compatible_utterances = cache(function(partial_utterance) {
   return filter(function(x) { is_compatible(x, partial_utterance) }, utterances)
})

// The listener posterior after hearing the first word
var first = cache(function(prefix) {
   Infer({method : 'rejection', samples:1000, incremental:true,
       model() {
       var world = world_prior()
      var corruption1 = corrupt([prefix[0]])
      var compatible1 = compatible_utterances(corruption1)
      var compatibleSatisfying = any(function(x) { return meaning(x, world, 0) }, compatible1)
      factor(compatibleSatisfying ? 0 : -Infinity)
      return world;
     }})})

// Listener posterior after hearing the second word
var second = cache(function(prefix) {
   Infer({method : 'enumerate',
       model() {
       var world = sample(first([prefix[0]]))
      var corruption2 = corrupt([prefix[0], prefix[1]])
      var compatible2 = compatible_utterances(corruption2)
      var compatibleSatisfying = any(function(x) { return meaning(x, world, 0) }, compatible2)
      factor(compatibleSatisfying ? 0 : -Infinity)
      return world;
     }})})


// Listener posterior after hearing the third word
var third = cache(function(utterance) {
   Infer({method : 'enumerate', 
       model() {
       var world = sample(second([utterance[0], utterance[1]]))
      var corruption3 = corrupt([utterance[0], utterance[1], utterance[2]])
      var compatible3 = compatible_utterances(corruption3)
      var compatibleSatisfying = any(function(x) { return meaning(x, world, 0) }, compatible3)
      factor(compatibleSatisfying ? 0 : -Infinity)
      return world;
     }})})

// The marginal posterior probability of the judgment Adjective(Person, Object), after hearing an utterance
var marginal1Enum = cache(function(utterance, person, object, adjective) { Infer({method: 'enumerate',
      model() {
         var world = sample(third(utterance))
         return world[adjective][object][person] ? 1 : 0
      }})})


//////////////////////////////////////////////////////////////////////////
// Inspect the posterior by looking at the coordinate-wise marginals
//////////////////////////////////////////////////////////////////////////

// Recursively create the table of the posterior marginals
var computeMarginalPerson = function(utterance, adj, obj, person) {
   //var result = listMean(map(function(x) { return x.value }, marginal1(person, obj, adj).samples))
   var distribution = marginal1Enum(utterance, person, obj, adj).getDist()
   if(distribution['0'] != undefined && distribution['0']['val'] == 1) {
      return distribution['0']['prob']
   } else {
      return distribution['1']['prob']
   }
   return result
}

var computeMarginalObj = function(utterance, adj, obj) {
  if(obj == n_obj) {
    return [];
  } else {
    var first = map(function(person) { return computeMarginalPerson(utterance, adj, obj, person) }, _.range(n_speaker))
    var result = [first].concat(computeMarginalObj(utterance, adj,obj+1))
    return result
  }
}

var computeMarginalAdj = function(utterance) {
  return map(function(adj) { return computeMarginalObj(utterance, adj, 0)}, _.range(n_adj))
}


//////////////////////////////////////////////////////////////////////////
// Inspect the posterior by looking at the coordinate-wise marginals
//////////////////////////////////////////////////////////////////////////

console.log("MARGINALS: probability that a speaker attributes a property to an object")
console.log(options[0])
var marginalTable = computeMarginalAdj(options[0])
console.log("Adjective 1")
console.log(marginalTable[0])
console.log("Adjective 2")
console.log(marginalTable[1])
console.log("Adjective 3")
console.log(marginalTable[2])
console.log("Adjective 4")
console.log(marginalTable[3])
console.log("Key from outer to inner: object - person")

console.log("#########################")
console.log("MARGINALS: probability that a speaker attributes a property to an object")
console.log(options[1])
var marginalTable2 = computeMarginalAdj(options[1])
console.log("Adjective 1")
console.log(marginalTable2[0])
console.log("Adjective 2")
console.log(marginalTable2[1])
console.log("Adjective 3")
console.log(marginalTable2[2])
console.log("Adjective 4")
console.log(marginalTable2[3])
console.log("Key from outer to inner: object - person")

console.log("...........")
console.log("Marginals for the relevant dimensions")

console.log("After hearing Utterance "+options[0])
console.log("Marginals for relevant dimensions (by adjective, speaker, object)")
console.log( "A0(S0,O1) "+marginalTable[0][1][0])
console.log( "A0(S1,O1) "+marginalTable[0][1][1])
console.log( "A1(S0,O1) "+marginalTable[1][1][0])
console.log( "A1(S1,O1) "+marginalTable[1][1][1])
console.log("")
console.log("............")
console.log("After hearing Utterance "+options[1])
console.log("Marginals for relevant dimensions (by adjective, speaker, object)")
console.log( "A0(S0,O1) "+marginalTable2[0][1][0])
console.log( "A0(S1,O1) "+marginalTable2[0][1][1])
console.log( "A1(S0,O1) "+marginalTable2[1][1][0])
console.log( "A1(S1,O1) "+marginalTable2[1][1][1])


// Distribution over listener / third-party beliefs about the object
var restrictionToObjectsAndAdjectivesForSent = cache(function(sentence) {Infer({method: 'enumerate', //samples : 100, incremental:true,
      model() {
          var model = sample(third(sentence))
          return [model[0][1][1], model[1][1][1]];
     }})})

console.log(restrictionToObjectsAndAdjectivesForSent(options[0]))
console.log(restrictionToObjectsAndAdjectivesForSent(options[1]))


// The speaker chooses a sentence so a to minimize entropy of the posterior listener / third-party belief
var speaker = Infer({method : 'enumerate',
                     model() {
                     var sentence = options[sample(RandomInteger({n : 2}))];
                     factor(-entropy(restrictionToObjectsAndAdjectivesForSent(sentence)))
                     return sentence;
                    }})

console.log("Speaker Distribution: Subjective adjective is preferred earlier")
console.log(speaker);

1



