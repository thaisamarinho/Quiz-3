// 1. Visit this page http://vancouver.craigslist.ca and write a piece of jQuery code that changes all the links on the home page to have a color red if the link's anchor text includes the pattern eal (5%)

  $("a:contains('eal')").css('color', 'red')

// 2. Visit a Wikipedia page like this one: https://en.wikipedia.org/wiki/Rule_of_three_(computer_programming) then write a peice of jQuery code that will fadeOut any link you click on without following the link. (5%)

$('a').click(function(event){
$(this).fadeOut(1000);
event.preventDefault()});

// 3. Write a Javascript code to do the following: Implement filter function in Javascript (5%)

var isEven = function(number) {
  return number % 2 == 0;
};

var filter = function(array, fn) {
  var resultArray = [];
  for(i = 0; i < array.length; i++){
    if(fn(array[i])){
      resultArray.push(array[i])
    };
  };
  return resultArray;
};

console.log(filter([1,2,3,4], isEven));
