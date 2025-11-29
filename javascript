# JavaScript Complete Guide

## Table of Contents
1. [Fundamentals](#fundamentals)
2. [Data Types](#data-types)
3. [Operators](#operators)
4. [Control Flow](#control-flow)
5. [Functions](#functions)
6. [Objects](#objects)
7. [Arrays](#arrays)
8. [String Methods](#string-methods)
9. [Promises & Async/Await](#promises--asyncawait)
10. [Classes & OOP](#classes--oop)
11. [DOM Manipulation](#dom-manipulation)
12. [Events](#events)
13. [Error Handling](#error-handling)
14. [ES6+ Features](#es6-features)
15. [Common Patterns](#common-patterns)

---

## Fundamentals

### Theory: What is JavaScript?

JavaScript is a **dynamic, interpreted programming language** designed for the web. Key characteristics:

- **Dynamically Typed**: Variables don't need explicit type declarations; types are determined at runtime
- **Loosely Typed**: Types can change during execution (type coercion)
- **Interpreted**: Code is executed line-by-line by a JavaScript engine (V8, SpiderMonkey, etc.)
- **Event-Driven**: Built for responding to user interactions
- **Functional & Object-Oriented**: Supports both paradigms

**Execution Model:**
JavaScript runs in a **single-threaded event loop** with an asynchronous, non-blocking I/O model:
1. **Call Stack**: Executes synchronous code
2. **Event Loop**: Manages asynchronous operations
3. **Task Queue/Microtask Queue**: Holds callbacks for execution

### Variables
JavaScript has three ways to declare variables:

```javascript
// var - function scoped (legacy, avoid)
var age = 25;

// let - block scoped (preferred)
let name = "John";

// const - block scoped, cannot be reassigned (preferred for constants)
const PI = 3.14159;

// Difference between let and const
let x = 1;
x = 2; // ✅ Allowed, let can be reassigned

const y = 1;
y = 2; // ❌ Error: Assignment to constant variable

// Note: const object can still have properties modified
const person = { name: "John" };
person.name = "Jane"; // ✅ Allowed, modifying property
person = {}; // ❌ Error: cannot reassign
```

### Hoisting
```javascript
// Variables and functions are hoisted (moved to top of scope)

console.log(x); // undefined (not an error!)
var x = 5;

// Above code is interpreted as:
// var x;
// console.log(x); // undefined
// x = 5;

// let and const are hoisted but not initialized
console.log(y); // ReferenceError: Cannot access 'y' before initialization
let y = 5;
```

**Hoisting Explained:**
Hoisting is JavaScript's behavior of moving **declarations** to the top of their scope before code execution. Important distinctions:

- **`var` hoisting**: Declaration is hoisted and initialized with `undefined`
  - Can be used before declaration (returns `undefined`)
- **`let`/`const` hoisting**: Declaration is hoisted but NOT initialized (Temporal Dead Zone)
  - Cannot be used before declaration (throws ReferenceError)
- **Function declaration hoisting**: Entire function is hoisted (can be called before declaration)
- **Function expression hoisting**: Only the variable declaration is hoisted, not the function

```javascript
// Function declaration - fully hoisted
sayHi(); // "Hello!" - works!
function sayHi() { console.log("Hello!"); }

// Function expression - not fully hoisted
sayBye(); // TypeError: sayBye is not a function
var sayBye = function() { console.log("Bye!"); };

// Temporal Dead Zone (TDZ) example
console.log(typeof x); // "undefined" (var)
console.log(typeof y); // ReferenceError (let is in TDZ)
var x = 1;
let y = 2;
```

---

## Data Types

### Theory: The Type System

JavaScript has **7 primitive types** and **1 composite type** (Object):

**Primitives** (immutable, stored by value):
- Cannot be modified after creation
- Comparisons check actual values
- Passed by value to functions

**Objects** (mutable, stored by reference):
- Can be modified after creation
- Comparisons check reference, not content
- Passed by reference to functions
- Everything not primitive is an object (functions, arrays, dates, etc.)

```javascript
// Primitive - stored by value
let a = 5;
let b = a;
b = 10;
console.log(a); // 5 (unchanged)

// Object - stored by reference
let obj1 = { value: 5 };
let obj2 = obj1;
obj2.value = 10;
console.log(obj1.value); // 10 (changed!)
```

### Primitive Types
```javascript
// 1. String
const str = "Hello World";
const str2 = 'Single quotes also work';
const str3 = `Template literals ${1 + 2}`; // "Template literals 3"

// 2. Number
const int = 42;
const float = 3.14;
const scientific = 1e3; // 1000
const infinity = Infinity;
const notANumber = NaN; // "Not a Number"

// 3. Boolean
const isTrue = true;
const isFalse = false;

// 4. Null (intentional absence of value)
const empty = null;

// 5. Undefined (variable declared but not assigned)
let notAssigned;
console.log(notAssigned); // undefined

// 6. Symbol (unique identifier)
const sym = Symbol('description');
const sym2 = Symbol('description');
console.log(sym === sym2); // false - each symbol is unique

// 7. BigInt (for very large integers)
const bigNum = 1234567890123456789012345n;
const bigNum2 = BigInt('1234567890123456789012345');
```

### Type Checking
```javascript
// typeof operator
console.log(typeof "string"); // "string"
console.log(typeof 42); // "number"
console.log(typeof true); // "boolean"
console.log(typeof null); // "object" (quirk: null is object)
console.log(typeof undefined); // "undefined"
console.log(typeof Symbol('x')); // "symbol"
console.log(typeof 1n); // "bigint"
console.log(typeof []); // "object" (arrays are objects)
console.log(typeof {}); // "object"
console.log(typeof function(){}); // "function"

// instanceof operator (for complex types)
console.log([] instanceof Array); // true
console.log({} instanceof Object); // true
console.log(new Date() instanceof Date); // true
```

### Type Coercion

**Type Coercion Theory:**
Automatic type conversion occurs when operations involve different types. JavaScript has rules for determining what type an expression should become:

- **String Concatenation Rule**: If one operand is a string, convert other to string
- **Numeric Operation Rule**: For arithmetic (except +), convert to numbers
- **Boolean Context Rule**: In conditionals, convert to boolean

```javascript
// Implicit coercion
console.log("5" + 3); // "53" (string concatenation)
console.log("5" - 3); // 2 (numeric operation)
console.log("5" * "2"); // 10 (numeric operation)
console.log(true + 1); // 2 (true converts to 1)
console.log(false + 1); // 1 (false converts to 0)

// Falsy values: false, 0, "", null, undefined, NaN
if ("" || "default") console.log("default"); // prints "default"
if (0 || 5) console.log(5); // prints 5

// Explicit coercion
Number("5"); // 5
String(42); // "42"
Boolean(1); // true
Boolean(0); // false
```

**Coercion Gotchas:**
```javascript
// Common surprises
"5" == 5 // true (loose equality allows coercion)
"5" === 5 // false (strict equality, no coercion)
[] == false // true (array coerces to empty string, then to 0, false to 0)
null == undefined // true (special rule)
null === undefined // false (different types)
```

---

## Operators

### Theory: Operator Precedence and Associativity

**Operator Precedence** determines which operations are evaluated first. Higher precedence = evaluated first:

| Precedence | Operators | Associativity |
|-----------|-----------|---------------|
| 1 | `()` `[]` `.` | Left-to-right |
| 2 | `++` `--` (postfix) | Right-to-left |
| 3 | `!` `~` `+` `-` (unary) | Right-to-left |
| 4 | `**` (exponentiation) | Right-to-left |
| 5 | `*` `/` `%` | Left-to-right |
| 6 | `+` `-` (binary) | Left-to-right |
| 7 | `<<` `>>` | Left-to-right |
| 8 | `<` `<=` `>` `>=` | Left-to-right |
| 9 | `==` `!=` `===` `!==` | Left-to-right |
| 10 | `&&` | Left-to-right |
| 11 | `||` | Left-to-right |
| 12 | `? :` (ternary) | Right-to-left |
| 13 | `=` `+=` `-=` etc. | Right-to-left |

```javascript
// Precedence example
2 + 3 * 4; // 14 (multiply first, then add)
(2 + 3) * 4; // 20 (parentheses override)

// Associativity example
10 - 5 - 2; // 3 (left-to-right: (10-5)-2 = 3)
2 ** 2 ** 3; // 256 (right-to-left: 2**(2**3) = 2**8)
```

### Arithmetic Operators
```javascript
console.log(5 + 3); // 8 (addition)
console.log(5 - 3); // 2 (subtraction)
console.log(5 * 3); // 15 (multiplication)
console.log(5 / 2); // 2.5 (division)
console.log(5 % 2); // 1 (modulo/remainder)
console.log(2 ** 3); // 8 (exponentiation)
console.log(++x); // pre-increment
console.log(x++); // post-increment
```

### Comparison Operators
```javascript
console.log(5 === "5"); // false (strict equality - checks type)
console.log(5 == "5"); // true (loose equality - coerces types)
console.log(5 !== "5"); // true (strict inequality)
console.log(5 != "5"); // false (loose inequality)
console.log(5 > 3); // true
console.log(5 >= 3); // true
console.log(5 < 3); // false
console.log(5 <= 3); // false
```

### Comparison Operators

**Equality Operators Theory:**
- **Loose Equality (`==`)**: Performs type coercion before comparison (not recommended)
- **Strict Equality (`===`)**: No type coercion; both type and value must match (preferred)

```javascript
console.log(5 === "5"); // false (strict equality - checks type)
console.log(5 == "5"); // true (loose equality - coerces types)
console.log(5 !== "5"); // true (strict inequality)
console.log(5 != "5"); // false (loose inequality)
console.log(5 > 3); // true
console.log(5 >= 3); // true
console.log(5 < 3); // false
console.log(5 <= 3); // false
```

**Best Practice**: Always use `===` and `!==` to avoid unexpected type coercion bugs.

### Logical Operators

**Short-Circuit Evaluation Theory:**
Logical operators don't always evaluate both operands. If the result can be determined from the first operand, the second is skipped:

- **`&&` (AND)**: Returns first falsy value or last truthy value
- **`||` (OR)**: Returns first truthy value or last falsy value
- **`!` (NOT)**: Always evaluates (unary operator)

```javascript
// AND operator (&&)
console.log(true && true); // true
console.log(true && false); // false
console.log(5 > 3 && 10 > 5); // true

// OR operator (||)
console.log(true || false); // true
console.log(false || false); // false
console.log(5 > 10 || 10 > 5); // true

// NOT operator (!)
console.log(!true); // false
console.log(!false); // true

// Short-circuit evaluation
let result = false && someUndefinedFunction(); // someUndefinedFunction NOT called
let result2 = true || someUndefinedFunction(); // someUndefinedFunction NOT called

// Practical use
const name = userInput || "Guest"; // Use name if provided, else "Guest"
const admin = user && user.isAdmin; // Only access isAdmin if user exists
```

### Nullish Coalescing (??) and Optional Chaining (?.)

**Nullish Coalescing (`??`) Theory:**
- Returns the right operand only if the left is `null` or `undefined`
- Different from `||` which considers any falsy value (0, "", false, NaN)
- Useful for providing defaults while preserving falsy values

**Optional Chaining (`?.`) Theory:**
- Safely accesses deeply nested properties without errors
- Returns `undefined` if any intermediate value is null/undefined
- Works with properties, methods, and computed properties
- Prevents "Cannot read property of null/undefined" errors

```javascript
// Nullish coalescing - returns right if left is null/undefined
const value = null ?? "default"; // "default"
const value2 = 0 ?? "default"; // 0 (not nullish, so 0 is used)

// Optional chaining - safely access nested properties
const user = { name: "John", address: { city: "NYC" } };
console.log(user?.name); // "John"
console.log(user?.age); // undefined (no error)
console.log(user?.address?.city); // "NYC"
console.log(user?.address?.country); // undefined (no error)

// Optional chaining with arrays
const arr = [1, 2, 3];
console.log(arr?.[0]); // 1
const nullArr = null;
console.log(nullArr?.[0]); // undefined (no error)

// Optional chaining with functions
const obj = {
  method: () => console.log("called")
};
obj?.method?.(); // calls the method safely
```

### Ternary Operator

**Conditional Operator (`? :`) Theory:**
- Returns one of two values based on a condition
- More concise than if/else for simple conditions
- Can be chained but nested ternaries reduce readability
- Execution is lazy: only the chosen branch is evaluated

```javascript
const age = 18;
const status = age >= 18 ? "adult" : "minor";
console.log(status); // "adult"

// Nested ternary
const score = 85;
const grade = score >= 90 ? "A" : score >= 80 ? "B" : score >= 70 ? "C" : "F";
console.log(grade); // "B"

// Better alternative for complex conditions
const grade2 = 
  score >= 90 ? "A" :
  score >= 80 ? "B" :
  score >= 70 ? "C" : "F";
```

---

## Control Flow

### Theory: Program Execution Flow

**Control flow** is the order in which statements are executed. JavaScript provides mechanisms to control this:

1. **Sequential**: Execute statements in order (default)
2. **Conditional**: Execute based on conditions (if/else, switch)
3. **Repetitive**: Execute statements multiple times (loops)
4. **Jump**: Transfer control (break, continue, return)

### if/else Statements

**Conditional Statements Theory:**
- Allows different code paths based on conditions
- Conditions are evaluated for truthiness (not just true/false)
- `else if` allows multiple conditions without nesting
- Avoid deeply nested conditions (use early returns instead)

```javascript
const age = 20;

if (age < 13) {
  console.log("Child");
} else if (age < 18) {
  console.log("Teenager");
} else {
  console.log("Adult");
}

// switch statement - efficient for multiple exact matches
const day = 3;
switch (day) {
  case 1:
    console.log("Monday");
    break;
  case 2:
    console.log("Tuesday");
    break;
  case 3:
    console.log("Wednesday");
    break;
  default:
    console.log("Unknown day");
}
```

**Switch vs if/else:**
- Use `switch` when testing a single value against many options
- Use `if/else` for complex conditions or ranges
- Remember `break` statements (fall-through can be intentional but is often a bug)

### Loops

#### for Loop

**Loop Theory:**
- **for**: Best for loops with known iteration count
- **while**: Best for loops with unknown iteration count
- **do...while**: Executes at least once, regardless of condition
- **for...in**: Iterates over enumerable property keys (objects and arrays)
- **for...of**: Iterates over iterable values (arrays, strings, Sets, etc.)

```javascript
// Traditional for loop - most common, full control
for (let i = 0; i < 5; i++) {
  console.log(i); // 0, 1, 2, 3, 4
}

// for...in loop (iterates over keys/indices) - use for objects
const obj = { a: 1, b: 2, c: 3 };
for (const key in obj) {
  console.log(key, obj[key]); // a 1, b 2, c 3
}

// for...of loop (iterates over values) - use for arrays
const arr = [10, 20, 30];
for (const value of arr) {
  console.log(value); // 10, 20, 30
}

// for...of with arrays gives you values (not indices)
// for...in with arrays gives you indices (as strings)
```

**for...in vs for...of:**
- `for...in`: Returns property names/indices (strings), includes inherited properties
- `for...of`: Returns actual values, only works with iterables

#### while and do...while Loops
```javascript
// while loop
let i = 0;
while (i < 3) {
  console.log(i); // 0, 1, 2
  i++;
}

// do...while (executes at least once)
let j = 0;
do {
  console.log(j); // prints 0
  j++;
} while (j < 0);
```

### Loop Control

**Break and Continue Theory:**
- **`break`**: Immediately terminates the loop, continues after it
- **`continue`**: Skips remaining statements in current iteration, proceeds to next
- **Labels** (rarely used): Can break/continue labeled blocks

```javascript
// break - exits loop
for (let i = 0; i < 10; i++) {
  if (i === 5) break;
  console.log(i); // 0, 1, 2, 3, 4
}

// continue - skips current iteration
for (let i = 0; i < 5; i++) {
  if (i === 2) continue;
  console.log(i); // 0, 1, 3, 4
}
```

---

## Functions

### Theory: Functions and Scope

**What are Functions?**
Functions are reusable blocks of code that perform specific tasks. They enable:
- **Code reusability**: Write once, use many times
- **Modularity**: Break code into logical pieces
- **Encapsulation**: Create local scope and protect variables
- **Abstraction**: Hide complex logic behind simple interface

**Function Scope:**
JavaScript has **function scope** and **block scope**:
- Variables declared with `var` are function-scoped
- Variables declared with `let`/`const` are block-scoped
- Each function creates a new execution context

**The `this` Keyword:**
- In regular functions, `this` refers to the calling object (or `window`/`undefined` in strict mode)
- In arrow functions, `this` is lexically bound (inherits from enclosing scope)
- In methods, `this` refers to the object the method is called on

### Function Declarations
```javascript
// Function declaration (hoisted)
function greet(name) {
  return `Hello, ${name}!`;
}
console.log(greet("John")); // "Hello, John!"

// Function with default parameters
function multiply(a, b = 1) {
  return a * b;
}
console.log(multiply(5)); // 5
console.log(multiply(5, 3)); // 15

// Rest parameters (collects remaining arguments)
function sum(...numbers) {
  return numbers.reduce((a, b) => a + b, 0);
}
console.log(sum(1, 2, 3, 4)); // 10
```

### Function Expressions and Arrow Functions

**Function Types Comparison:**

| Type | Hoisted? | `this` Binding | Syntax | Best For |
|------|----------|----------------|--------|----------|
| Declaration | Yes | Dynamic | `function name() {}` | Named functions, recursion |
| Expression | No | Dynamic | `const f = function() {}` | Callbacks, passing as values |
| Arrow | No | Lexical | `const f = () => {}` | Callbacks, concise code |

```javascript
// Function expression (not hoisted)
const add = function(a, b) {
  return a + b;
};

// Arrow function (ES6)
const subtract = (a, b) => {
  return a - b;
};

// Arrow function - concise syntax (implicit return)
const multiply = (a, b) => a * b;

// Arrow function - single parameter
const square = x => x * x;

// Arrow function - no parameters
const getRandom = () => Math.random();

// Note: Arrow functions don't have their own 'this'
const person = {
  name: "John",
  greet: function() {
    console.log(`Hello, ${this.name}`); // this = person
  },
  greetArrow: () => {
    console.log(`Hello, ${this.name}`); // this = window/undefined
  }
};
```

### Closures

**Closure Theory:**
A **closure** is a function that has access to variables from its outer (enclosing) scope, even after that outer function returns. This happens because:

1. Functions are **first-class objects** (can be passed around)
2. Inner functions have access to outer scope
3. Each function maintains a reference to its **lexical environment**

Closures are fundamental to JavaScript and enable:
- **Data privacy**: Variables can't be accessed directly from outside
- **Factory functions**: Create multiple similar objects
- **Callbacks**: Async operations accessing outer variables
- **Decorators/Wrappers**: Enhance function behavior

```javascript
// Closure - function remembers variables from outer scope
function createCounter() {
  let count = 0;
  return function() {
    count++;
    return count;
  };
}

const counter = createCounter();
console.log(counter()); // 1
console.log(counter()); // 2
console.log(counter()); // 3
// count variable is private - cannot be accessed directly

// Practical example - multiple closures
function makeMultiplier(multiplier) {
  return function(number) {
    return number * multiplier;
  };
}

const double = makeMultiplier(2);
const triple = makeMultiplier(3);
console.log(double(5)); // 10
console.log(triple(5)); // 15
```

### Higher-Order Functions

**Higher-Order Functions Theory:**
A **higher-order function** is a function that:
- Takes another function as an argument, OR
- Returns a function as a result

Benefits:
- **Abstraction**: Abstract out differences between functions
- **Reusability**: Create flexible, composable functions
- **Functional Programming**: Core concept in functional programming patterns

```javascript
// Function that takes a function as parameter
function applyOperation(a, b, operation) {
  return operation(a, b);
}

const add = (x, y) => x + y;
const multiply = (x, y) => x * y;

console.log(applyOperation(5, 3, add)); // 8
console.log(applyOperation(5, 3, multiply)); // 15

// Function that returns a function
function createGreeter(greeting) {
  return function(name) {
    return `${greeting}, ${name}!`;
  };
}

const sayHello = createGreeter("Hello");
const sayHi = createGreeter("Hi");
console.log(sayHello("John")); // "Hello, John!"
console.log(sayHi("Jane")); // "Hi, Jane!"
```

### IIFE (Immediately Invoked Function Expression)

**IIFE Theory:**
An **IIFE** is a function that is executed immediately upon definition. Uses:

- **Avoid polluting global scope**: Create a private scope
- **Module pattern**: Create modules with private and public members
- **Avoid variable conflicts**: Isolate code from other scripts
- **Execute setup code**: Run initialization code once

```javascript
// IIFE - executes immediately
(function() {
  const private = "This is private";
  console.log(private); // executes immediately
})();

// Arrow function IIFE
(() => {
  console.log("I run immediately!");
})();

// IIFE with parameters
(function(name) {
  console.log(`Hello, ${name}`);
})("World");

// IIFE returning a value
const result = (function() {
  const x = 10;
  const y = 20;
  return x + y;
})();
console.log(result); // 30
```

---

## Objects

### Theory: Objects and Prototypes

**What are Objects?**
Objects are **collections of key-value pairs** (properties and methods). They form the basis of JavaScript's object-oriented programming.

**Object Characteristics:**
- **Mutable**: Properties can be added, modified, or deleted
- **Reference types**: Variables store references to objects, not the objects themselves
- **Extensible**: Can add new properties anytime
- **Dynamic typing**: Property values can be any type

**Prototypes and Inheritance:**
- Each object has an internal `[[Prototype]]` link to another object
- This creates a **prototype chain** for inheritance
- Properties are looked up the chain (own property → parent → parent's parent, etc.)
- `Object.create()`, classes, and constructor functions use prototypes

### Object Creation
```javascript
// Object literal
const person = {
  name: "John",
  age: 30,
  city: "New York",
  greet: function() {
    return `Hello, my name is ${this.name}`;
  }
};

// Accessing properties
console.log(person.name); // "John"
console.log(person["age"]); // 30

// Constructor function
function Person(name, age) {
  this.name = name;
  this.age = age;
}

const john = new Person("John", 30);

// Object.create()
const proto = {
  greet() {
    return `Hello, ${this.name}`;
  }
};
const person2 = Object.create(proto);
person2.name = "Jane";
```

### Object Methods
```javascript
const obj = { a: 1, b: 2, c: 3 };

// Object.keys() - get all keys
console.log(Object.keys(obj)); // ["a", "b", "c"]

// Object.values() - get all values
console.log(Object.values(obj)); // [1, 2, 3]

// Object.entries() - get key-value pairs
console.log(Object.entries(obj)); // [["a", 1], ["b", 2], ["c", 3]]

// Object.assign() - merge objects
const target = { a: 1 };
const source = { b: 2, c: 3 };
const result = Object.assign(target, source);
console.log(result); // { a: 1, b: 2, c: 3 }

// Object spread operator
const obj2 = { x: 1, y: 2 };
const obj3 = { ...obj2, z: 3 };
console.log(obj3); // { x: 1, y: 2, z: 3 }

// Object.freeze() - prevents modifications
const frozen = Object.freeze({ a: 1 });
frozen.a = 2; // ignored in non-strict mode

// Object.seal() - prevents adding/removing properties
const sealed = Object.seal({ a: 1 });
sealed.a = 2; // allowed
sealed.b = 3; // ignored in non-strict mode
```

### Destructuring

**Destructuring Theory:**
**Destructuring** is a convenient way to extract values from objects or arrays and assign them to variables. Benefits:

- **Cleaner syntax**: No need for multiple property accesses
- **Default values**: Can provide fallbacks for missing values
- **Renaming**: Can use different variable names
- **Nested extraction**: Can destructure nested structures
- **Function parameters**: Can destructure in function arguments

```javascript
// Object destructuring
const person = { name: "John", age: 30, city: "NYC" };
const { name, age } = person;
console.log(name, age); // "John" 30

// With renaming
const { name: personName, age: personAge } = person;

// With default values
const { name, country = "USA" } = person;

// Nested destructuring
const user = {
  id: 1,
  profile: { name: "John", email: "john@example.com" }
};
const { profile: { name, email } } = user;

// In function parameters
function printUser({ name, age }) {
  console.log(`${name} is ${age}`);
}
printUser({ name: "John", age: 30 });
```

---

## Arrays

### Theory: Arrays and Array Methods

**What are Arrays?**
Arrays are **ordered collections of values** with zero-based indexing. They are actually special objects with numeric keys and a `length` property.

**Array Characteristics:**
- **Indexed**: Access elements by numeric index (0, 1, 2, ...)
- **Dynamic length**: Length changes as elements are added/removed
- **Mixed types**: Can contain different data types in the same array
- **Mutable**: Can add, remove, or modify elements

**Array Methods Categories:**
1. **Mutating**: Change the original array (`push`, `pop`, `splice`, etc.)
2. **Non-mutating**: Return new array, leave original unchanged (`map`, `filter`, etc.)
3. **Searching**: Find elements (`find`, `indexOf`, `includes`, etc.)
4. **Reducing**: Combine elements into single value (`reduce`)

**Best Practice**: Prefer non-mutating methods to avoid side effects and bugs.

### Array Creation and Methods
```javascript
// Array creation
const arr1 = [1, 2, 3, 4, 5];
const arr2 = new Array(5); // array of 5 empty slots
const arr3 = Array.of(1, 2, 3); // [1, 2, 3]

// Basic properties
console.log(arr1.length); // 5
console.log(arr1[0]); // 1
console.log(arr1[arr1.length - 1]); // 5

// Mutating methods (change original array)
const arr = [1, 2, 3];
arr.push(4); // [1, 2, 3, 4]
arr.pop(); // removes 4, returns 4
arr.unshift(0); // [0, 1, 2, 3]
arr.shift(); // removes 0, returns 0
arr.splice(1, 2, "a", "b"); // removes 2 items at index 1, inserts "a", "b"
arr.sort(); // sorts in place
arr.reverse(); // reverses in place
```

### Array Iteration Methods

**Iterator Methods Theory:**
Functional programming methods that iterate over arrays:

- **`forEach`**: Execute function for each element (no return value)
- **`map`**: Transform elements, return new array
- **`filter`**: Keep elements that pass test, return new array
- **`find`**: Return first element that passes test
- **`some`**: Check if ANY element passes test
- **`every`**: Check if ALL elements pass test
- **`reduce`**: Accumulate elements into single value

```javascript
const arr = [1, 2, 3, 4, 5];

// forEach - iterate and execute callback
arr.forEach((value, index, array) => {
  console.log(value);
});

// map - transform each element
const doubled = arr.map(x => x * 2);
console.log(doubled); // [2, 4, 6, 8, 10]

// filter - keep elements that pass test
const evens = arr.filter(x => x % 2 === 0);
console.log(evens); // [2, 4]

// find - return first element that passes test
const found = arr.find(x => x > 3);
console.log(found); // 4

// findIndex - return index of first element that passes test
const index = arr.findIndex(x => x > 3);
console.log(index); // 3

// some - check if any element passes test
const hasEven = arr.some(x => x % 2 === 0);
console.log(hasEven); // true

// every - check if all elements pass test
const allPositive = arr.every(x => x > 0);
console.log(allPositive); // true

// reduce - accumulate into single value
const sum = arr.reduce((acc, val) => acc + val, 0);
console.log(sum); // 15

// reduce example - group by property
const transactions = [
  { type: "income", amount: 100 },
  { type: "expense", amount: 50 },
  { type: "income", amount: 200 }
];
const summary = transactions.reduce((acc, t) => {
  acc[t.type] = (acc[t.type] || 0) + t.amount;
  return acc;
}, {});
console.log(summary); // { income: 300, expense: 50 }
```

### Array Searching and Manipulation
```javascript
const arr = [1, 2, 3, 4, 5];

// indexOf - find index of element
console.log(arr.indexOf(3)); // 2
console.log(arr.indexOf(10)); // -1

// includes - check if array contains element
console.log(arr.includes(3)); // true
console.log(arr.includes(10)); // false

// slice - extract portion (non-mutating)
const sliced = arr.slice(1, 4);
console.log(sliced); // [2, 3, 4]

// concat - combine arrays
const arr2 = [6, 7];
const combined = arr.concat(arr2);
console.log(combined); // [1, 2, 3, 4, 5, 6, 7]

// spread operator
const spread = [...arr, ...arr2];
console.log(spread); // [1, 2, 3, 4, 5, 6, 7]

// join - convert to string
const str = arr.join("-");
console.log(str); // "1-2-3-4-5"

// flat - flatten nested arrays
const nested = [1, [2, 3], [4, [5, 6]]];
const flat = nested.flat(2); // depth of 2
console.log(flat); // [1, 2, 3, 4, 5, 6]
```

### Array Destructuring

**Array Destructuring Theory:**
Extract values from arrays into individual variables using a pattern. Similar to object destructuring but uses position instead of keys.

```javascript
// Basic destructuring
const [a, b, c] = [1, 2, 3];
console.log(a, b, c); // 1 2 3

// Skip elements
const [first, , third] = [1, 2, 3];
console.log(first, third); // 1 3

// Rest elements - collect remaining
const [head, ...tail] = [1, 2, 3, 4, 5];
console.log(head); // 1
console.log(tail); // [2, 3, 4, 5]

// Swap variables (elegant pattern)
let x = 1, y = 2;
[x, y] = [y, x];
console.log(x, y); // 2 1

// With default values
const [a = 10, b = 20] = [5];
console.log(a, b); // 5 20
```

---

## String Methods

### Theory: Strings and Immutability

**String Characteristics:**
- **Immutable**: Cannot be modified after creation. All string methods return new strings
- **Indexed**: Can access characters by index like arrays
- **Unicode**: Supports international characters
- **Primitive type**: Comparisons check values, not references

**String Objects vs Primitives:**
```javascript
// Primitive (most common)
const str1 = "Hello"; // string primitive

// Object (rarely used)
const str2 = new String("Hello"); // String object
console.log(typeof str1); // "string"
console.log(typeof str2); // "object"
console.log(str1 === str2); // false (different types)
```

### String Basics
```javascript
const str = "Hello World";

// Properties
console.log(str.length); // 11

// Accessing characters
console.log(str[0]); // "H"
console.log(str.charAt(0)); // "H"
console.log(str.charCodeAt(0)); // 72

// Case conversion
console.log(str.toUpperCase()); // "HELLO WORLD"
console.log(str.toLowerCase()); // "hello world"
```

### String Search and Replace

**String Search Methods:**
- `indexOf()` / `lastIndexOf()`: Returns position of substring (or -1)
- `includes()`: Returns boolean if substring exists
- `startsWith()` / `endsWith()`: Check start/end of string
- `search()`: Find position using regex

```javascript
const str = "The quick brown fox jumps over the lazy dog";

// indexOf/lastIndexOf
console.log(str.indexOf("fox")); // 16
console.log(str.lastIndexOf("the")); // 31

// includes/startsWith/endsWith
console.log(str.includes("quick")); // true
console.log(str.startsWith("The")); // true
console.log(str.endsWith("dog")); // true

// replace - replaces first match only
console.log(str.replace("the", "a")); // "The quick brown fox jumps over a lazy dog"

// replaceAll - replaces all matches
console.log(str.replaceAll("the", "a")); // "The quick brown fox jumps over a lazy dog"
```

### String Extraction and Splitting

**String Extraction Methods:**
- `slice(start, end)`: Extract portion, supports negative indices
- `substring(start, end)`: Extract portion, doesn't support negatives
- `substr(start, length)`: DEPRECATED - avoid using

```javascript
const str = "Hello World";

// slice(start, end)
console.log(str.slice(0, 5)); // "Hello"
console.log(str.slice(6)); // "World"
console.log(str.slice(-5)); // "World" (last 5 characters)

// substring(start, end) - similar to slice but doesn't accept negative indices
console.log(str.substring(0, 5)); // "Hello"

// substr(start, length) - deprecated, avoid
console.log(str.substr(0, 5)); // "Hello"

// split(separator, limit)
console.log(str.split(" ")); // ["Hello", "World"]
console.log(str.split("")); // ['H', 'e', 'l', 'l', 'o', ' ', 'W', 'o', 'r', 'l', 'd']
```

**split() Theory:**
- Converts string to array by dividing at separator
- Separator can be string or regex
- If separator omitted, returns array with entire string
- If separator is empty string, splits into characters

### String Trimming and Padding
```javascript
const str = "  Hello World  ";

// trim - remove whitespace
console.log(str.trim()); // "Hello World"
console.log(str.trimStart()); // "Hello World  "
console.log(str.trimEnd()); // "  Hello World"

// padStart/padEnd - pad to length
console.log("5".padStart(3, "0")); // "005"
console.log("5".padEnd(3, "0")); // "500"

// repeat - repeat string
console.log("ab".repeat(3)); // "ababab"
```

### Template Literals

**Template Literals Theory:**
Template literals (backtick-delimited strings) provide:
- **String interpolation**: Embed expressions with `${}`
- **Multi-line strings**: Don't need escape characters
- **Tagged templates**: Custom string processing

```javascript
const name = "John";
const age = 30;

// Template string with expressions
const greeting = `Hello, ${name}! You are ${age} years old.`;
console.log(greeting); // "Hello, John! You are 30 years old."

// Multi-line strings
const multiline = `
  Line 1
  Line 2
  Line 3
`;

// Expressions in template
const result = `5 + 3 = ${5 + 3}`;
console.log(result); // "5 + 3 = 8"

// Tagged template literals (advanced)
function tag(strings, ...values) {
  console.log(strings); // ["Hello ", "! You are ", " years old."]
  console.log(values); // ["John", 30]
  return strings[0] + values[0].toUpperCase() + strings[1] + values[1] + strings[2];
}

const greeting2 = tag`Hello ${name}! You are ${age} years old.`;
console.log(greeting2); // "Hello JOHN! You are 30 years old."
```

---

## Promises & Async/Await

### Theory: Asynchronous JavaScript

**Why Asynchronous Programming?**
JavaScript is **single-threaded**, meaning it can only execute one piece of code at a time. Asynchronous operations allow:
- **Non-blocking I/O**: Don't wait for slow operations (network, files, etc.)
- **Responsive UI**: Can handle user input while waiting for responses
- **Concurrent operations**: Can start multiple operations at once

**Execution Model:**
```
┌─────────────────────────────────────┐
│   JavaScript Event Loop             │
├─────────────────────────────────────┤
│ 1. Call Stack (synchronous code)    │
│ 2. Event Loop (manages async)       │
│ 3. Task Queue (callbacks to run)    │
│ 4. Microtask Queue (promises)       │
└─────────────────────────────────────┘
```

**Execution Order:**
1. Execute all synchronous code (call stack)
2. Execute all microtasks (promises, async/await)
3. Execute next task (callback from task queue)

### Promises

**Promise Theory:**
A **Promise** represents the eventual completion (or failure) of an asynchronous operation and its resulting value. Three states:

- **Pending**: Initial state, operation hasn't completed
- **Fulfilled**: Operation completed successfully, has a value
- **Rejected**: Operation failed, has a reason (error)

State transitions are **irreversible**: once settled (fulfilled/rejected), cannot change.

```javascript
// Creating a promise
const promise = new Promise((resolve, reject) => {
  // Async operation
  setTimeout(() => {
    resolve("Success!"); // or reject("Error!")
  }, 1000);
});

// Consuming a promise
promise
  .then(result => console.log(result)) // Success!
  .catch(error => console.error(error))
  .finally(() => console.log("Done")); // Always executes

// Promise chaining
fetch("https://api.example.com/data")
  .then(response => response.json())
  .then(data => {
    console.log(data);
    return data.userId;
  })
  .then(userId => fetch(`https://api.example.com/user/${userId}`))
  .then(response => response.json())
  .catch(error => console.error("Error:", error));

// Promise.all - wait for all promises (fails if any fails)
Promise.all([promise1, promise2, promise3])
  .then(results => console.log(results))
  .catch(error => console.error(error));

// Promise.race - wait for first promise to settle
Promise.race([promise1, promise2])
  .then(result => console.log("First to complete:", result));

// Promise.allSettled - wait for all, don't fail on rejection
Promise.allSettled([promise1, promise2])
  .then(results => {
    results.forEach(result => {
      if (result.status === "fulfilled") {
        console.log(result.value);
      } else {
        console.log(result.reason);
      }
    });
  });
```

### Async/Await

**Async/Await Theory:**
`async/await` is **syntactic sugar** built on Promises that:
- Makes asynchronous code look synchronous (easier to read)
- `async` function always returns a Promise
- `await` pauses execution until Promise settles
- Cleaner error handling with try/catch

```javascript
// Async function returns a promise
async function fetchData() {
  try {
    const response = await fetch("https://api.example.com/data");
    const data = await response.json();
    return data;
  } catch (error) {
    console.error("Error:", error);
  }
}

// Using async function
fetchData().then(data => console.log(data));

// Async/await with multiple operations
async function getUserAndPosts(userId) {
  try {
    const userResponse = await fetch(`https://api.example.com/user/${userId}`);
    const user = await userResponse.json();
    
    const postsResponse = await fetch(`https://api.example.com/posts/${userId}`);
    const posts = await postsResponse.json();
    
    return { user, posts };
  } catch (error) {
    console.error("Error:", error);
  }
}

// Parallel operations with async/await
async function getMultipleData() {
  try {
    const [data1, data2, data3] = await Promise.all([
      fetch("url1").then(r => r.json()),
      fetch("url2").then(r => r.json()),
      fetch("url3").then(r => r.json())
    ]);
    return { data1, data2, data3 };
  } catch (error) {
    console.error("Error:", error);
  }
}
```

**async vs Promises:**
```javascript
// Promise approach
function getUser() {
  return fetch("/api/user")
    .then(r => r.json())
    .then(user => user.name)
    .catch(error => console.error(error));
}

// async/await approach (cleaner)
async function getUser() {
  try {
    const response = await fetch("/api/user");
    const user = await response.json();
    return user.name;
  } catch (error) {
    console.error(error);
  }
}
```

---

## Classes & OOP

### Theory: Object-Oriented Programming

**OOP Principles:**

1. **Encapsulation**: Bundle data and methods, hide internal details
2. **Inheritance**: Create hierarchies, reuse code from parent classes
3. **Polymorphism**: Objects can take multiple forms, override parent behavior
4. **Abstraction**: Expose simple interface, hide complex implementation

**Classes in JavaScript:**
- **Syntactic sugar** over prototype-based inheritance
- Easier to read than constructor functions and prototypes
- Still use prototypes under the hood
- Support `constructor`, methods, getters/setters, static members

### Class Basics

**Class Concepts:**
- **Constructor**: Special method that runs when object is created
- **Instance methods**: Methods available on object instances
- **Static methods**: Methods on the class itself, not instances
- **Getters/Setters**: Property-like methods for controlled access

```javascript
// Class declaration
class Person {
  // Constructor
  constructor(name, age) {
    this.name = name;
    this.age = age;
  }

  // Instance method
  greet() {
    return `Hello, I'm ${this.name}`;
  }

  // Getter
  get info() {
    return `${this.name} is ${this.age} years old`;
  }

  // Setter
  set age(value) {
    if (value < 0) throw new Error("Age cannot be negative");
    this._age = value;
  }

  get age() {
    return this._age;
  }

  // Static method (called on class, not instance)
  static compare(person1, person2) {
    return person1.age - person2.age;
  }

  // Static property
  static species = "Homo sapiens";
}

const john = new Person("John", 30);
console.log(john.greet()); // "Hello, I'm John"
console.log(john.info); // "John is 30 years old"
console.log(Person.species); // "Homo sapiens"
```

### Inheritance

**Inheritance Theory:**
- Child class extends parent class with `extends` keyword
- Child inherits all methods and properties from parent
- Child can override parent methods (polymorphism)
- `super()` calls parent constructor/methods
- Creates is-a relationship (Dog is-a Animal)

```javascript
// Parent class
class Animal {
  constructor(name) {
    this.name = name;
  }

  speak() {
    console.log(`${this.name} makes a sound`);
  }
}

// Child class
class Dog extends Animal {
  constructor(name, breed) {
    super(name); // call parent constructor
    this.breed = breed;
  }

  // Override parent method
  speak() {
    console.log(`${this.name} barks`);
  }

  // New method
  getInfo() {
    return `${this.name} is a ${this.breed}`;
  }
}

const dog = new Dog("Rex", "Labrador");
dog.speak(); // "Rex barks"
console.log(dog.getInfo()); // "Rex is a Labrador"

// Check instance type
console.log(dog instanceof Dog); // true
console.log(dog instanceof Animal); // true (inherits)
```

### Encapsulation with Private Fields

**Encapsulation Theory:**
Hiding internal implementation details and exposing only what's necessary:
- **Public**: Accessible from anywhere
- **Private**: Only accessible within the class
- **Protected** (not native to JS): Accessible in class and subclasses

```javascript
class BankAccount {
  #balance = 0; // private field (# prefix)
  #pin = "1234"; // private field

  constructor(initialBalance) {
    this.#balance = initialBalance;
  }

  deposit(amount) {
    if (amount > 0) {
      this.#balance += amount;
    }
  }

  withdraw(amount) {
    if (amount > 0 && amount <= this.#balance) {
      this.#balance -= amount;
    }
  }

  // Public method to access private field
  getBalance() {
    return this.#balance;
  }

  // Private method
  #verifyPin(pin) {
    return pin === this.#pin;
  }
}

const account = new BankAccount(1000);
account.deposit(500);
console.log(account.getBalance()); // 1500
// account.#balance; // SyntaxError - cannot access private field
```

### Mixins

**Mixins Theory:**
Mixins are a pattern for sharing functionality between unrelated classes:
- Not true inheritance (no parent-child relationship)
- Combines behavior from multiple sources (composition)
- Useful for cross-cutting concerns (features many classes need)
- Alternative to multiple inheritance (which JS doesn't support)

```javascript
// Mixin objects
const canEat = {
  eat() {
    return `${this.name} is eating`;
  }
};

const canWalk = {
  walk() {
    return `${this.name} is walking`;
  }
};

const canSwim = {
  swim() {
    return `${this.name} is swimming`;
  }
};

// Create class with mixins
class Duck {}
Object.assign(Duck.prototype, canEat, canWalk, canSwim);

const duck = new Duck();
duck.name = "Donald";
console.log(duck.eat()); // "Donald is eating"
console.log(duck.walk()); // "Donald is walking"
console.log(duck.swim()); // "Donald is swimming"
```

---

## DOM Manipulation

### Theory: The DOM (Document Object Model)

**What is the DOM?**
The DOM is a **tree-like representation** of an HTML document:
- **Document**: Root node representing entire page
- **Elements**: Nodes representing HTML tags
- **Text**: Nodes containing text content
- **Attributes**: Properties of elements

**DOM Structure:**
```
Document
├── html
│   ├── head
│   │   └── title
│   └── body
│       ├── div#container
│       │   ├── h1
│       │   └── p
│       └── footer
```

**DOM Hierarchy:**
- **Node**: Base interface for all DOM objects
- **Element**: Node representing HTML tag
- **Document**: Root node
- **Text**: Text node containing text

### Selecting Elements

**Query Methods Comparison:**

| Method | Returns | Selector | Performance |
|--------|---------|----------|-------------|
| `getElementById()` | Single element | ID | Fastest |
| `querySelector()` | Single element | CSS selector | Medium |
| `querySelectorAll()` | NodeList | CSS selector | Medium |
| `getElementsByClassName()` | HTMLCollection | Class | Fast |
| `getElementsByTagName()` | HTMLCollection | Tag | Fast |

**NodeList vs HTMLCollection:**
- **NodeList**: Static (snapshot), supports `.forEach()`
- **HTMLCollection**: Live (updates as DOM changes), must convert to array

```javascript
// getElementById
const element = document.getElementById("myId");

// querySelector (CSS selector)
const element = document.querySelector(".myClass");
const element = document.querySelector("#myId");
const element = document.querySelector("div > p");

// querySelectorAll (returns NodeList)
const elements = document.querySelectorAll(".myClass");
elements.forEach(el => console.log(el));

// getElementByClassName (returns HTMLCollection)
const elements = document.getElementsByClassName("myClass");

// getElementsByTagName
const paragraphs = document.getElementsByTagName("p");
```

### Modifying Elements

**DOM Manipulation Methods:**
- **Content**: `textContent`, `innerHTML`
- **Attributes**: `setAttribute()`, `getAttribute()`, `removeAttribute()`
- **Classes**: `.classList` methods
- **Styles**: `element.style` property

```javascript
const element = document.getElementById("myElement");

// Change text content (text only, safe from XSS)
element.textContent = "New text";

// Change HTML content (parses HTML, XSS risk)
element.innerHTML = "<strong>Bold text</strong>";

// Change attributes
element.setAttribute("data-id", "123");
element.getAttribute("data-id"); // "123"
element.removeAttribute("data-id");

// Change classes
element.classList.add("active");
element.classList.remove("inactive");
element.classList.toggle("highlight");
element.classList.contains("active"); // true/false

// Change styles (camelCase for CSS properties)
element.style.color = "red";
element.style.backgroundColor = "blue";
element.style.fontSize = "16px";

// Get computed styles
const computedStyle = window.getComputedStyle(element);
console.log(computedStyle.color);
```

**textContent vs innerHTML:**
- `textContent`: Text only, faster, safe from injection
- `innerHTML`: Parses HTML, slower, can execute scripts

### Creating and Removing Elements

**Element Lifecycle:**
Creating → Adding to DOM → Modifying → Removing from DOM

```javascript
// Create element
const newDiv = document.createElement("div");
newDiv.textContent = "Hello";
newDiv.classList.add("container");

// Add to DOM
const parent = document.getElementById("parent");
parent.appendChild(newDiv); // add as last child

// Insert at specific position
const reference = document.getElementById("reference");
parent.insertBefore(newDiv, reference);

// Replace element
const oldElement = document.getElementById("old");
const newElement = document.createElement("div");
oldElement.parentNode.replaceChild(newElement, oldElement);

// Remove element
newDiv.remove(); // modern way (preferred)
// oldElement.parentNode.removeChild(oldElement); // older way

// Clone element
const clone = newDiv.cloneNode(true); // true = deep clone (with children)
parent.appendChild(clone);
```

### DOM Traversal

**Tree Navigation:**
Moving through the DOM tree relationships (parent, children, siblings).

```javascript
const element = document.getElementById("myElement");

// Parent
console.log(element.parentNode); // any type of parent node
console.log(element.parentElement); // element parent only

// Children
console.log(element.childNodes); // includes text nodes
console.log(element.children); // only element nodes (preferred)
console.log(element.firstChild); // first child (may be text node)
console.log(element.firstElementChild); // first element
console.log(element.lastChild);
console.log(element.lastElementChild);

// Siblings
console.log(element.nextSibling); // may be text node
console.log(element.nextElementSibling); // next element
console.log(element.previousSibling);
console.log(element.previousElementSibling);
```

---

## Events

### Theory: Event System

**Events** are actions or occurrences happening in the browser that JavaScript can respond to.

**Event Types:**
- **User events**: click, scroll, hover, typing
- **Document events**: load, DOMContentLoaded, beforeunload
- **Network events**: load, error, abort
- **Input events**: change, input, submit
- **Keyboard events**: keydown, keyup, keypress
- **Mouse events**: mouseover, mouseout, mousemove

**Event Flow (Event Propagation):**
Three phases of event propagation:

1. **Capturing phase**: Event moves down from Document to target
2. **Target phase**: Event reaches the target element
3. **Bubbling phase**: Event moves back up to Document

```
Document
    │ capturing phase
    ↓
Parent
    │ capturing phase
    ↓
Target ← target phase → Bubbling up
    ↑
Parent
    ↑ bubbling phase
Document
```

### Event Listeners

**addEventListener vs on-property:**
- `addEventListener`: Can attach multiple listeners, more flexible
- `element.onclick`: Only one listener per event (overwrites previous)

```javascript
const button = document.getElementById("myButton");

// addEventListener (recommended)
button.addEventListener("click", function(event) {
  console.log("Button clicked!");
  console.log(event.target); // the element that triggered the event
  console.log(event.type); // "click"
});

// Remove event listener
const handleClick = () => console.log("Clicked");
button.addEventListener("click", handleClick);
button.removeEventListener("click", handleClick);

// Event delegation - listen on parent, trigger on child
const list = document.getElementById("myList");
list.addEventListener("click", function(event) {
  if (event.target.tagName === "LI") {
    console.log("Item clicked:", event.target.textContent);
  }
});
```

**Event Delegation Benefits:**
- Listen to future elements (dynamically added)
- Use less memory (one listener vs many)
- Cleaner code

### Common Events
```javascript
// Mouse events
element.addEventListener("click", handler);
element.addEventListener("dblclick", handler);
element.addEventListener("mouseover", handler);
element.addEventListener("mouseout", handler);
element.addEventListener("mouseenter", handler); // doesn't bubble
element.addEventListener("mouseleave", handler); // doesn't bubble
element.addEventListener("mousemove", handler);
element.addEventListener("mousedown", handler);
element.addEventListener("mouseup", handler);

// Keyboard events
document.addEventListener("keydown", function(event) {
  console.log(event.key); // the key pressed ("a", "Enter", etc.)
  console.log(event.code); // "KeyA", "Enter", etc.
  console.log(event.ctrlKey, event.shiftKey, event.altKey);
});

document.addEventListener("keyup", handler);
document.addEventListener("keypress", handler); // deprecated

// Form events
const form = document.getElementById("myForm");
form.addEventListener("submit", function(event) {
  event.preventDefault(); // prevent form submission
  console.log("Form submitted");
});

input.addEventListener("change", handler); // when value changes and loses focus
input.addEventListener("input", handler); // fires while typing
input.addEventListener("focus", handler);
input.addEventListener("blur", handler);

// Window events
window.addEventListener("load", handler); // page fully loaded
window.addEventListener("DOMContentLoaded", handler); // DOM ready (faster)
window.addEventListener("scroll", handler);
window.addEventListener("resize", handler);
```

### Event Object

**Event Object Properties and Methods:**

```javascript
element.addEventListener("click", function(event) {
  // Event properties
  console.log(event.type); // "click"
  console.log(event.target); // element that triggered event
  console.log(event.currentTarget); // element with listener
  console.log(event.detail); // click count (for click events)
  console.log(event.clientX, event.clientY); // position relative to viewport
  console.log(event.pageX, event.pageY); // position relative to document
  console.log(event.screenX, event.screenY); // position relative to screen
  console.log(event.timeStamp); // milliseconds since page load

  // Event methods
  event.preventDefault(); // prevent default action (e.g., form submit)
  event.stopPropagation(); // stop bubbling
  event.stopImmediatePropagation(); // prevent other handlers for same event
});
```

**Common Event Properties:**
- `type`: Event name ("click", "submit", etc.)
- `target`: Element that triggered event
- `currentTarget`: Element the listener is attached to
- `trusted`: Boolean indicating if event is from user (vs JS)
- `cancelable`: Boolean if `preventDefault()` can be called

### Event Bubbling and Capturing

**Event Propagation Flow:**
When you click on an element, the event travels:

1. **Capturing**: Document → Body → Div → Span (going down)
2. **Bubbling**: Span → Div → Body → Document (going up)

By default, listeners are on **bubbling phase**. Use `true` as third parameter for capturing.

```javascript
// Event bubbling (default)
const parent = document.getElementById("parent");
const child = document.getElementById("child");

parent.addEventListener("click", () => console.log("Parent clicked"));
child.addEventListener("click", () => console.log("Child clicked"));

// Clicking child logs: "Child clicked", then "Parent clicked"

// Capturing phase (third parameter = true)
parent.addEventListener("click", 
  () => console.log("Parent capturing"), 
  true
);
child.addEventListener("click", 
  () => console.log("Child capturing"), 
  true
);

// Clicking child logs: "Parent capturing", then "Child capturing"

// Stop propagation
child.addEventListener("click", (event) => {
  event.stopPropagation();
  console.log("Child clicked");
});
// Parent listener won't be called now

// Stop immediate propagation (prevents all other listeners for same event)
child.addEventListener("click", (event) => {
  event.stopImmediatePropagation();
  console.log("First listener");
});
child.addEventListener("click", () => {
  console.log("Second listener"); // Won't be called
});
```

**Bubbling vs Capturing:**
- **Bubbling**: Most common, useful for event delegation
- **Capturing**: Less common, useful for intercepting events before they reach target

## Error Handling

### Theory: Error Management

**Error Handling Importance:**
- **Prevents crashes**: Gracefully handle unexpected situations
- **Better UX**: Informative error messages to users
- **Debugging**: Understand what went wrong
- **Resilience**: Application continues functioning

**Error Types:**
- **Syntax Errors**: Malformed code (prevented by parser)
- **Reference Errors**: Variable doesn't exist
- **Type Errors**: Operation incompatible with type
- **Range Errors**: Value out of valid range
- **Custom Errors**: Application-specific errors

### try/catch/finally

**Exception Handling Flow:**

```javascript
try {
  // code that might throw error
  const result = JSON.parse(invalidJson);
} catch (error) {
  // handle error
  console.log(error.message);
  console.log(error.name); // "SyntaxError"
  console.log(error.stack);
} finally {
  // always execute (cleanup code)
  console.log("Cleanup code");
}

// Nested try/catch
try {
  try {
    throw new Error("Inner error");
  } catch (error) {
    console.log("Inner:", error.message);
    throw error; // rethrow to outer catch
  }
} catch (error) {
  console.log("Outer:", error.message);
}
```

**Error Object Properties:**
- `message`: Human-readable error description
- `name`: Error type ("Error", "TypeError", etc.)
- `stack`: Call stack trace (helpful for debugging)

### Throwing Errors

**Throwing Errors Theory:**
Throw errors to communicate problems and interrupt execution flow. Use built-in types or create custom ones.

```javascript
// Throw built-in error types
throw new Error("Something went wrong");
throw new TypeError("Expected a number");
throw new ReferenceError("Variable not defined");
throw new SyntaxError("Invalid syntax");
throw new RangeError("Value out of range");

// Custom error class
class ValidationError extends Error {
  constructor(message) {
    super(message);
    this.name = "ValidationError";
  }
}

try {
  if (age < 0) {
    throw new ValidationError("Age cannot be negative");
  }
} catch (error) {
  if (error instanceof ValidationError) {
    console.log("Validation error:", error.message);
  } else {
    console.log("Other error:", error.message);
  }
}
```

### Error Prevention

**Defensive Programming:**
Prevent errors before they happen using validation and checks.

```javascript
// Check before accessing
if (typeof obj !== "undefined" && obj !== null) {
  console.log(obj.property);
}

// Optional chaining (prevents null/undefined errors)
console.log(obj?.property?.nested);

// Default values (provide fallback for missing data)
const value = userInput || "default";
const config = { ...defaultConfig, ...userConfig };

// Input validation
function divide(a, b) {
  if (typeof a !== "number" || typeof b !== "number") {
    throw new TypeError("Both arguments must be numbers");
  }
  if (b === 0) {
    throw new Error("Cannot divide by zero");
  }
  return a / b;
}

// Array safety
const arr = [1, 2, 3];
const safe = arr?.[10]; // undefined instead of error

// Checking existence
if ("property" in obj) {
  console.log(obj.property);
}

// Using hasOwnProperty
if (obj.hasOwnProperty("property")) {
  console.log(obj.property);
}
```

---

## ES6+ Features

### Theory: Modern JavaScript (ES6 and Beyond)

**ES6+ Evolution:**
- **ES5 (2009)**: Standard features most know
- **ES6/ES2015 (2015)**: Major update (arrow functions, classes, promises, modules)
- **Post-ES6 (2016+)**: Yearly updates with incremental features

**Key ES6+ Features:**
- Arrow functions
- Classes
- Template literals
- Destructuring
- Spread operator
- Promises & async/await
- Modules (import/export)
- Proxies
- Symbols

### Destructuring

**Destructuring Recap and Advanced Patterns:**

```javascript
// Array destructuring
const [a, b, ...rest] = [1, 2, 3, 4, 5];
console.log(a, b, rest); // 1 2 [3, 4, 5]

// Object destructuring
const { name, age, ...others } = { name: "John", age: 30, city: "NYC" };
console.log(name, age, others); // "John" 30 { city: "NYC" }

// Function parameters (very common pattern)
function sum([a, b]) {
  return a + b;
}
console.log(sum([1, 2])); // 3

function greet({ name, greeting = "Hello" }) {
  return `${greeting}, ${name}`;
}
console.log(greet({ name: "John" })); // "Hello, John"

// Nested destructuring
const data = {
  user: { name: "John", contact: { email: "john@example.com" } }
};
const { user: { name, contact: { email } } } = data;
```

### Spread Operator

**Spread Operator (`...`) Theory:**
Expands an iterable (array, string, etc.) into individual elements. Useful for:
- Cloning arrays/objects (shallow copy)
- Merging arrays/objects
- Passing array elements as function arguments
- Converting array-like objects to arrays

```javascript
// Array spread
const arr1 = [1, 2, 3];
const arr2 = [4, 5, 6];
const combined = [...arr1, ...arr2]; // [1, 2, 3, 4, 5, 6]

// Insert in middle
const start = [1, 2];
const end = [5, 6];
const full = [0, ...start, 3, 4, ...end]; // [0, 1, 2, 3, 4, 5, 6]

// Object spread (shallow copy)
const obj1 = { a: 1, b: 2 };
const obj2 = { c: 3, d: 4 };
const merged = { ...obj1, ...obj2 }; // { a: 1, b: 2, c: 3, d: 4 }

// Override properties
const defaults = { a: 1, b: 2, c: 3 };
const custom = { ...defaults, b: 99 }; // { a: 1, b: 99, c: 3 }

// Function arguments
function sum(a, b, c) {
  return a + b + c;
}
const nums = [1, 2, 3];
console.log(sum(...nums)); // 6
```

### Rest Parameters

**Rest Parameters (`...`) Theory:**
Collects remaining arguments into an array. Used in function definitions (unlike spread in function calls).

```javascript
// Collect remaining parameters
function sum(...numbers) {
  return numbers.reduce((a, b) => a + b, 0);
}
console.log(sum(1, 2, 3, 4)); // 10

// Mix regular and rest parameters
function greet(greeting, ...names) {
  names.forEach(name => console.log(`${greeting}, ${name}`));
}
greet("Hello", "John", "Jane", "Bob");

// Can't have parameters after rest
// function bad(...rest, one) {} // SyntaxError

// Object rest in destructuring
const { a, b, ...rest } = { a: 1, b: 2, c: 3, d: 4 };
console.log(rest); // { c: 3, d: 4 }
```

### Template Literals
```javascript
// String interpolation
const name = "John";
console.log(`Hello, ${name}!`);

// Multi-line strings
const html = `
  <div>
    <h1>Welcome</h1>
    <p>This is a paragraph</p>
  </div>
`;

// Expressions
const x = 5, y = 3;
console.log(`${x} + ${y} = ${x + y}`);

// Tagged templates
function highlight(strings, ...values) {
  return strings.reduce((result, str, i) => {
    return result + str + (values[i] ? `<strong>${values[i]}</strong>` : "");
  }, "");
}

const msg = highlight`Hello ${name}, you are ${age} years old`;
```

### for...of Loop

**for...of Theory:**
Iterates over **iterable values** (not keys). Works with:
- Arrays (values)
- Strings (characters)
- Sets, Maps
- Array-like objects

```javascript
// Iterate over array values
const arr = [1, 2, 3];
for (const value of arr) {
  console.log(value); // 1, 2, 3
}

// Iterate over string characters
const str = "hello";
for (const char of str) {
  console.log(char); // h, e, l, l, o
}

// Iterate over Map entries
const map = new Map([["a", 1], ["b", 2]]);
for (const [key, value] of map) {
  console.log(key, value); // a 1, b 2
}

// Get index with entries()
for (const [index, value] of arr.entries()) {
  console.log(index, value); // 0 1, 1 2, 2 3
}
```

**for vs for...of vs for...in:**

| Loop | Iterates | Values? | Best for |
|------|----------|---------|----------|
| `for` | Any sequence | Yes | Known count, indices |
| `for...of` | Iterables | Yes | Arrays, strings |
| `for...in` | Enumerable keys | No | Objects, legacy |

### Default Parameters

**Default Parameters Theory:**
Provide default values when arguments are not passed or are `undefined`.

```javascript
// Function default parameters
function greet(name = "Guest", greeting = "Hello") {
  return `${greeting}, ${name}`;
}

console.log(greet()); // "Hello, Guest"
console.log(greet("John")); // "Hello, John"
console.log(greet("John", "Hi")); // "Hi, John"

// Default with expressions (evaluated each call)
function getId(prefix = "ID-" + Date.now()) {
  return prefix;
}

// Default referencing other parameters
function createUser(name, role = name.toUpperCase() + "_ADMIN") {
  return { name, role };
}
console.log(createUser("john")); // { name: "john", role: "JOHN_ADMIN" }

// Note: null is not treated as undefined
function test(x = "default") {
  console.log(x);
}
test(undefined); // "default"
test(null); // null (not default!)
```

### Enhanced Object Literals

**Enhanced Object Literal Theory:**
ES6 syntax improvements for creating objects more concisely.

```javascript
const name = "John";
const age = 30;

// Shorthand properties (omit value if same as variable name)
const person = {
  name,
  age
};
// Equivalent to: { name: "John", age: 30 }

// Shorthand methods (omit 'function' keyword)
const obj = {
  name: "Test",
  greet() {
    return `Hello, ${this.name}`;
  }
};
// Old way: greet: function() { ... }

// Computed property names (dynamic keys)
const key = "score";
const player = {
  [key]: 100,
  [`${key}_bonus`]: 50
};
console.log(player); // { score: 100, score_bonus: 50 }

// Combining all features
function createUser(firstName, lastName, email) {
  const fullName = `${firstName} ${lastName}`;
  return {
    fullName,
    email,
    [email.split("@")[1]]: true, // domain as dynamic key
    getInfo() {
      return `${this.fullName} <${this.email}>`;
    }
  };
}
```

---

## Common Patterns

### Theory: Design Patterns

**Design Patterns** are reusable solutions to common programming problems. Benefits:
- **Code reusability**: Proven solutions
- **Maintainability**: Familiar patterns for other developers
- **Communication**: Common vocabulary
- **Best practices**: Encapsulate experience

**Common JavaScript Patterns:**
1. **Module Pattern**: Encapsulate code and expose public API
2. **Singleton**: Single instance shared globally
3. **Observer**: Publish-subscribe for decoupled communication
4. **Factory**: Create objects without specifying exact classes
5. **Decorator**: Add behavior to objects dynamically

### Module Pattern

**Module Pattern Theory:**
Encapsulate private variables and methods, expose only public interface using closures.

```javascript
// IIFE module pattern
const calculator = (function() {
  let result = 0; // private

  return {
    // public methods
    add: function(x) {
      result += x;
      return this;
    },
    subtract: function(x) {
      result -= x;
      return this;
    },
    getResult: function() {
      return result;
    }
  };
})();

calculator.add(5).subtract(2);
console.log(calculator.getResult()); // 3
// calculator.result; // undefined (private)
```

**Modern Alternative (ES6 Modules):**
```javascript
// calculator.js
let result = 0;

export function add(x) {
  result += x;
  return result;
}

export function getResult() {
  return result;
}

// main.js
import { add, getResult } from './calculator.js';
add(5);
console.log(getResult()); // 5
```

### Singleton Pattern

**Singleton Pattern Theory:**
Ensures only one instance of a class exists and provides global access point. Uses:
- **Logging**: Single logger instance
- **Config**: Single configuration object
- **Database**: Single connection pool
- **Cache**: Single cache instance

```javascript
const Singleton = (function() {
  let instance;

  function createInstance() {
    return {
      name: "Singleton",
      method: function() {
        console.log("Method called");
      }
    };
  }

  return {
    getInstance: function() {
      if (!instance) {
        instance = createInstance();
      }
      return instance;
    }
  };
})();

const instance1 = Singleton.getInstance();
const instance2 = Singleton.getInstance();
console.log(instance1 === instance2); // true (same instance)

// Modern ES6 approach
class Logger {
  static instance = null;

  static getInstance() {
    if (!Logger.instance) {
      Logger.instance = new Logger();
    }
    return Logger.instance;
  }
}
```

### Observer Pattern

**Observer Pattern Theory:**
Objects (observers) subscribe to events from a subject. When subject changes, all observers are notified automatically. Also called **Pub-Sub** pattern. Uses:
- **Event systems**: Click handlers, form submissions
- **State changes**: Redux store, React state
- **Notifications**: Alert system, logging

```javascript
class EventEmitter {
  constructor() {
    this.events = {};
  }

  on(event, callback) {
    if (!this.events[event]) {
      this.events[event] = [];
    }
    this.events[event].push(callback);
  }

  emit(event, data) {
    if (this.events[event]) {
      this.events[event].forEach(callback => callback(data));
    }
  }

  off(event, callbackToRemove) {
    if (this.events[event]) {
      this.events[event] = this.events[event].filter(
        callback => callback !== callbackToRemove
      );
    }
  }
}

// Usage
const emitter = new EventEmitter();
emitter.on("message", (data) => console.log("Received:", data));
emitter.on("message", (data) => console.log("Also received:", data));
emitter.emit("message", "Hello!"); 
// Prints both listeners' output
```

### Factory Pattern

**Factory Pattern Theory:**
Creates objects using a factory function/method instead of calling `new` directly. Benefits:
- **Encapsulation**: Hide object creation logic
- **Flexibility**: Change how objects are created without changing client code
- **Validation**: Validate inputs before creating objects
- **Common interface**: All created objects follow same interface

```javascript
class VehicleFactory {
  static createVehicle(type) {
    switch (type) {
      case "car":
        return new Car();
      case "bike":
        return new Bike();
      case "truck":
        return new Truck();
      default:
        throw new Error("Unknown vehicle type");
    }
  }
}

class Car {
  drive() {
    return "Driving a car";
  }
}

class Bike {
  drive() {
    return "Riding a bike";
  }
}

class Truck {
  drive() {
    return "Driving a truck";
  }
}

const car = VehicleFactory.createVehicle("car");
console.log(car.drive()); // "Driving a car"

// Abstraction: Don't know or care about specific classes
const vehicles = ["car", "bike", "truck"].map(type => 
  VehicleFactory.createVehicle(type)
);
vehicles.forEach(v => console.log(v.drive()));
```

### Debounce and Throttle

**Debounce vs Throttle Theory:**

**Debounce**: Wait until activity stops, then execute. Delays repeated calls.
- **Use case**: Search input, auto-save, resize events
- **Example**: Stop typing for 300ms, then search

**Throttle**: Execute periodically. Limits execution frequency.
- **Use case**: Scroll events, mouse move, API calls
- **Example**: Max one search per second

```javascript
// Debounce - delays function execution until after a timeout
function debounce(func, delay) {
  let timeoutId;
  return function(...args) {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => func(...args), delay);
  };
}

// Example usage
const searchInput = document.getElementById("search");
const handleSearch = debounce((query) => {
  console.log("Searching for:", query);
  // API call
}, 300);

searchInput.addEventListener("input", (e) => {
  handleSearch(e.target.value);
});

// Throttle - limits function execution to once per interval
function throttle(func, interval) {
  let lastExecutionTime = 0;
  return function(...args) {
    const now = Date.now();
    if (now - lastExecutionTime >= interval) {
      func(...args);
      lastExecutionTime = now;
    }
  };
}

// Example usage
const handleScroll = throttle(() => {
  console.log("Scrolled");
  // Check if user reached bottom
}, 1000);

window.addEventListener("scroll", handleScroll);
```

**Comparison:**
- Debounce: 0, 0, 0, [wait], execute
- Throttle: execute, [wait], execute, [wait], execute

### Memoization

**Memoization Theory:**
Cache function results based on arguments. Optimization technique for expensive computations. Benefits:
- **Performance**: Avoid redundant calculations
- **Trade-off**: Memory for speed
- **Best for**: Pure functions (same input always produces same output)

```javascript
// Cache function results
function memoize(func) {
  const cache = {};
  return function(...args) {
    const key = JSON.stringify(args);
    if (key in cache) {
      console.log("From cache");
      return cache[key];
    }
    const result = func(...args);
    cache[key] = result;
    return result;
  };
}

// Example usage
function fibonacci(n) {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

const memoizedFib = memoize(fibonacci);
console.time("first");
console.log(memoizedFib(10)); // 55 (computed)
console.timeEnd("first");

console.time("second");
console.log(memoizedFib(10)); // 55 (from cache, very fast)
console.timeEnd("second");

// Works with multiple arguments
const memoizedAdd = memoize((a, b) => {
  console.log("Computing...");
  return a + b;
});

memoizedAdd(5, 3); // Computing... 8
memoizedAdd(5, 3); // From cache 8
```

### Composition

**Composition Theory:**
Combine functions to create new functions. Creates **data transformation pipelines**.

- **Composition**: Right-to-left execution (mathematical notation)
- **Pipe**: Left-to-right execution (more readable)

Benefits:
- **Reusability**: Combine simple functions into complex ones
- **Testability**: Each function independently testable
- **Readability**: Clear transformation flow

```javascript
// Function composition
function compose(...functions) {
  return function(value) {
    return functions.reduceRight((acc, func) => func(acc), value);
  };
}

const add5 = x => x + 5;
const multiply2 = x => x * 2;
const square = x => x * x;

// Compose: ((3 + 5) * 2) ^ 2 = 256
const composed = compose(square, multiply2, add5);
console.log(composed(3)); // 256

// Pipe (reverse composition, left-to-right)
function pipe(...functions) {
  return function(value) {
    return functions.reduce((acc, func) => func(acc), value);
  };
}

const piped = pipe(add5, multiply2, square);
console.log(piped(3)); // 256

// Real-world example
function getUserData(userId) {
  return {
    id: userId,
    name: "John",
    email: "john@example.com"
  };
}

const toUpperCase = str => str.toUpperCase();
const getNameOrEmail = obj => obj.email;
const getUser = pipe(getUserData, getNameOrEmail, toUpperCase);

console.log(getUser(1)); // "JOHN@EXAMPLE.COM"
```

---

## Additional Resources

### Useful JavaScript Methods Reference

**Math Object:**
```javascript
Math.PI; // 3.14159...
Math.abs(-5); // 5
Math.round(4.5); // 4 or 5
Math.floor(4.9); // 4
Math.ceil(4.1); // 5
Math.max(1, 5, 3); // 5
Math.min(1, 5, 3); // 1
Math.random(); // 0 to 1
Math.pow(2, 3); // 8
Math.sqrt(16); // 4
```

**Date Object:**
```javascript
const now = new Date();
now.getFullYear(); // 2025
now.getMonth(); // 0-11
now.getDate(); // day of month
now.getDay(); // day of week 0-6
now.getHours();
now.getMinutes();
now.getSeconds();
now.getTime(); // milliseconds since epoch

// Create date
new Date("2025-01-15");
new Date(2025, 0, 15);

// Format
now.toLocaleDateString(); // based on locale
now.toLocaleTimeString();
```

**JSON:**
```javascript
// Convert to JSON
JSON.stringify({ name: "John", age: 30 });
// '{"name":"John","age":30}'

// Parse JSON
JSON.parse('{"name":"John","age":30}');
// { name: "John", age: 30 }

// With replacer/reviver
JSON.stringify(obj, null, 2); // pretty print
JSON.parse(json, (key, value) => {
  // transform values during parsing
});
```

---

## Tips & Best Practices

### Code Quality Principles

Writing quality JavaScript requires understanding not just syntax, but also best practices:

1. **Use `const` by default**, `let` when reassignment needed, avoid `var`
   - `const` prevents accidental reassignment
   - Makes intent clear (this won't change)
   - Enables more optimizations

2. **Use strict equality** (`===`) instead of loose equality (`==`)
   - Type coercion can hide bugs
   - Strict comparison is predictable
   - Slightly faster performance

3. **Avoid mutating arrays** - use `.map()`, `.filter()`, `.reduce()` instead
   - Immutability prevents side effects
   - Easier to debug and test
   - Better for React and functional programming

4. **Use arrow functions** for callbacks and simple functions
   - Concise syntax
   - Lexical `this` binding
   - Required for functional patterns

5. **Use template literals** for string concatenation
   - More readable than `+` operator
   - Support multi-line strings
   - Allow expression interpolation

6. **Use async/await** instead of `.then()` chains when possible
   - Looks like synchronous code
   - Easier to read and debug
   - Better error handling with try/catch

7. **Handle errors properly** with try/catch or `.catch()`
   - Prevent unhandled rejections
   - Provide meaningful error messages
   - Fail gracefully

8. **Use descriptive variable and function names**
   - `userData` is better than `u`
   - `calculateTotal` is better than `calc`
   - Reduces need for comments

9. **Keep functions small and focused** (single responsibility)
   - Easier to test
   - Easier to reuse
   - Easier to understand

10. **Comment complex logic** but keep comments updated
    - Good code is self-documenting
    - Comments should explain WHY, not WHAT
    - Outdated comments are worse than no comments

11. **Use destructuring** to extract values from objects/arrays
    - Reduces repetitive property access
    - Makes dependencies clear
    - Works in function parameters

12. **Leverage spread operator** for immutable operations
    - Create copies without mutating
    - Merge objects/arrays cleanly
    - Avoid shallow copy gotchas

13. **Prefer `Object.assign()` or spread** over mutating objects
    - Immutability prevents bugs
    - Easier to track state changes
    - Works better with frameworks

14. **Use `map()`, `filter()`, `reduce()`** for array operations
    - More functional and declarative
    - Chainable for complex operations
    - Clear intent of transformation

15. **Cache DOM queries** in variables to avoid repeated lookups
    - DOM queries are expensive
    - Prevents redundant work
    - Improves performance

---

