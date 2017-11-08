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


// from https://github.com/gscontras/adjective_ordering/blob/master/experiments/13-subjectivity-expanded/expt-files/materials.js
var classes = ["age","color","dimension","human","location","material","nationality","physical","shape","speed","temporal","value"];

var adjectives = [
		{	"Predicate":"biggest",	"Class":"dimension"	},
{	"Predicate":"large",	"Class":"dimension"	},
{	"Predicate":"long",	"Class":"dimension"	},
{	"Predicate":"mini",	"Class":"dimension"	},
{	"Predicate":"narrow",	"Class":"dimension"	},
{	"Predicate":"open",	"Class":"dimension"	},
{	"Predicate":"thick",	"Class":"dimension"	},
{	"Predicate":"thin",	"Class":"dimension"	},
{	"Predicate":"civilized",	"Class":"human"	},
{	"Predicate":"creative",	"Class":"human"	},
{	"Predicate":"entrepreneurial",	"Class":"human"	},
{	"Predicate":"playful",	"Class":"human"	},
{	"Predicate":"professional",	"Class":"human"	},
{	"Predicate":"sad",	"Class":"human"	},
{	"Predicate":"selfish",	"Class":"human"	},
{	"Predicate":"strict",	"Class":"human"	},
{	"Predicate":"Brazilian",	"Class":"nationality"	},
{	"Predicate":"English",	"Class":"nationality"	},
{	"Predicate":"European",	"Class":"nationality"	},
{	"Predicate":"Hispanic",	"Class":"nationality"	},
{	"Predicate":"international",	"Class":"nationality"	},
{	"Predicate":"Japanese",	"Class":"nationality"	},
{	"Predicate":"national",	"Class":"nationality"	},
{	"Predicate":"Vietnamese",	"Class":"nationality"	},
{	"Predicate":"creamy",	"Class":"physical"	},
{	"Predicate":"curly",	"Class":"physical"	},
{	"Predicate":"frozen",	"Class":"physical"	},
{	"Predicate":"lacy",	"Class":"physical"	},
{	"Predicate":"smooth",	"Class":"physical"	},
{	"Predicate":"solid",	"Class":"physical"	},
{	"Predicate":"spicy",	"Class":"physical"	},
{	"Predicate":"sweet",	"Class":"physical"	},
{	"Predicate":"best",	"Class":"value"	},
{	"Predicate":"exciting",	"Class":"value"	},
{	"Predicate":"favorite",	"Class":"value"	},
{	"Predicate":"lavish",	"Class":"value"	},
{	"Predicate":"plain",	"Class":"value"	},
{	"Predicate":"pleasant",	"Class":"value"	},
{	"Predicate":"prestigious",	"Class":"value"	},
{	"Predicate":"strange",	"Class":"value"	},
{	"Predicate":"designated",	"Class":"X"	},
{	"Predicate":"different",	"Class":"X"	},
{	"Predicate":"individual",	"Class":"X"	},
{	"Predicate":"last",	"Class":"X"	},
{	"Predicate":"mixed",	"Class":"X"	},
{	"Predicate":"potential",	"Class":"X"	},
{	"Predicate":"token",	"Class":"X"	},
{	"Predicate":"unique",	"Class":"X"	},
// {	"Predicate":"former",	"Class":"X"	}, // Cinque's seven
// {	"Predicate":"total",	"Class":"X"	},
// {	"Predicate":"mere",	"Class":"X"	},
// {	"Predicate":"possible",	"Class":"X"	},
// {	"Predicate":"alleged",	"Class":"X"	},
// {	"Predicate":"false",	"Class":"X"	},
// {	"Predicate":"fake",	"Class":"X"	},
{	"Predicate":"junior",	"Class":"age"	},
{	"Predicate":"new",	"Class":"age"	},
{	"Predicate":"old",	"Class":"age"	},
{	"Predicate":"old-time",	"Class":"age"	},
{	"Predicate":"senior",	"Class":"age"	},
{	"Predicate":"young",	"Class":"age"	},
{	"Predicate":"black",	"Class":"color"	},
{	"Predicate":"blonde",	"Class":"color"	},
{	"Predicate":"blue",	"Class":"color"	},
{	"Predicate":"green",	"Class":"color"	},
{	"Predicate":"purple",	"Class":"color"	},
{	"Predicate":"red",	"Class":"color"	},
{	"Predicate":"white",	"Class":"color"	},
{	"Predicate":"yellow",	"Class":"color"	},
{	"Predicate":"closest",	"Class":"location"	},
{	"Predicate":"internal",	"Class":"location"	},
{	"Predicate":"overhead",	"Class":"location"	},
{	"Predicate":"corduroy",	"Class":"material"	},
{	"Predicate":"crocheted",	"Class":"material"	},
{	"Predicate":"gold",	"Class":"material"	},
{	"Predicate":"wooden",	"Class":"material"	},
{	"Predicate":"circular",	"Class":"shape"	},
{	"Predicate":"square",	"Class":"shape"	}, // Greg added this one
{	"Predicate":"fast",	"Class":"speed"	},
{	"Predicate":"slow",	"Class":"speed"	},
{	"Predicate":"speedy",	"Class":"speed"	},
{	"Predicate":"current",	"Class":"temporal"	},
{	"Predicate":"daily",	"Class":"temporal"	},
{	"Predicate":"everyday",	"Class":"temporal"	},
{	"Predicate":"historical",	"Class":"temporal"	}
];
// 78 adjectives

