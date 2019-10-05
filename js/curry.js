const sum = x => y => x + y;

console.log(sum(2));

const partOfSum = sum(2);

console.log(partOfSum(4));

const someFunction = () => console.log('hello world');

const firstClass1 = functionAsArgument => functionAsArgument();

firstClass1(someFunction);

const firstClass2 = () => someFunction;
firstClass1(firstClass2());

// Currying allows us to partially apply functions. Basically you take a function with multiple arguments
// and you know that one of those arguments will have specific value but the other is undecided.
// Therefor by using curry, as a fancy partial application, you can create a new function which will
// allow you to deal only with the undecided arguments without repeating your code.