var nouns = [
			{	"Noun":"time",	"NounClass":"X"	},
			{	"Noun":"form",	"NounClass":"X"	},
			{	"Noun":"thing",	"NounClass":"X"	},
			{	"Noun":"hair",	"NounClass":"X"	},
			{	"Noun":"conversation",	"NounClass":"X"	},
			{	"Noun":"offender",	"NounClass":"X"	},
			{	"Noun":"school",	"NounClass":"X"	},
			{	"Noun":"benefit",	"NounClass":"X"	},
			{	"Noun":"rate",	"NounClass":"X"	},
			{	"Noun":"club",	"NounClass":"X"	},
			{	"Noun":"type",	"NounClass":"X"	},
			{	"Noun":"burden",	"NounClass":"X"	},
			{	"Noun":"solution",	"NounClass":"X"	},
			{	"Noun":"policy",	"NounClass":"X"	},
			{	"Noun":"service",	"NounClass":"X"	},
			{	"Noun":"topic",	"NounClass":"X"	},
			{	"Noun":"coverage",	"NounClass":"X"	},
			{	"Noun":"term",	"NounClass":"X"	},
			{	"Noun":"recipe",	"NounClass":"X"	},
			{	"Noun":"one",	"NounClass":"X"	},
			{	"Noun":"area",	"NounClass":"X"	},
			{	"Noun":"tax",	"NounClass":"X"	},
			{	"Noun":"city",	"NounClass":"X"	},
			{	"Noun":"farm",	"NounClass":"X"	},
			{	"Noun":"mouth",	"NounClass":"X"	},
			{	"Noun":"list",	"NounClass":"X"	},
			{	"Noun":"phrase",	"NounClass":"X"	},
			{	"Noun":"sauce",	"NounClass":"X"	},
			{	"Noun":"background",	"NounClass":"X"	},
			{	"Noun":"stuff",	"NounClass":"X"	},
			{	"Noun":"color",	"NounClass":"X"	},
			{	"Noun":"music",	"NounClass":"X"	},
			{	"Noun":"way",	"NounClass":"X"	},
			{	"Noun":"place",	"NounClass":"X"	},
			{	"Noun":"slant",	"NounClass":"X"	},
			{	"Noun":"computer",	"NounClass":"X"	},
			{	"Noun":"word",	"NounClass":"X"	},
			{	"Noun":"typewriter",	"NounClass":"X"	},
			{	"Noun":"code",	"NounClass":"X"	},
			{	"Noun":"conscience",	"NounClass":"X"	},
			{	"Noun":"being",	"NounClass":"X"	},
			{	"Noun":"shot",	"NounClass":"X"	},
			{	"Noun":"style",	"NounClass":"X"	},
			{	"Noun":"report",	"NounClass":"X"	},
			{	"Noun":"problem",	"NounClass":"X"	},
			{	"Noun":"leadership",	"NounClass":"X"	},
			{	"Noun":"sound",	"NounClass":"X"	},
			{	"Noun":"paper",	"NounClass":"X"	},
			{	"Noun":"town",	"NounClass":"X"	},
			{	"Noun":"goal",	"NounClass":"X"	},
			{	"Noun":"letter",	"NounClass":"X"	},
			{	"Noun":"perspective",	"NounClass":"X"	},
			{	"Noun":"system",	"NounClass":"X"	},
			{	"Noun":"guy",	"NounClass":"X"	},
			{	"Noun":"world",	"NounClass":"X"	},
			{	"Noun":"power",	"NounClass":"X"	},
			{	"Noun":"food",	"NounClass":"X"	},
			{	"Noun":"feeling",	"NounClass":"X"	},
			{	"Noun":"sense",	"NounClass":"X"	},
			{	"Noun":"shell",	"NounClass":"X"	},
			{	"Noun":"enemy",	"NounClass":"X"	},
			{	"Noun":"meat",	"NounClass":"X"	},
			{	"Noun":"pet",	"NounClass":"X"	},
			{	"Noun":"death",	"NounClass":"X"	},
			{	"Noun":"coke",	"NounClass":"X"	},
			{	"Noun":"can",	"NounClass":"X"	},
			{	"Noun":"tollway",	"NounClass":"X"	},
			{	"Noun":"house",	"NounClass":"X"	},
			{	"Noun":"puppy",	"NounClass":"X"	},
			{	"Noun":"corporation",	"NounClass":"X"	},
			{	"Noun":"suit",	"NounClass":"X"	},
			{	"Noun":"reinforcement",	"NounClass":"X"	},
			{	"Noun":"parent",	"NounClass":"X"	},
			{	"Noun":"lifestyle",	"NounClass":"X"	},
			{	"Noun":"change",	"NounClass":"X"	},
			{	"Noun":"source",	"NounClass":"X"	},
			{	"Noun":"lab",	"NounClass":"X"	},
			{	"Noun":"dog",	"NounClass":"X"	},
			{	"Noun":"trial",	"NounClass":"X"	},
			{	"Noun":"driveway",	"NounClass":"X"	},
			{	"Noun":"autobiography",	"NounClass":"X"	},
			{	"Noun":"situation",	"NounClass":"X"	},
			{	"Noun":"actor",	"NounClass":"X"	},
			{	"Noun":"film",	"NounClass":"X"	},
			{	"Noun":"child",	"NounClass":"X"	},
			{	"Noun":"grandfather",	"NounClass":"X"	},
			{	"Noun":"grandchild",	"NounClass":"X"	},
			{	"Noun":"family",	"NounClass":"X"	},
			{	"Noun":"fish",	"NounClass":"X"	},
			{	"Noun":"pan",	"NounClass":"X"	},
			{	"Noun":"sand",	"NounClass":"X"	},
			{	"Noun":"behavior",	"NounClass":"X"	},
			{	"Noun":"joke",	"NounClass":"X"	},
			{	"Noun":"bin",	"NounClass":"X"	},
			{	"Noun":"value",	"NounClass":"X"	},
			{	"Noun":"hand",	"NounClass":"X"	},
			{	"Noun":"baby",	"NounClass":"X"	},
			{	"Noun":"casserole",	"NounClass":"X"	},
			{	"Noun":"rib",	"NounClass":"X"	},
			{	"Noun":"vacation",	"NounClass":"X"	},
			{	"Noun":"field",	"NounClass":"X"	},
			{	"Noun":"opinion",	"NounClass":"X"	},
			{	"Noun":"boat",	"NounClass":"X"	},
			{	"Noun":"plate",	"NounClass":"X"	},
			{	"Noun":"room",	"NounClass":"X"	},
			{	"Noun":"factor",	"NounClass":"X"	},
			{	"Noun":"book",	"NounClass":"X"	},
			{	"Noun":"satire",	"NounClass":"X"	},
			{	"Noun":"spaghetti",	"NounClass":"X"	},
			{	"Noun":"radio",	"NounClass":"X"	},
			{	"Noun":"college",	"NounClass":"X"	},
			{	"Noun":"day",	"NounClass":"X"	},
			{	"Noun":"labrador",	"NounClass":"X"	},
			{	"Noun":"nation",	"NounClass":"X"	},
			{	"Noun":"boy",	"NounClass":"X"	},
			{	"Noun":"snake",	"NounClass":"X"	},
			{	"Noun":"bearing",	"NounClass":"X"	},
			{	"Noun":"banking",	"NounClass":"X"	},
			{	"Noun":"income",	"NounClass":"X"	},
			{	"Noun":"wood",	"NounClass":"X"	},
			{	"Noun":"wind",	"NounClass":"X"	},
			{	"Noun":"luck",	"NounClass":"X"	},
			{	"Noun":"look",	"NounClass":"X"	},
			{	"Noun":"lettering",	"NounClass":"X"	},
			{	"Noun":"ride",	"NounClass":"X"	},
			{	"Noun":"region",	"NounClass":"X"	},
			{	"Noun":"party",	"NounClass":"X"	},
			{	"Noun":"story",	"NounClass":"X"	},
			{	"Noun":"shrimp",	"NounClass":"X"	},
			{	"Noun":"garbage",	"NounClass":"X"	},
			{	"Noun":"mall",	"NounClass":"X"	},
			{	"Noun":"brush",	"NounClass":"X"	},
			{	"Noun":"student",	"NounClass":"X"	},
			{	"Noun":"truth",	"NounClass":"X"	},
			{	"Noun":"trunk",	"NounClass":"X"	},
			{	"Noun":"level",	"NounClass":"X"	},
			{	"Noun":"ski",	"NounClass":"X"	},
			{	"Noun":"weather",	"NounClass":"X"	},
			{	"Noun":"strip",	"NounClass":"X"	},
			{	"Noun":"car",	"NounClass":"X"	},
			{	"Noun":"decision",	"NounClass":"X"	},
			{	"Noun":"voice",	"NounClass":"X"	},
			{	"Noun":"crime",	"NounClass":"X"	},
			{	"Noun":"point",	"NounClass":"X"	},
			{	"Noun":"number",	"NounClass":"X"	},
			{	"Noun":"life",	"NounClass":"X"	},
			{	"Noun":"luxury",	"NounClass":"X"	},
			{	"Noun":"resort",	"NounClass":"X"	},
			{	"Noun":"environment",	"NounClass":"X"	},
			{	"Noun":"reason",	"NounClass":"X"	},
			{	"Noun":"line",	"NounClass":"X"	},
			{	"Noun":"trash",	"NounClass":"X"	},
			{	"Noun":"money",	"NounClass":"X"	},
			{	"Noun":"teller",	"NounClass":"X"	},
			{	"Noun":"engine",	"NounClass":"X"	},
			{	"Noun":"valley",	"NounClass":"X"	},
			{	"Noun":"bag",	"NounClass":"X"	},
			{	"Noun":"vitamin",	"NounClass":"X"	},
			{	"Noun":"dough",	"NounClass":"X"	},
			{	"Noun":"country",	"NounClass":"X"	},
			{	"Noun":"plan",	"NounClass":"X"	},
			{	"Noun":"libertarian",	"NounClass":"X"	},
			{	"Noun":"citizen",	"NounClass":"X"	},
			{	"Noun":"research",	"NounClass":"X"	},
			{	"Noun":"issue",	"NounClass":"X"	},
			{	"Noun":"spirit",	"NounClass":"X"	}							
]; // 166 unique nouns from swbd




var stimuliDialogue = makeStimsDialogue();


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


var production_block_click_1 = production_block_1
var production_block_click_2 = production_block_2
var production_block_click_3 = production_block_3
var production_block_click_4 = production_block_4

var production_block_1 = []; // simple, group 1
var production_block_2 = []; // simple, group 2
var production_block_3 = []; // difficult, at most one alien adjective
var production_block_4 = []; // difficult, only alien adjectives



// https://stackoverflow.com/questions/1026069/how-do-i-make-the-first-letter-of-a-string-uppercase-in-javascript
function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}


console.log("TODO: to avoid metaphorical interpretations, instead of these nouns, take nouns that are actually modified by the respective adjective in a corpus")

function makeStimsDialogue() {
   stims = [];
   aliens = _.shuffle(["alien-1.jpg", "alien-2.png"]);


   sentences = ["This is ADJECTIVE.", "This is ARTICLE ADJECTIVE one.", "That is ARTICLE ADJECTIVE one.", "This one is ADJECTIVE.", "That one is ADJECTIVE.", "It is ADJECTIVE."]
   adjectivesChosen = _.sample(adjectives, 30)
   nounsChosen = _.sample(nouns, 30)
   for(var i=0; i<30; i++) {
      newStimulus = {}
      newStimulus.adjective = adjectivesChosen[i].Predicate;
      newStimulus.noun = nounsChosen[i].Noun;
      newStimulus.sentence = _.sample(sentences)
      
      if(["a","e","i","o","u"].includes(newStimulus.adjective.substr(0,1).toLowerCase())) {
         newStimulus.article = "an"
      } else {
         newStimulus.article = "a"
      }
      newStimulus.article = _.sample([newStimulus.article, "the"])
      if(newStimulus.adjective == "biggest") {
         newStimulus.article = "the"
      }
      newStimulus.pattern = newStimulus.sentence
      newStimulus.sentence = newStimulus.sentence.replace("ADJECTIVE", newStimulus.adjective).replace("NOUN", newStimulus.noun).replace("ARTICLE", newStimulus.article)
      stims.push(newStimulus)
   }


   return _.shuffle(stims);

}


