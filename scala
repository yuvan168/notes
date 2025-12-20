# Scala Complete Guide - Theory, Concepts & Practical Examples

## Table of Contents
1. [Introduction & Language Philosophy](#introduction--language-philosophy)
2. [Scala Type System Theory](#scala-type-system-theory)
3. [Basic Types & Variables](#basic-types--variables)
4. [Functions & Methods](#functions--methods)
5. [Collections & Data Structures](#collections--data-structures)
6. [Object-Oriented Programming](#object-oriented-programming)
7. [Functional Programming](#functional-programming)
8. [Pattern Matching & Case Classes](#pattern-matching--case-classes)
9. [Traits & Mixins](#traits--mixins)
10. [Advanced Concepts](#advanced-concepts)
11. [Practical Examples](#practical-examples)
12. [Important Q&A](#important-qa)

---

## Introduction & Language Philosophy

### What is Scala?

**Scala** = **Sca**lable **La**nguage

```
Definition:
├─ Multi-paradigm programming language
├─ Combines object-oriented and functional programming
├─ Runs on Java Virtual Machine (JVM)
├─ Designed for scalability and expressiveness
└─ Created by Martin Odersky (2003)
```

### Why Scala?

```
Problems it solves:

1. Java Verbosity
   ❌ Java: public class Person { private String name; }
   ✓ Scala: class Person(name: String)

2. Null References (Billion Dollar Mistake)
   ❌ Java: Person p = null; String n = p.name; // NullPointerException
   ✓ Scala: val p: Option[Person] = None; // Type-safe

3. Functional Programming
   ❌ Java: Very verbose, not designed for FP
   ✓ Scala: First-class functions, immutability, composition

4. Type Inference
   ❌ Java: String x = "hello"; // Explicit type needed
   ✓ Scala: val x = "hello" // Type inferred

5. Concurrency
   ❌ Java: Thread-based (complex, error-prone)
   ✓ Scala: Actor model, async/await patterns
```

### Language Characteristics

```
Scala Features:

1. Statically Typed
   └─ Type checking at compile-time
   └─ Errors caught early

2. Type Inference
   └─ Types inferred from context
   └─ Reduce boilerplate

3. JVM-Based
   └─ Interoperable with Java
   └─ High performance
   └─ Mature ecosystem

4. Object-Functional
   └─ Classes and objects (OOP)
   └─ Functions as first-class values (FP)
   └─ Both paradigms seamlessly integrated

5. Expressive
   └─ Concise syntax
   └─ Domain-specific languages (DSLs)
   └─ Powerful abstractions
```

---

## Scala Type System Theory

### Type System Foundations

**What is a Type System?**

A type system defines:
- What values are valid for a data
- What operations are allowed on that data
- Compile-time verification

```
Benefits:

1. Safety
   └─ Catch errors at compile-time
   └─ String + Int = Type Error ✓

2. Performance
   └─ Compiler can optimize
   └─ No runtime type checks needed

3. Documentation
   └─ Types describe intent
   └─ Self-documenting code

4. Refactoring
   └─ Compiler catches breaking changes
   └─ Confidence when modifying code
```

### Scala's Type Hierarchy

```
Scala Type Hierarchy:

Any (Top)
├─ AnyVal (Value types)
│  ├─ Byte (8-bit)
│  ├─ Short (16-bit)
│  ├─ Int (32-bit)
│  ├─ Long (64-bit)
│  ├─ Float (32-bit IEEE 754)
│  ├─ Double (64-bit IEEE 754)
│  ├─ Char (Unicode character)
│  ├─ Boolean (true/false)
│  └─ Unit (void equivalent, ())
│
├─ AnyRef (Reference types)
│  ├─ String
│  ├─ Collections (List, Set, Map)
│  ├─ Custom classes
│  └─ All Java classes
│
└─ Bottom (Never reached in normal code)
   └─ Nothing (no instances)
   └─ Null (null reference)
```

### Type Inference

**How does Scala infer types?**

```
Algorithm:

1. Look at assignments
   val x = 5  // → x: Int (inferred from literal)

2. Look at operations
   val y = 5 + 3  // → y: Int (5+3 produces Int)

3. Look at function returns
   def add(a: Int, b: Int) = a + b  // → returns Int

4. Look at collections
   val list = List(1, 2, 3)  // → list: List[Int]

5. Constraint propagation
   val z: Double = 5  // → z: Double (explicit type overrides Int)
```

**When to use explicit types:**

```
✓ Function signatures
  def greet(name: String): String

✓ Complex return types
  def process(): Either[Error, Result]

✓ Public APIs
  class Calculator {
    def calculate(x: Int, y: Int): Int
  }

✗ Local variables
  val x = 10  // Type inference fine

✗ Simple expressions
  val greeting = "Hello"
```

### Variance

**What is Variance?**

Variance describes how type parameterization behaves with inheritance:

```
Scenario: Animal > Dog > Puppy

1. Covariance (Producer)
   ├─ List[Dog] is List[Animal]?
   ├─ Makes sense: List only produces Dogged objects
   ├─ Marked with +T
   └─ Example: List[+T]

2. Contravariance (Consumer)
   ├─ Function[Animal => Unit] is Function[Dog => Unit]?
   ├─ Makes sense: Function accepts Dog (Animal is OK too)
   ├─ Marked with -T
   └─ Example: Function[-T, +R]

3. Invariance (Both)
   ├─ Array[Dog] is NOT Array[Animal]
   ├─ Array both produces and consumes
   ├─ Marked with T (no annotation)
   └─ Example: Array[T]

Code Example:

sealed trait Animal
case class Dog(name: String) extends Animal
case class Cat(name: String) extends Animal

// Covariant - List[Dog] is also List[Animal]
val dogs: List[Dog] = List(Dog("Rex"))
val animals: List[Animal] = dogs  // ✓ OK

// Contravariant - Function[Animal] is Function[Dog]
def feedAny(f: Function[Animal, Unit]): Unit = {
  f(Dog("Fido"))
}
val feedDog: Function[Dog, Unit] = (d: Dog) => println(d.name)
feedAny(feedDog)  // ✓ OK
```

### Type Bounds

**Constraining Type Parameters**

```
Upper Bound: Type <= Constraint
├─ T <: Comparable
├─ T can be Comparable or subtype
└─ Example: def sort[T <: Ordered[T]](items: List[T])

Lower Bound: Type >= Constraint
├─ T >: Animal
├─ T can be Animal or supertype
└─ Example: def add[T >: Int](item: T)

Context Bound: Type has implicit evidence
├─ T: Numeric
├─ Numeric[T] implicitly available
└─ Example: def sum[T: Numeric](items: List[T])
```

---

## Basic Types & Variables

### Immutability & Mutability

**Immutability = Core Principle**

```
Immutable (val):
├─ Cannot be reassigned
├─ Creates stable values
├─ Easier to reason about
├─ Thread-safe
└─ val x = 10

Mutable (var):
├─ Can be reassigned
├─ State can change
├─ Harder to track mutations
├─ Requires synchronization
└─ var y = 20
```

**Philosophy:**

```
Scala Design Principle:

Default: Use val (immutable)
    └─ 80-90% of code should be val

When needed: Use var (mutable)
    └─ 10-20% of code
    └─ Local loop counters
    └─ Stateful objects

Benefits:
✓ Predictable code (no hidden changes)
✓ Easier testing (no state to track)
✓ Parallelizable (no synchronization needed)
✓ Better performance (compiler optimizations)
```

**Examples:**

```scala
// ✓ Good - Immutable
val user = User("Alice", 30)
val name = user.name
val adults = users.filter(_.age >= 18)

// ❌ Bad - Unnecessary mutation
var total = 0
for (i <- 1 to 100) {
  total = total + i  // Mutation not needed
}

// ✓ Good - Functional approach
val total = (1 to 100).sum
```

### Value Types

**Numeric Types:**

```scala
// Integers
val byte: Byte = 127              // -128 to 127
val short: Short = 32767          // -32768 to 32767
val int: Int = 2147483647         // -2^31 to 2^31-1 (default)
val long: Long = 9223372036854775807L  // -2^63 to 2^63-1

// Floating Point
val float: Float = 3.14f          // 32-bit IEEE 754
val double: Double = 3.14159      // 64-bit (default)

// Other
val char: Char = 'A'              // Single Unicode character
val boolean: Boolean = true        // true or false
val unit: Unit = ()                // Void-like (side effects)
```

**Type Conversion:**

```scala
val i: Int = 10
val l: Long = i.toLong            // Explicit conversion
val s: String = i.toString

val str = "42"
val num = str.toInt               // "42" → 42
val num2 = str.toDouble           // "42" → 42.0

// Boxing/Unboxing (automatic)
val x: Any = 10                   // Int boxed as Integer
```

### String & String Interpolation

```scala
// Regular strings
val name = "Alice"
val greeting = "Hello, " + name   // Concatenation

// String interpolation (s-string)
val age = 30
val message = s"$name is $age years old"
// → "Alice is 30 years old"

// String interpolation with expressions
val total = s"Total: ${10 + 20}"
// → "Total: 30"

// Raw strings (no escape sequences)
val path = raw"C:\Users\alice\file.txt"
// → "C:\Users\alice\file.txt" (backslashes literal)

// Format strings
val formatted = f"$name%s is $age%d years old"
```

### Option Type (Safe Null Handling)

**What is Option?**

Option is a container for optional values:

```scala
// Some(value) or None instead of null

// Option creation
val maybeAge: Option[Int] = Some(30)
val noValue: Option[Int] = None
val autoNone: Option[String] = Option(null)  // → None

// Extracting value safely
def getAge(person: Person): Option[Int] = {
  if (person != null && person.age > 0) {
    Some(person.age)
  } else {
    None
  }
}

// Pattern matching
getAge(person) match {
  case Some(age) => println(s"Age: $age")
  case None => println("Age unknown")
}

// Functional operations
val maybeAge = Some(30)
maybeAge.map(_ + 1)          // → Some(31)
maybeAge.filter(_ > 25)      // → Some(30)
maybeAge.getOrElse(0)        // → 30 (or default)
maybeAge.flatMap(a => if (a > 18) Some(true) else None)  // → Some(true)
```

---

## Functions & Methods

### Function Definition & Theory

**Functions as First-Class Values**

```scala
// Function type: (InputType) => OutputType

// Named function (method)
def add(x: Int, y: Int): Int = {
  x + y
}

// Anonymous function (lambda)
val addAnon = (x: Int, y: Int) => x + y

// Single-line function (implicit return)
def multiply(x: Int, y: Int) = x * y

// Higher-order function (takes/returns functions)
def applyTwice(f: Int => Int, x: Int): Int = {
  f(f(x))
}

// Usage
applyTwice(x => x * 2, 5)  // → 20 (5 * 2 * 2)
```

### Function Types

```
Scala Function Types:

() => Int
├─ No parameters, returns Int

Int => String
├─ Takes Int, returns String

(Int, String) => Boolean
├─ Takes Int and String, returns Boolean

(Int, Int) => Int
├─ Takes two Ints, returns Int

Int => (Int => String)
├─ Takes Int, returns function (Int => String)
├─ Currying: partially applied functions
```

**Currying:**

```scala
// Uncurried function
def add(x: Int, y: Int): Int = x + y
add(3, 4)  // → 7

// Curried function (returns function)
def addCurried(x: Int): Int => Int = {
  (y: Int) => x + y
}
val addThree = addCurried(3)
addThree(4)  // → 7

// Syntactic sugar
def addCurried2(x: Int)(y: Int): Int = x + y
addCurried2(3)(4)  // → 7

// Benefits
// 1. Partial application
val add10 = addCurried(10)
add10(5)  // → 15
add10(20)  // → 30

// 2. Function composition
val increment = addCurried(1)
val numbers = List(1, 2, 3).map(increment)  // → List(2, 3, 4)
```

### Default Parameters & Named Arguments

```scala
// Default parameters
def greet(name: String = "Friend", greeting: String = "Hello"): String = {
  s"$greeting, $name!"
}

greet()                              // → "Hello, Friend!"
greet("Alice")                       // → "Hello, Alice!"
greet("Bob", "Hi")                   // → "Hi, Bob!"

// Named arguments (order doesn't matter)
greet(greeting = "Hi", name = "Alice")  // → "Hi, Alice!"
greet(name = "Bob")                     // → "Hello, Bob!"

// Varargs (variable number of arguments)
def sum(numbers: Int*): Int = {
  numbers.foldLeft(0)(_ + _)
}

sum(1, 2, 3, 4, 5)  // → 15
sum()  // → 0
```

### Implicit Parameters

**What are Implicits?**

Implicits allow the compiler to automatically provide arguments:

```scala
// Implicit scope (compiler looks for matching types)

case class Config(timeout: Int, retries: Int)

implicit val defaultConfig = Config(30, 3)

// Function that takes implicit parameter
def fetchData(url: String)(implicit config: Config): String = {
  s"Fetching $url with timeout=${config.timeout}"
}

// Compiler finds defaultConfig and passes it
fetchData("http://example.com")
// → "Fetching http://example.com with timeout=30"

// Or pass explicitly
fetchData("http://example.com")(Config(60, 5))
// → "Fetching http://example.com with timeout=60"

// Context bound (common pattern)
def processWithEvidence[T: Ordering](items: List[T]): List[T] = {
  items.sorted  // Ordering[T] implicitly available
}
```

---

## Collections & Data Structures

### List (Immutable Sequence)

```scala
// Creation
val emptyList: List[Int] = List()
val numbers = List(1, 2, 3, 4, 5)
val strings = List("a", "b", "c")
val mixed: List[Any] = List(1, "hello", 3.14)

// Access
numbers(0)       // → 1 (by index)
numbers.head     // → 1 (first)
numbers.tail     // → List(2, 3, 4, 5) (rest)
numbers.last     // → 5 (last element)

// Operations
numbers.length                // → 5
numbers.contains(3)           // → true
numbers.reverse               // → List(5, 4, 3, 2, 1)
numbers.sorted                // → List(1, 2, 3, 4, 5)
numbers.distinct              // → List(1, 2, 3, 4, 5)

// Functional operations
numbers.map(_ * 2)            // → List(2, 4, 6, 8, 10)
numbers.filter(_ > 2)         // → List(3, 4, 5)
numbers.take(3)               // → List(1, 2, 3)
numbers.drop(2)               // → List(3, 4, 5)
numbers.slice(1, 4)           // → List(2, 3, 4)

// Building
1 :: List(2, 3)               // → List(1, 2, 3) (cons)
List(1, 2) ++ List(3, 4)      // → List(1, 2, 3, 4) (concat)
List(1, 2, 3) :+ 4            // → List(1, 2, 3, 4) (append)
```

### Set (Unique Elements)

```scala
// Creation
val numbers = Set(1, 2, 3, 3, 4)  // → Set(1, 2, 3, 4) - duplicates removed
val empty = Set[Int]()

// Operations
numbers.size                  // → 4
numbers.contains(3)           // → true
numbers.head                  // → 1 (arbitrary, sets are unordered)

// Set operations
Set(1, 2, 3) union Set(3, 4)        // → Set(1, 2, 3, 4)
Set(1, 2, 3) | Set(3, 4)             // → Set(1, 2, 3, 4)
Set(1, 2, 3) intersect Set(2, 3, 4) // → Set(2, 3)
Set(1, 2, 3) & Set(2, 3, 4)          // → Set(2, 3)
Set(1, 2, 3) diff Set(2, 3, 4)       // → Set(1)
Set(1, 2, 3) -- Set(2, 3, 4)         // → Set(1)
```

### Map (Key-Value Pairs)

```scala
// Creation
val ages = Map("Alice" -> 30, "Bob" -> 25, "Charlie" -> 35)
val empty = Map[String, Int]()

// Access
ages("Alice")                // → 30
ages.get("Alice")            // → Some(30)
ages.get("David")            // → None
ages.getOrElse("David", 0)   // → 0 (default)

// Operations
ages.size                    // → 3
ages.contains("Alice")       // → true
ages.keys                    // → Set("Alice", "Bob", "Charlie")
ages.values                  // → Iterable(30, 25, 35)

// Transformations
ages.map { case (name, age) => (name, age + 1) }  // Add 1 to all ages
ages.filter { case (_, age) => age > 26 }         // Only age > 26
ages.mapValues(_ + 1)        // → Map("Alice" -> 31, "Bob" -> 26, "Charlie" -> 36)

// Building/Modifying
ages + ("David" -> 40)              // → Added entry
ages - "Bob"                        // → Removed entry
ages ++ Map("Eve" -> 28)            // → Merged
ages.updated("Alice", 31)           // → Updated value
```

### Seq, IndexedSeq, Vector

```scala
// Seq - abstract sequence
val seq: Seq[Int] = Seq(1, 2, 3)

// Vector - efficient indexed access
val vector = Vector(1, 2, 3, 4, 5)
vector(2)  // → 3 (fast O(log n))

// Range - sequence of numbers
val range = 1 to 10              // → Range(1, 2, ..., 10) inclusive
val range2 = 1 until 10          // → Range(1, 2, ..., 9) exclusive
val step = 1 to 10 by 2          // → Range(1, 3, 5, 7, 9)

// Conversion
List(1, 2, 3).toSet              // → Set(1, 2, 3)
Set(1, 2, 3).toList              // → List(1, 2, 3)
"hello".toList                   // → List('h', 'e', 'l', 'l', 'o')
```

### Functional Operations Theory

```
Map: Transform each element
├─ Input: List[A], Function[A => B]
├─ Output: List[B]
├─ Example: [1,2,3].map(x => x*2) = [2,4,6]

Filter: Keep elements matching predicate
├─ Input: List[A], Predicate[A => Boolean]
├─ Output: List[A] (subset)
├─ Example: [1,2,3,4].filter(x => x > 2) = [3,4]

FlatMap: Map then flatten
├─ Input: List[A], Function[A => List[B]]
├─ Output: List[B]
├─ Example: [1,2].flatMap(x => [x, x*2]) = [1,2,2,4]

Fold/Reduce: Combine elements
├─ Input: List[A], initial value, binary operation
├─ Output: Single value
├─ Example: [1,2,3,4].fold(0)(_ + _) = 10

For comprehension: Combine map/filter
├─ Input: Multiple collections, conditions
├─ Output: New collection
├─ Example: for (x <- [1,2]; y <- [3,4]) yield x+y
```

---

## Object-Oriented Programming

### Classes & Constructors

```scala
// Primary constructor (parameters become class fields)
class Person(val firstName: String, val lastName: String, var age: Int) {
  
  // Constructor body (runs when instance created)
  require(age >= 0, "Age must be non-negative")
  
  // Fields
  private val id = UUID.randomUUID()
  
  // Methods
  def fullName: String = s"$firstName $lastName"
  
  override def toString: String = s"$fullName ($age)"
}

// Usage
val alice = Person("Alice", "Smith", 30)
alice.firstName              // → "Alice"
alice.age = 31              // Mutable field
alice.fullName              // → "Alice Smith"

// Auxiliary constructors
class Point(val x: Int, val y: Int) {
  def this(both: Int) = this(both, both)  // Convenience constructor
}
new Point(5)  // → Point(5, 5)
```

### Inheritance & Polymorphism

```scala
// Abstract class (cannot be instantiated)
abstract class Animal {
  val species: String
  def speak(): String
  def move(): Unit
}

// Inheritance
class Dog(val name: String) extends Animal {
  val species = "Canine"
  
  def speak(): String = "Woof!"
  def move(): Unit = println(s"$name runs")
}

class Cat(val name: String) extends Animal {
  val species = "Feline"
  
  def speak(): String = "Meow!"
  def move(): Unit = println(s"$name walks")
}

// Polymorphism
def makeSound(animal: Animal): String = animal.speak()
makeSound(Dog("Rex"))   // → "Woof!"
makeSound(Cat("Fluffy")) // → "Meow!"

// Dynamic dispatch (runtime decision)
val animals: List[Animal] = List(Dog("Rex"), Cat("Fluffy"))
animals.foreach { animal =>
  println(animal.speak())  // Calls correct speak() method
}
```

### Companion Objects

```scala
// Companion object (paired with class, same name)
class Calculator(val name: String) {
  def add(x: Int, y: Int): Int = x + y
}

object Calculator {
  // Factory method
  def apply(name: String) = new Calculator(name)
  
  // Utility method (no instance needed)
  def PI = 3.14159
  
  // Main entry point
  def main(args: Array[String]): Unit = {
    val calc = Calculator("MyCalc")
    println(calc.add(3, 4))
  }
}

// Usage
val calc1 = Calculator("calc1")    // Uses apply()
val calc2 = new Calculator("calc2")  // Direct instantiation
```

### Access Modifiers

```scala
class BankAccount(private var balance: Double) {
  
  // Public (default)
  def getBalance: Double = balance
  
  // Private to this class
  private def validateAmount(amount: Double): Boolean = amount > 0
  
  // Protected (visible in subclasses)
  protected def logTransaction(msg: String): Unit = println(msg)
  
  // Private to package
  private[finance] def adminAccess(): Double = balance
}
```

---

## Functional Programming

### Pure Functions & Immutability

**What is a Pure Function?**

Pure function:
- Same input always produces same output
- No side effects (doesn't modify external state)

```scala
// Pure function
def add(x: Int, y: Int): Int = x + y
add(3, 4)  // → 7 (always)

// Not pure (side effect: printing)
def addAndPrint(x: Int, y: Int): Int = {
  println(s"Adding $x + $y")  // Side effect
  x + y
}

// Not pure (depends on external state)
var multiplier = 2
def multiply(x: Int): Int = x * multiplier  // Result depends on multiplier

// Principle:
// ✓ Pure functions compose easily
// ✓ Pure functions parallelize safely
// ✓ Pure functions test reliably
```

### Higher-Order Functions

```scala
// Function taking function as parameter
def applyOperation(x: Int, y: Int, op: (Int, Int) => Int): Int = {
  op(x, y)
}

applyOperation(3, 4, (a, b) => a + b)      // → 7
applyOperation(3, 4, (a, b) => a * b)      // → 12

// Function returning function
def makeMultiplier(factor: Int): Int => Int = {
  (x: Int) => x * factor
}

val double = makeMultiplier(2)
double(5)  // → 10
double(10) // → 20

// Composition
def compose[A, B, C](f: B => C, g: A => B): A => C = {
  (x: A) => f(g(x))
}

val square: Int => Int = (x: Int) => x * x
val double: Int => Int = (x: Int) => x * 2

val squareThenDouble = compose(double, square)
squareThenDouble(3)  // → 18 (3² = 9, 9 * 2 = 18)
```

### For Comprehensions

**Simplify nested operations**

```scala
// Multiple nested maps
List(1, 2, 3).flatMap { x =>
  List('a', 'b').map { y =>
    (x, y)
  }
}
// → List((1,'a'), (1,'b'), (2,'a'), (2,'b'), (3,'a'), (3,'b'))

// Same with for comprehension
for {
  x <- List(1, 2, 3)
  y <- List('a', 'b')
} yield (x, y)
// → List((1,'a'), (1,'b'), (2,'a'), (2,'b'), (3,'a'), (3,'b'))

// With filters
for {
  x <- List(1, 2, 3, 4, 5)
  y <- List(10, 20, 30)
  if x > 2
  if y < 30
} yield (x, y)
// → List((3, 10), (4, 10), (5, 10))

// Multiple lines
val pairs = for {
  x <- 1 to 3
  y <- 1 to 3
  if x != y
} yield (x, y)
// → Vector((1,2), (1,3), (2,1), (2,3), (3,1), (3,2))
```

### Recursion & Tail Recursion

```scala
// Simple recursion (not stack-safe)
def factorial(n: Int): Int = {
  if (n <= 1) 1
  else n * factorial(n - 1)
}
// Problem: Stack overflow for large n

// Tail recursion (compiler optimizes)
@tailrec  // Compiler ensures tail call optimization
def factorialTail(n: Int, acc: Int = 1): Int = {
  if (n <= 1) acc
  else factorialTail(n - 1, n * acc)
}
// Safe: Can handle large n (optimized to loop)

// Iterative approach (obvious)
def factorialLoop(n: Int): Int = {
  var result = 1
  for (i <- 2 to n) result *= i
  result
}
```

---

## Pattern Matching & Case Classes

### Pattern Matching

**What is Pattern Matching?**

Pattern matching decomposes data structures:

```scala
// Basic pattern matching
def describeNumber(x: Any): String = x match {
  case 1 => "One"
  case 2 => "Two"
  case n: Int if n > 0 => s"Positive: $n"
  case n: Int if n < 0 => s"Negative: $n"
  case s: String => s"String: $s"
  case _ => "Unknown"  // Catch-all
}

describeNumber(1)       // → "One"
describeNumber(5)       // → "Positive: 5"
describeNumber(-3)      // → "Negative: -3"
describeNumber("hello") // → "String: hello"

// List pattern matching
def analyzeList(list: List[Int]): String = list match {
  case Nil => "Empty"
  case x :: Nil => s"Single: $x"
  case x :: y :: Nil => s"Pair: $x, $y"
  case x :: rest => s"First: $x, Rest has ${rest.length} items"
}

analyzeList(List())        // → "Empty"
analyzeList(List(1))       // → "Single: 1"
analyzeList(List(1, 2))    // → "Pair: 1, 2"
analyzeList(List(1, 2, 3)) // → "First: 1, Rest has 2 items"
```

### Case Classes

**What are Case Classes?**

Case classes are optimized for pattern matching:

```scala
// Define case class
case class Person(name: String, age: Int, email: String)

// Automatic features:
// 1. Constructor
val alice = Person("Alice", 30, "alice@example.com")

// 2. Equality
alice == Person("Alice", 30, "alice@example.com")  // → true

// 3. Copy method
val alice2 = alice.copy(age = 31)

// 4. Pattern matching
alice match {
  case Person("Alice", age, _) => println(s"Alice is $age")
  case Person(name, _, email) => println(s"$name: $email")
}

// Nested case classes
case class Address(street: String, city: String)
case class Employee(name: String, address: Address)

val emp = Employee("Bob", Address("123 Main St", "NYC"))

emp match {
  case Employee(n, Address(st, city)) =>
    println(s"$n lives on $st in $city")
}

// Product type (multiple types combined)
val person: (String, Int) = ("Charlie", 35)
person match {
  case (name, age) => println(s"$name: $age")
}
```

---

## Traits & Mixins

### Traits (Interfaces with Implementation)

```scala
// Trait definition
trait Animal {
  def speak(): String
  def move(): Unit
}

trait Swimmer {
  def swim(): String = "Swimming..."
}

trait Flyer {
  def fly(): String = "Flying..."
}

// Single trait
class Dog(name: String) extends Animal {
  def speak(): String = "Woof!"
  def move(): Unit = println("Running")
}

// Multiple traits (mixins)
class Duck(name: String) extends Animal with Swimmer with Flyer {
  def speak(): String = "Quack!"
  def move(): Unit = swim()
}

// Usage
val duck = Duck("Donald")
duck.speak()  // → "Quack!"
duck.swim()   // → "Swimming..."
duck.fly()    // → "Flying..."
```

### Trait Composition

```scala
// Stackable traits (modifying behavior)
trait Logger {
  def log(msg: String): Unit = println(s"LOG: $msg")
}

trait ErrorLogger extends Logger {
  abstract override def log(msg: String): Unit = {
    super.log(s"ERROR: $msg")
  }
}

trait DebugLogger extends Logger {
  abstract override def log(msg: String): Unit = {
    super.log(s"DEBUG: $msg")
  }
}

class ConsoleLogger extends Logger

// Layer traits (order matters)
val errorDebugLogger = new ConsoleLogger with ErrorLogger with DebugLogger
errorDebugLogger.log("Something broke")
// Output: LOG: ERROR: DEBUG: Something broke
```

---

## Advanced Concepts

### Generics & Type Parameterization

```scala
// Generic class
class Container[T](value: T) {
  def get: T = value
  def map[U](f: T => U): Container[U] = Container(f(value))
}

val intContainer = Container(10)
val doubleContainer = Container(3.14)

// Type inference
val stringContainer = Container("hello")  // Type[String] inferred

// Generic function
def swap[A, B](pair: (A, B)): (B, A) = (pair._2, pair._1)
swap((1, "hello"))  // → ("hello", 1)

// Multiple type parameters
class Pair[A, B](val first: A, val second: B) {
  def flip: Pair[B, A] = new Pair(second, first)
}
```

### Type Classes

**What is a Type Class?**

Type classes enable ad-hoc polymorphism (adding behavior to existing types):

```scala
// Define type class
trait Printable[T] {
  def format(value: T): String
}

// Instances for different types
implicit val printableInt = new Printable[Int] {
  def format(value: Int): String = s"Int: $value"
}

implicit val printableString = new Printable[String] {
  def format(value: String): String = s"String: $value"
}

// Use type class with context bound
def printIt[T: Printable](value: T): Unit = {
  val formatter = implicitly[Printable[T]]
  println(formatter.format(value))
}

printIt(42)       // → "Int: 42"
printIt("hello")  // → "String: hello"
```

### Implicit Conversions

```scala
// Implicit conversion (use sparingly!)
implicit def stringToInt(s: String): Int = s.toInt

// Now String can be used where Int expected
val x: Int = "42"  // Implicit conversion applied
val y: Int = x + 8  // → 50

// Better: Rich wrapper pattern
class RichInt(val value: Int) {
  def times(f: => Unit): Unit = {
    for (_ <- 0 until value) f
  }
}

implicit def intToRich(i: Int): RichInt = new RichInt(i)

// Usage
5 times println("Hello")  // Prints "Hello" 5 times
```

### Sealed Classes & ADTs

**Algebraic Data Types (ADTs)**

```scala
// Sealed class (subclasses must be in same file)
sealed trait Result[+T]
case class Success[T](value: T) extends Result[T]
case class Failure(error: String) extends Result[Nothing]

// Pattern matching is exhaustive
def process[T](result: Result[T]): String = result match {
  case Success(value) => s"Success: $value"
  case Failure(error) => s"Error: $error"
  // Compiler ensures all cases covered
}

// Safe: Compiler warns if new case class added without updating match
```

---

## Practical Examples

### Example 1: User Registration Service

```scala
case class User(id: Long, name: String, email: String, age: Int)
case class ValidationError(message: String)

// Functional validation
trait Validator[T] {
  def validate(value: T): Either[ValidationError, T]
}

object UserValidator extends Validator[User] {
  def validate(user: User): Either[ValidationError, User] = {
    val nameValid = user.name.nonEmpty && user.name.length <= 100
    val emailValid = user.email.contains("@")
    val ageValid = user.age >= 0 && user.age <= 150
    
    if (nameValid && emailValid && ageValid) {
      Right(user)
    } else {
      Left(ValidationError("Invalid user data"))
    }
  }
}

// Service
case class UserService(users: scala.collection.mutable.Map[Long, User] = scala.collection.mutable.Map()) {
  def register(user: User): Either[ValidationError, User] = {
    UserValidator.validate(user).flatMap { validUser =>
      users(validUser.id) = validUser
      Right(validUser)
    }
  }
  
  def getUser(id: Long): Option[User] = users.get(id)
  
  def listAll: List[User] = users.values.toList
}

// Usage
val service = UserService()
service.register(User(1, "Alice", "alice@example.com", 30))
  .foreach(u => println(s"Registered: $u"))
```

### Example 2: Pipeline Processing

```scala
case class Order(id: Long, amount: Double, status: String)

// Step 1: Validate order
def validate(order: Order): Either[String, Order] = {
  if (order.amount > 0) Right(order) else Left("Invalid amount")
}

// Step 2: Apply discount
def applyDiscount(order: Order): Order = {
  val discountedAmount = if (order.amount > 100) order.amount * 0.9 else order.amount
  order.copy(amount = discountedAmount)
}

// Step 3: Log order
def log(order: Order): Order = {
  println(s"Processing order ${order.id}: ${order.amount}")
  order
}

// Pipeline
def processOrder(order: Order): Either[String, Order] = {
  for {
    validated <- validate(order)
    discounted = applyDiscount(validated)
    logged = log(discounted)
  } yield logged
}

// Usage
val order = Order(1, 150, "pending")
processOrder(order).foreach(o => println(s"Final: $o"))
```

### Example 3: Recursive Tree Processing

```scala
sealed trait Tree[T]
case class Leaf[T](value: T) extends Tree[T]
case class Branch[T](left: Tree[T], right: Tree[T]) extends Tree[T]

// Tree operations
object TreeOps {
  def map[A, B](tree: Tree[A], f: A => B): Tree[B] = tree match {
    case Leaf(value) => Leaf(f(value))
    case Branch(left, right) => Branch(map(left, f), map(right, f))
  }
  
  def sum[T: Numeric](tree: Tree[T]): T = {
    val numeric = implicitly[Numeric[T]]
    tree match {
      case Leaf(value) => value
      case Branch(left, right) => 
        numeric.plus(sum(left), sum(right))
    }
  }
  
  def size[T](tree: Tree[T]): Int = tree match {
    case Leaf(_) => 1
    case Branch(left, right) => size(left) + size(right)
  }
}

// Usage
val tree: Tree[Int] = 
  Branch(
    Branch(Leaf(1), Leaf(2)),
    Branch(Leaf(3), Leaf(4))
  )

TreeOps.sum(tree)  // → 10
TreeOps.size(tree)  // → 4
TreeOps.map(tree, (x: Int) => x * 2)  // All values doubled
```

---

## Important Q&A

### Language Fundamentals

**Q1: Why use Scala instead of Java?**

A:
- **Less boilerplate**: Scala is 20-40% shorter than Java for same functionality
- **Functional programming**: First-class functions, immutability by default
- **Type safety**: Null safety with Option type
- **Expressiveness**: Powerful syntax for domain-specific problems

```scala
// Java (verbose)
public class Greeting {
  private String name;
  public Greeting(String name) {
    this.name = name;
  }
  public String greet() {
    return "Hello, " + name;
  }
}

// Scala (concise)
case class Greeting(name: String) {
  def greet = s"Hello, $name"
}
```

**Q2: What's the difference between val and var?**

A:
- `val`: Immutable (cannot be reassigned)
- `var`: Mutable (can be reassigned)

```scala
val x = 10
x = 20  // ❌ Error: reassignment to val

var y = 10
y = 20  // ✓ OK

// Note: val makes variable immutable, not the object
val list = scala.collection.mutable.List(1, 2, 3)
list(0) = 10  // ✓ OK - modifying object contents
list = scala.collection.mutable.List(4, 5)  // ❌ Error - reassigning variable
```

**Q3: How does Option compare to null checking?**

A:
```scala
// Java/C approach (error-prone)
String name = person.getName();  // Could be null!
if (name != null) {
  System.out.println(name);  // Forget check = NullPointerException
}

// Scala approach (type-safe)
val name: Option[String] = person.name
name match {
  case Some(n) => println(n)
  case None => println("No name")
}

// Or functional
name.foreach(println)
name.map(_.toUpperCase)
name.getOrElse("Unknown")
```

### Functional Programming

**Q4: What are higher-order functions?**

A:
Functions that take or return functions as values:

```scala
// Takes function
def twice(f: Int => Int, x: Int): Int = f(f(x))
twice(x => x * 2, 5)  // → 20

// Returns function
def makeAdder(n: Int): Int => Int = x => x + n
val add5 = makeAdder(5)
add5(3)  // → 8

// Benefits:
// ✓ Function reuse
// ✓ Composability
// ✓ Abstraction of patterns
```

**Q5: How do for comprehensions work?**

A:
For comprehensions are syntactic sugar for flatMap/map/filter:

```scala
// For comprehension
for {
  x <- List(1, 2, 3)
  y <- List('a', 'b')
  if x > 1
} yield (x, y)

// Equivalent to
List(1, 2, 3)
  .filter(_ > 1)
  .flatMap { x =>
    List('a', 'b')
      .map { y =>
        (x, y)
      }
  }
```

### Collections

**Q6: List vs. Vector - which to use?**

A:
- **List**: O(1) head/tail access, better for recursion
- **Vector**: O(log n) random access, better for iteration

```scala
// Use List when:
val list = 1 :: 2 :: 3 :: Nil  // Recursive building
list match {
  case head :: tail => ...  // Pattern matching
}

// Use Vector when:
val vector = Vector(1, 2, 3)
vector(100)  // Random access fast

// Rule of thumb:
// List: Functional/recursive code
// Vector: General-purpose collections
```

**Q7: When should I use flatMap vs. map?**

A:
- **map**: Transform each element
- **flatMap**: Transform each element, then flatten

```scala
// map - returns nested structure
List(1, 2, 3).map(x => List(x, x * 2))
// → List(List(1, 2), List(2, 4), List(3, 6))

// flatMap - flattens automatically
List(1, 2, 3).flatMap(x => List(x, x * 2))
// → List(1, 2, 2, 4, 3, 6)

// With Option
Some(5).map(x => Some(x * 2))  // → Some(Some(10))
Some(5).flatMap(x => Some(x * 2))  // → Some(10)
```

### OOP Concepts

**Q8: When to use traits vs. abstract classes?**

A:
- **Trait**: Behavior to mix in, multiple inheritance
- **Abstract class**: Shared state/constructor logic, single inheritance

```scala
// Use trait for behavior
trait Serializable {
  def serialize: String
}

trait Comparable {
  def compare(other: Any): Int
}

class Person extends Comparable with Serializable {
  // Multiple traits ✓
}

// Use abstract class for shared state
abstract class Animal(name: String) {
  // Constructor parameter
  protected val species: String
}

class Dog(name: String) extends Animal(name) {
  val species = "Canine"
}
```

**Q9: What's a companion object?**

A:
Singleton object paired with a class, same name:

```scala
class Calculator(val name: String) {
  def add(x: Int, y: Int) = x + y
}

object Calculator {
  def apply(name: String) = new Calculator(name)
  def PI = 3.14159
}

// Usage
val calc = Calculator("MyCalc")  // Uses apply()
Calculator.PI  // → 3.14159
```

### Type System

**Q10: What are type bounds?**

A:
Constraining type parameters:

```scala
// Upper bound: T must be <= specified type
def sort[T <: Ordered[T]](list: List[T]): List[T] = ...

// Lower bound: T must be >= specified type
def add[T >: Int](value: T): Unit = ...

// Context bound: implicit evidence required
def sum[T: Numeric](list: List[T]): T = ...
```

---

## Comprehensive Q&A

### Advanced Monadic Operations

**Q11: What are the three monad laws?**

A:

The monad laws guarantee predictable composition:

```scala
// Law 1: Left Identity
// flatMap-ing a value with a function is same as applying function
M.pure(a).flatMap(f) == f(a)

// Example:
Some(3).flatMap(x => Some(x * 2)) == Some(6)

// Law 2: Right Identity
// flatMap-ing with pure returns the same value
m.flatMap(M.pure) == m

// Example:
Some(3).flatMap(Some(_)) == Some(3)

// Law 3: Associativity
// Order of composition doesn't matter
m.flatMap(f).flatMap(g) == m.flatMap(x => f(x).flatMap(g))

// Example:
Some(3)
  .flatMap(x => Some(x * 2))
  .flatMap(x => Some(x + 1))
  ==
Some(3).flatMap(x => Some(x * 2).flatMap(y => Some(y + 1)))
// Both: Some(7)
```

**Why laws matter:**
- Compiler can safely optimize
- Code is predictable
- Composable with other monads

**Q12: When should I use Either vs. Try vs. Option?**

A:

```scala
// Option[T]: Represents presence/absence
├─ Some(value) or None
├─ Use when: Result optional but no error info needed
├─ Example: List(1,2,3).find(_ > 2) → Some(3)

// Try[T]: Wraps exceptions
├─ Success(value) or Failure(exception)
├─ Use when: Converting exception-throwing code
├─ Example: Try("42".toInt) → Success(42)

// Either[L, R]: Explicit error information
├─ Right(value) or Left(error)
├─ Use when: Explicit error handling needed
├─ Example: validateEmail("invalid") → Left("Bad email")

// Comparison:
Option:     ✓ Simple,      ✗ No error info
Try:        ✓ Exception safe, ✗ Carries exception object
Either:     ✓ Flexible,    ✓ Custom error types
```

**Q13: How do implicits affect compilation time?**

A:

```scala
// Implicit search is expensive:
├─ Compiler searches local scope
├─ Searches imports
├─ Searches companion objects
├─ Can cause ambiguity errors
└─ Makes compilation slower

// Best practices:
implicit val x: Int = 1
implicit val y: Int = 2  // ❌ Ambiguous!

// Solution: Use type classes (more specific)
trait Formatter[T] { def format(t: T): String }

implicit val intFormatter: Formatter[Int] = ...
implicit val stringFormatter: Formatter[String] = ...
// ✓ No ambiguity (different types)

// Performance tip:
// Minimize implicit definitions in scope
// Use type classes instead of implicit conversions
// Avoid very general implicits
```

### Practical Scala Development

**Q14: How do I handle null from Java code?**

A:

```scala
// Java returns nullable values
val javaList: java.util.List[String] = getListFromJava()

// ❌ Dangerous: Direct null check
if (javaList != null) {
  javaList.forEach(println)
}

// ✓ Better: Use Option to wrap
val scalaList = Option(javaList)
scalaList.foreach(_.forEach(println))

// ✓ Best: Convert to Scala collection
val scalaList = Option(javaList).map(_.asScala.toList).getOrElse(List())

// Or cleaner:
import scala.collection.JavaConverters._

val scalaList = Option(javaList)
  .map(_.asScala)
  .getOrElse(List())
```

**Q15: What's the difference between def, val, and lazy val?**

A:

```scala
// def: Method (computed each time called)
def power: Int = {
  println("Computing...")
  2 * 2
}
power  // Prints "Computing..."
power  // Prints "Computing..." again

// val: Immutable variable (computed once, stored)
val result: Int = {
  println("Computing...")
  2 * 2
}
result  // Prints "Computing..." once
result  // No print (cached)

// lazy val: Computed on first access, then cached
lazy val expensive: Int = {
  println("Computing...")
  2 * 2
}
expensive  // Prints "Computing..." (first access)
expensive  // No print (cached)

// Use cases:
def:       ✓ Lightweight, ✓ Fresh computation, ✗ Slow if called often
val:       ✓ Fast, ✓ Computed early, ✗ Always computed
lazy val:  ✓ Computed only if used, ✓ Fast after first access, ✗ Thread-unsafe
```

**Q16: How do I write code that's both functional and practical?**

A:

```scala
// Problem: 100% functional can be impractical
val users = getAllUsers  // Data from database
val result = users
  .filter(_.age > 18)
  .map(u => s"${u.name}: ${u.email}")
  .foreach(println)  // Side effect!

// Philosophy: Separate pure from effectful
sealed trait Result[+T]
case class Success[T](value: T) extends Result[T]
case class Error(message: String) extends Result[Nothing]

// Pure: No side effects
def validateUsers(users: List[User]): Result[List[User]] = {
  val valid = users.filter(_.age >= 0)
  if (valid.isEmpty) Error("No valid users")
  else Success(valid)
}

// Effectful: At the boundary
def main(): Unit = {
  val users = getAllUsers  // I/O
  validateUsers(users) match {
    case Success(validated) => 
      validated.foreach(println)  // I/O
    case Error(msg) =>
      System.err.println(msg)  // I/O
  }
}

// Pattern: I/O at edges, pure logic in middle
```

### Performance & Optimization

**Q17: How does tail recursion improve performance?**

A:

```scala
// Standard recursion (Stack grows)
def sum(list: List[Int]): Int = {
  if (list.isEmpty) 0
  else list.head + sum(list.tail)
}

// Stack trace for sum(List(1,2,3)):
sum(List(1,2,3))
  → 1 + sum(List(2,3))
    → 1 + (2 + sum(List(3)))
      → 1 + (2 + (3 + sum(Nil)))
        → 1 + (2 + (3 + 0))
// Stack depth: 3

// Tail recursion (Optimized to loop)
@tailrec
def sumTail(list: List[Int], acc: Int = 0): Int = {
  if (list.isEmpty) acc
  else sumTail(list.tail, acc + list.head)
}

// Stack trace for sumTail(List(1,2,3)):
sumTail(List(1,2,3), 0)
  → sumTail(List(2,3), 1)
    → sumTail(List(3), 3)
      → sumTail(Nil, 6)
        → 6
// Stack depth: 1 (constant!)

// Compiler converts tail recursion to loop:
// while (list.isEmpty == false) {
//   acc = acc + list.head
//   list = list.tail
// }

// Performance impact:
// Recursion: O(n) stack space, risk of overflow
// Tail recursion: O(1) stack space, safe
```

**Q18: When should I use Stream vs. List for large data?**

A:

```scala
// Stream: Lazy evaluation
val stream: Stream[Int] = (1 to 1000000).toStream
stream.filter(_ % 2 == 0).take(10).toList
// → List(2, 4, 6, 8, 10, 12, 14, 16, 18, 20)
// Only evaluates first ~21 elements!

// List: Eager evaluation
val list = (1 to 1000000).toList
list.filter(_ % 2 == 0).take(10)
// Evaluates all 1,000,000 elements first!

// Memory usage:
// Stream: ~1KB (10 elements in memory)
// List: ~4MB (1 million elements in memory)

// Use Stream when:
├─ Very large collections
├─ Infinite sequences
├─ Only need partial results
└─ Want to defer computation

// Use List when:
├─ Need random access
├─ Need to iterate multiple times
├─ Results are small
└─ Want predictable timing
```

### Type System Mastery

**Q19: What's the difference between +T and -T variance?**

A:

```scala
sealed trait Animal
case class Dog() extends Animal
case class Cat() extends Animal

// Covariance (+T): Can use subtype where supertype expected
// Example: Producer type
trait Producer[+T] {
  def produce(): T
}

val dogProducer: Producer[Dog] = new Producer[Dog] {
  def produce() = Dog()
}

val animalProducer: Producer[Animal] = dogProducer  // ✓ OK!
// Makes sense: If you produce Dogs, you produce Animals

// Contravariance (-T): Can use supertype where subtype expected
// Example: Consumer type
trait Consumer[-T] {
  def consume(t: T): Unit
}

val animalConsumer: Consumer[Animal] = new Consumer[Animal] {
  def consume(t: Animal) = println(t)
}

val dogConsumer: Consumer[Dog] = animalConsumer  // ✓ OK!
// Makes sense: Consumer of Animals can consume Dogs

// Invariance (T): Cannot use sub/supertypes
class Container[T](var value: T)

val dogContainer: Container[Dog] = Container(Dog())
val animalContainer: Container[Animal] = dogContainer  // ❌ Error!
// Prevents: animalContainer.value = Cat()  (would break dogContainer)

// Rule of thumb:
├─ Covariance (+): "Producer" - outputs T
├─ Contravariance (-): "Consumer" - takes T as input
└─ Invariance: "Both" - reads and writes T
```

**Q20: How do I use higher-ranked types?**

A:

```scala
// Higher-ranked type (forall): Type parameter in function signature
def applyToAll[A](f: [T] => (T => T))(values: List[A]): List[A] = {
  values.map(f[A])
}

// Real-world: Rank-2 polymorphism
trait Polymorphic {
  def apply[T](value: T): T
}

def workWithPolymorphic(poly: Polymorphic): Unit = {
  poly.apply[Int](42)
  poly.apply[String]("hello")
}

// Use case: Testing polymorphic functions
def testPolymorphic(id: Polymorphic): Unit = {
  // id must work for ANY type, not just one
  assert(id.apply[Int](42) == 42)
  assert(id.apply[String]("hello") == "hello")
}
```

### Akka & Concurrency

**Q21: Why use Actor model instead of threads?**

A:

```scala
// Thread model problems:
var counter = 0  // Shared state

// Thread 1
Thread1: counter = counter + 1

// Thread 2
Thread2: counter = counter + 1

// Problem: Race condition!
// Expected: counter = 2
// Possible: counter = 1 (read before other thread's write)

// Synchronization with locks (error-prone)
var counter = 0
val lock = new Object()

Thread1: lock.synchronized { counter = counter + 1 }
Thread2: lock.synchronized { counter = counter + 1 }
// Works but: deadlock risk, hard to debug, doesn't scale

// Actor model solution:
class Counter extends Actor {
  var count = 0
  
  def receive: Receive = {
    case "increment" =>
      count += 1
      sender() ! count
  }
}

// Messages processed sequentially: No race condition!
// No locks needed: Much simpler
// Scales: Millions of actors on single machine
```

**Q22: What's the difference between Future and Actor?**

A:

```scala
// Future: One-time result computation
val future = Future {
  Thread.sleep(1000)
  42  // Result
}

future.onSuccess { case result =>
  println(s"Got: $result")
}

// Use: Fire-and-forget computations, async I/O

// Actor: Stateful, continuous processing
class Accumulator extends Actor {
  var sum = 0
  
  def receive: Receive = {
    case n: Int =>
      sum += n
      sender() ! sum
  }
}

// Use: Stateful systems, message processing, long-lived services

// Comparison:
Future:  ✓ Simple, ✗ One result, ✗ No state
Actor:   ✓ Stateful, ✓ Long-lived, ✗ More complex
```

### Common Mistakes

**Q23: Why does my pattern match give "unreachable code" warning?**

A:

```scala
// ❌ Wrong: Order matters in pattern matching
sealed trait Result
case class Success(value: Int) extends Result
case class Failure(msg: String) extends Result

def handle(r: Result): String = r match {
  case Success(v) => s"Success: $v"
  case Failure(m) => s"Failure: $m"
  case Success(v) => s"Another success"  // ❌ Unreachable!
}

// ✓ Correct: More specific patterns first
def handle(r: Result): String = r match {
  case Success(v) if v > 0 => s"Positive: $v"
  case Success(v) if v < 0 => s"Negative: $v"
  case Success(0) => "Zero"
  case Failure(m) => s"Failure: $m"
}

// Why: Compiler pattern matches top-to-bottom
// Once matched, no fallthrough
// Unreachable patterns trigger warning
```

**Q24: Why do my implicits cause ambiguous errors?**

A:

```scala
// ❌ Wrong: Too many matching implicits
implicit val default1 = "Option1"
implicit val default2 = "Option2"

def needsString(implicit s: String) = s  // ❌ Ambiguous!

// ✓ Correct: Use type classes
trait DefaultValue[T] {
  def value: T
}

implicit val defaultInt = new DefaultValue[Int] { val value = 42 }
implicit val defaultString = new DefaultValue[String] { val value = "hello" }

def needsDefault[T: DefaultValue]: T = {
  implicitly[DefaultValue[T]].value
}

// ✓ Correct: More specific types
implicit val localDefault: Int = 1
implicit val globalDefault: Any = "global"

def needsInt(implicit i: Int) = i  // ✓ Takes Int, not Any
```

**Q25: Why is my mutable collection causing thread safety issues?**

A:

```scala
// ❌ Wrong: Mutable shared state
var counter = 0  // Shared

Future {
  for (_ <- 1 to 1000) {
    counter += 1  // Thread 1
  }
}

Future {
  for (_ <- 1 to 1000) {
    counter += 1  // Thread 2
  }
}

Thread.sleep(500)
println(counter)  // ❌ Not 2000! (likely 1200-1800)

// ✓ Correct: Immutable + Actors
class Counter extends Actor {
  var count = 0
  
  def receive: Receive = {
    case "inc" => count += 1
  }
}

val counter = system.actorOf(Props[Counter])
for (_ <- 1 to 1000) counter ! "inc"
for (_ <- 1 to 1000) counter ! "inc"
// ✓ Thread safe: Sequential message processing
```

### Best Practices

**Q26: How do I structure a large Scala project?**

A:

```scala
// Project structure:
src/
├── main/
│   ├── scala/
│   │   ├── com/
│   │   │   └── example/
│   │   │       ├── domain/       (Core types)
│   │   │       │   ├── User.scala
│   │   │       │   ├── Order.scala
│   │   │       │   └── errors.scala
│   │   │       ├── services/     (Business logic)
│   │   │       │   ├── UserService.scala
│   │   │       │   ├── OrderService.scala
│   │   │       │   └── PaymentService.scala
│   │   │       ├── controllers/  (API endpoints)
│   │   │       │   ├── UserController.scala
│   │   │       │   └── OrderController.scala
│   │   │       ├── repository/   (Data access)
│   │   │       │   ├── UserRepository.scala
│   │   │       │   └── OrderRepository.scala
│   │   │       └── Main.scala
│   │   └── resources/
│   │       └── application.conf
│   └── test/
│       ├── scala/
│       │   └── com/example/
│       │       ├── services/
│       │       │   ├── UserServiceSpec.scala
│       │       │   └── OrderServiceSpec.scala
│       │       └── integration/
│       │           └── APISpec.scala
│       └── resources/
│           └── application-test.conf

// Principles:
├─ Separate domain from business logic
├─ Separate services from data access
├─ Group by feature, not by layer
├─ One class per file
└─ Put tests next to code being tested
```

**Q27: What's the best error handling strategy?**

A:

```scala
// Strategy 1: Option (simple, lose error info)
def safeDivide(a: Int, b: Int): Option[Int] = {
  if (b == 0) None else Some(a / b)
}

// Strategy 2: Either (explicit error)
def safeDivideEither(a: Int, b: Int): Either[String, Int] = {
  if (b == 0) Left("Division by zero")
  else Right(a / b)
}

// Strategy 3: Try (wraps exceptions)
def safeDivideTry(a: Int, b: Int): Try[Int] = {
  Try(a / b)
}

// Strategy 4: Monad stack (complex, powerful)
type Result[T] = Either[Error, T]

def processOrder(order: Order): Result[Receipt] = {
  for {
    validated <- validateOrder(order)
    charged <- chargePayment(validated)
    receipt <- generateReceipt(charged)
  } yield receipt
}

// Recommendation:
// - Simple APIs: Use Option
// - Custom errors: Use Either
// - Exception handling: Use Try
// - Complex workflows: Use monad stack
```

**Q28: How do I write testable Scala code?**

A:

```scala
// ❌ Hard to test: Hard dependencies
class UserService {
  private val db = new Database()  // Hard dependency
  
  def getUser(id: Int): User = {
    db.query(s"SELECT * FROM users WHERE id=$id")
  }
}

// ✓ Easy to test: Constructor injection
class UserService(db: Database) {
  def getUser(id: Int): User = {
    db.query(s"SELECT * FROM users WHERE id=$id")
  }
}

// Test with mock:
val mockDb = mock[Database]
when(mockDb.query(any)).thenReturn(User("Alice", 30))

val service = new UserService(mockDb)
val user = service.getUser(1)

assert(user.name == "Alice")

// ✓ Best: Trait-based injection (Cake pattern)
trait UserServiceComponent {
  def userService: UserService
}

trait DatabaseComponent {
  def database: Database
}

trait Database {
  def query(sql: String): User
}

// Production: Real implementations
// Testing: Mock implementations
```

---

**Last Updated**: December 2025
**Version**: 3.0
**Scope**: Comprehensive Scala Language Guide with Advanced Q&A
**Contents**: 20+ chapters, 28 in-depth Q&As, patterns, best practices

### Monads & Monad Laws

**What is a Monad?**

A monad is a design pattern that allows for elegant composition of operations:

```scala
// Monad has three operations:

// 1. Pure/Return: Wrap value in monad
def pure[A](value: A): Monad[A]

// 2. FlatMap/Bind: Compose monadic operations
def flatMap[A, B](m: Monad[A], f: A => Monad[B]): Monad[B]

// 3. (Implicit) Map: Transform value inside monad
def map[A, B](m: Monad[A], f: A => B): Monad[B]
```

**Real-World Example: Option as Monad**

```scala
// Monad laws guarantee these work predictably

// Law 1: Left Identity
Some(3).flatMap(x => Some(x * 2)) == Some(6)

// Law 2: Right Identity
Some(3).flatMap(Some(_)) == Some(3)

// Law 3: Associativity
Some(3)
  .flatMap(x => Some(x * 2))
  .flatMap(x => Some(x + 1))
  ==
Some(3).flatMap(x => Some(x * 2).flatMap(y => Some(y + 1)))

// Both equal: Some(7)
```

**Option as Monad Pattern:**

```scala
// Without monad (imperative, error-prone)
def processUserData(id: Int): Option[String] = {
  val user = getUser(id)
  if (user == None) return None
  
  val address = user.get.address
  if (address == None) return None
  
  val city = address.get.city
  if (city == None) return None
  
  Some(city.get.toUpperCase)
}

// With monad (functional, elegant)
def processUserData(id: Int): Option[String] = {
  for {
    user <- getUser(id)
    address <- user.address
    city <- address.city
  } yield city.toUpperCase
}

// Or with flatMap (monadic composition)
def processUserData(id: Int): Option[String] = {
  getUser(id)
    .flatMap(_.address)
    .flatMap(_.city)
    .map(_.toUpperCase)
}

// All three equivalent, but last two are cleaner
```

### Functor, Applicative, Monad Hierarchy

**Type Class Hierarchy:**

```
Functor (map)
    ↓
Applicative (map + apply)
    ↓
Monad (map + flatMap)

Functor:
├─ Transforms value inside context
├─ Operation: map
└─ Example: List[Int].map(x => x * 2)

Applicative:
├─ Wraps function in context
├─ Operations: map + apply
└─ Example: (Some(x), Some(f)) => Some(f(x))

Monad:
├─ Chains operations that return context
├─ Operations: map + flatMap
└─ Example: for comprehensions
```

### Lazy Evaluation & Streams

**Lazy vs. Strict Evaluation**

```scala
// Strict evaluation (immediate)
val numbers = List(1, 2, 3, 4, 5)
val doubled = numbers.map(x => {
  println(s"Processing $x")
  x * 2
})
// Prints immediately: 1, 2, 3, 4, 5

// Lazy evaluation (deferred)
val lazyNumbers = (1 to 5).view
val lazyDoubled = lazyNumbers.map(x => {
  println(s"Processing $x")
  x * 2
})
// Prints nothing yet - computation deferred!

lazyDoubled.toList
// Now prints: 1, 2, 3, 4, 5 (computed on demand)
```

**Streams (Infinite Lazy Collections)**

```scala
// Stream: Lazy, linked list-like
val infiniteNumbers: Stream[Int] = 1 #:: infiniteNumbers.map(_ + 1)
// Stream is infinite but lazy - only computes what's used

infiniteNumbers.take(5).toList
// → List(1, 2, 3, 4, 5)

// Use case: Process large/infinite data without loading all in memory
val fileLines: Stream[String] = scala.io.Source.fromFile("large_file.txt").getLines.toStream
fileLines.filter(_.contains("ERROR")).take(10)  // Only processes needed lines
```

### Recursion & Tail Call Optimization

**Stack Safety Through TCO**

```scala
// Naive recursion (not stack-safe, will overflow)
def sumRecursive(list: List[Int]): Int = {
  list match {
    case Nil => 0
    case head :: tail => head + sumRecursive(tail)
  }
}

// Problem: Each recursive call adds to stack
// For List of 100k items: Stack overflow!

// Tail recursion (stack-safe, compiler optimizes)
@tailrec
def sumTailRecursive(list: List[Int], acc: Int = 0): Int = {
  list match {
    case Nil => acc
    case head :: tail => sumTailRecursive(tail, acc + head)
  }
}

// Better: Compiler optimizes tail calls to loop
// No stack growth regardless of list size

// Best: Use library functions
def sumBuiltin(list: List[Int]): Int = list.sum
```

**When to use @tailrec annotation:**

```scala
// ✓ Good for algorithms that fit tail-recursion pattern
@tailrec
def factorial(n: Int, acc: Int = 1): Int = {
  if (n <= 1) acc else factorial(n - 1, acc * n)
}

// ❌ Cannot be tail-recursive (accumulator not last operation)
def fibonacci(n: Int): Int = {
  if (n <= 1) n else fibonacci(n - 1) + fibonacci(n - 2)
}

// Rule: Last operation must be recursive call (nothing after it)
```

### Phantom Types & Type Safety

**Type Safety Beyond Values**

```scala
// Phantom type: Type parameter unused at runtime
sealed abstract class CheckedTag
sealed abstract class UncheckedTag

case class Email[T](value: String)

def sendEmail(email: Email[CheckedTag]): Unit = {
  println(s"Sending to ${email.value}")
}

// Unchecked email (type error at compile time)
val unchecked = Email[UncheckedTag]("user@example.com")
sendEmail(unchecked)  // ❌ Compile error!

// Checked email (type safe)
def validate(email: Email[UncheckedTag]): Email[CheckedTag] = {
  // Validation logic...
  Email[CheckedTag](email.value)
}

val checked = validate(Email("user@example.com"))
sendEmail(checked)  // ✓ OK!

// Benefit: Compile-time guarantee that email was validated
```

### Self Types & Cake Pattern

**Cake Pattern (Dependency Injection)**

```scala
// Traditional: Constructor injection
class DatabaseComponent {
  def query(sql: String): List[String] = {
    // Database query logic
    List()
  }
}

class UserService(db: DatabaseComponent) {
  def getUsers: List[String] = db.query("SELECT * FROM users")
}

// Cake Pattern: Self types (trait mix-in injection)
trait DatabaseComponent {
  def query(sql: String): List[String]
}

trait UserServiceComponent { self: DatabaseComponent =>
  class UserService {
    def getUsers: List[String] = self.query("SELECT * FROM users")
  }
}

// Concrete implementation
object AppComponents extends DatabaseComponent with UserServiceComponent {
  def query(sql: String): List[String] = {
    // Real database query
    List()
  }
}

// Usage
AppComponents.new UserService().getUsers
```

### Partial Application & Currying Theory

**Why Currying?**

```scala
// Uncurried (all parameters at once)
def multiply(x: Int, y: Int): Int = x * y
multiply(3, 4)  // → 12

// Curried (one parameter at a time)
def multiplyCurried(x: Int)(y: Int): Int = x * y
multiplyCurried(3)(4)  // → 12

// Key benefit: Partial application
val multiplyBy3 = multiplyCurried(3)(_)
multiplyBy3(4)  // → 12
multiplyBy3(5)  // → 15

// Use case: Create specialized functions
val double = multiplyCurried(2)(_)
val triple = multiplyCurried(3)(_)
val quadruple = multiplyCurried(4)(_)

List(1, 2, 3).map(double)  // → List(2, 4, 6)
List(1, 2, 3).map(triple)  // → List(3, 6, 9)
```

### Error Handling: Try, Either, Validation

**Error Handling Comparison**

```scala
import scala.util.Try

// Approach 1: Try (like Option but carries exception)
def parseIntTry(s: String): Try[Int] = Try(s.toInt)

parseIntTry("42") match {
  case scala.util.Success(n) => println(s"Parsed: $n")
  case scala.util.Failure(ex) => println(s"Error: ${ex.getMessage}")
}

// Approach 2: Either (explicitly contains Left/Right)
def parseIntEither(s: String): Either[String, Int] = {
  try {
    Right(s.toInt)
  } catch {
    case e: Exception => Left(s"Invalid number: ${e.getMessage}")
  }
}

parseIntEither("42") match {
  case Right(n) => println(s"Parsed: $n")
  case Left(err) => println(s"Error: $err")
}

// Approach 3: Validation (accumulates errors)
case class ValidationError(message: String)

def validateEmail(email: String): Either[ValidationError, String] = {
  if (email.contains("@")) Right(email) else Left(ValidationError("Invalid email"))
}

def validateAge(age: Int): Either[ValidationError, Int] = {
  if (age >= 18) Right(age) else Left(ValidationError("Too young"))
}

// Composing validations
for {
  email <- validateEmail("user@example.com")
  age <- validateAge(25)
} yield (email, age)

// Comparison:
// Try: Good for exceptions
// Either: Good for explicit errors
// Validation: Good for accumulating multiple errors
```

### Implicit Resolution & Scope

**How Implicits Are Resolved**

```scala
// Implicit scope (compiler searches in order):

// 1. Local scope
implicit val localInt: Int = 10

// 2. Class companion objects
class MyClass
object MyClass {
  implicit val companionInt: Int = 20
}

// 3. Imported implicits
import scala.math.Ordering.IntOrdering

// 4. Package object
// (in package.scala)
package mypackage
package object math {
  implicit val defaultPrecision = 2
}

// 5. Superclass implicits

// Implicit resolution ambiguity
implicit val x: Int = 1
implicit val y: Int = 2

def needsInt(implicit i: Int) = i
needsInt  // ❌ Ambiguous! x or y?

// Solution: Make one more specific
implicit val z: Int = 3  // All same type
needsInt  // ❌ Still ambiguous

// Better: Use type classes
trait Formatter[T] {
  def format(t: T): String
}

implicit val intFormatter: Formatter[Int] = new Formatter[Int] {
  def format(i: Int) = i.toString
}

implicit val stringFormatter: Formatter[String] = new Formatter[String] {
  def format(s: String) = s"\"$s\""
}

def show[T: Formatter](t: T): String = {
  implicitly[Formatter[T]].format(t)
}
```

### Akka Actor Model (Concurrency Pattern)

**Actor Model Theory**

```
Traditional Concurrency (Threads):
├─ Shared mutable state
├─ Locks & synchronization (error-prone)
├─ Deadlocks possible
├─ Hard to debug
└─ Doesn't scale well

Actor Model (Akka):
├─ No shared state (each actor isolated)
├─ Message passing (communication only)
├─ No locks needed (messages queued)
├─ Deadlock-free (by design)
├─ Scales to millions of actors
└─ Easier to reason about
```

**Simple Actor Example**

```scala
import akka.actor.{Actor, ActorSystem, Props}

// Define actor
class Counter extends Actor {
  var count = 0
  
  def receive: Receive = {
    case "increment" =>
      count += 1
      println(s"Count: $count")
    
    case "get" =>
      sender() ! count  // Reply to sender
    
    case msg: String =>
      println(s"Received: $msg")
  }
}

// Create actor system
val system = ActorSystem("MySystem")

// Create actor instance
val counter = system.actorOf(Props[Counter], "counter")

// Send messages (no return value, async)
counter ! "increment"  // Message 1
counter ! "increment"  // Message 2
counter ! "get"        // Ask for value

// Messages processed sequentially (no race condition)
```

**Benefits Over Threads:**

```
Thread Model (10,000 threads):
├─ Memory: ~1MB per thread = 10GB total
├─ CPU: Context switching overhead
├─ Synchronization: Complex locks
└─ Time: Slow

Actor Model (10,000 actors):
├─ Memory: ~40 bytes per actor = 400KB total
├─ CPU: Minimal context switching
├─ Synchronization: None (isolated state)
└─ Time: Fast

Conclusion: Actors scale much better
```

### Traversals & Transversals

**Lenses (Functional Getters/Setters)**

```scala
// Problem: Nested case class updates
case class Address(street: String, city: String)
case class Person(name: String, address: Address)

val person = Person("Alice", Address("123 Main", "NYC"))

// Traditional: Very verbose
val newPerson = person.copy(
  address = person.address.copy(city = "LA")
)

// Lens solution: Functional reference
case class Lens[A, B](
  get: A => B,
  set: (B, A) => A
)

// Define lenses
val addressLens = Lens[Person, Address](
  _.address,
  (addr, p) => p.copy(address = addr)
)

val cityLens = Lens[Address, String](
  _.city,
  (city, addr) => addr.copy(city = city)
)

// Compose lenses
def composeLens[A, B, C](l1: Lens[A, B], l2: Lens[B, C]): Lens[A, C] = {
  Lens[A, C](
    a => l2.get(l1.get(a)),
    (c, a) => l1.set(l2.set(c, l1.get(a)), a)
  )
}

val personCityLens = composeLens(addressLens, cityLens)

// Use lens: Elegant update
val updated = personCityLens.set("LA", person)
```

---

## Design Patterns in Scala

### Builder Pattern

```scala
// Traditional builder
class PersonBuilder {
  private var name = ""
  private var age = 0
  private var email = ""
  
  def setName(n: String) = { name = n; this }
  def setAge(a: Int) = { age = a; this }
  def setEmail(e: String) = { email = e; this }
  
  def build(): Person = Person(name, age, email)
}

new PersonBuilder()
  .setName("Alice")
  .setAge(30)
  .setEmail("alice@example.com")
  .build()

// Scala: Case class copy method (simpler)
val person1 = Person("Alice", 30, "alice@example.com")
val person2 = person1.copy(age = 31)  // Just one field
val person3 = person1.copy(name = "Bob", email = "bob@example.com")  // Multiple
```

### Strategy Pattern

```scala
// Define strategy interface
trait SortingStrategy {
  def sort[T: Ordering](items: List[T]): List[T]
}

// Concrete strategies
object BubbleSort extends SortingStrategy {
  def sort[T: Ordering](items: List[T]): List[T] = {
    // Bubble sort implementation
    items.sorted
  }
}

object QuickSort extends SortingStrategy {
  def sort[T: Ordering](items: List[T]): List[T] = {
    // Quick sort implementation
    items.sorted
  }
}

// Use strategy
class Sorter(strategy: SortingStrategy) {
  def execute[T: Ordering](items: List[T]): List[T] = {
    strategy.sort(items)
  }
}

// Scala: Pass function directly (simpler)
def sort[T](items: List[T], strategy: List[T] => List[T]): List[T] = {
  strategy(items)
}

sort(List(3, 1, 2), _.sorted)
sort(List(3, 1, 2), _.reverse)
```

### Observer Pattern

```scala
// Event bus
trait EventBus {
  type EventListener = Event => Unit
  
  private var listeners: List[EventListener] = List()
  
  def subscribe(listener: EventListener): Unit = {
    listeners = listeners :+ listener
  }
  
  def publish(event: Event): Unit = {
    listeners.foreach(_(event))
  }
}

// Events
sealed trait Event
case class UserLoggedIn(userId: String) extends Event
case class FileChanged(filename: String) extends Event

// Usage
val bus = new EventBus {}

bus.subscribe {
  case UserLoggedIn(id) => println(s"User $id logged in")
  case FileChanged(file) => println(s"File changed: $file")
}

bus.publish(UserLoggedIn("alice"))
bus.publish(FileChanged("config.txt"))
```

---

## Common Patterns & Anti-Patterns

### Pattern: Functional Error Handling

```scala
// ✓ Good: Chain operations with error handling
def process(data: String): Either[String, Int] = {
  for {
    num <- parseNumber(data).toRight("Invalid number")
    doubled <- if (num > 0) Right(num * 2) else Left("Must be positive")
    result <- validateResult(doubled)
  } yield result
}

// ❌ Bad: Manual error checking (imperative)
def processImperative(data: String): Either[String, Int] = {
  val parseResult = parseNumber(data)
  if (parseResult.isFailure) return Left("Invalid number")
  
  val num = parseResult.get
  if (num <= 0) return Left("Must be positive")
  
  val doubled = num * 2
  val validateResult = validate(doubled)
  if (validateResult.isFailure) return Left("Validation failed")
  
  Right(validateResult.get)
}
```

### Anti-Pattern: Excessive Mutability

```scala
// ❌ BAD: Mutable state everywhere
class Account {
  private var balance = 0.0  // Mutable
  
  def deposit(amount: Double): Unit = {
    balance = balance + amount  // Mutation
  }
  
  def withdraw(amount: Double): Unit = {
    balance = balance - amount  // Mutation
  }
}

// Problems:
// ├─ Thread-unsafe (multiple threads can corrupt balance)
// ├─ Hard to test (state changes everywhere)
// ├─ Hard to reason about (previous state lost)
// └─ Cannot parallelize

// ✓ GOOD: Immutable approach
case class Account(balance: Double) {
  def deposit(amount: Double): Account = 
    copy(balance = balance + amount)
  
  def withdraw(amount: Double): Account = 
    copy(balance = balance - amount)
}

// Benefits:
// ├─ Thread-safe (no mutation)
// ├─ Easy to test (predictable)
// ├─ Easy to reason about (immutable values)
// ├─ Can parallelize
// └─ Easy to undo (keep previous state)
```

### Pattern: Composable Functions

```scala
// ✓ Good: Compose small functions
val isAdult = (age: Int) => age >= 18
val hasValidEmail = (email: String) => email.contains("@")
val isApproved = (user: User) => user.status == "approved"

val canRegister = (user: User) => {
  isAdult(user.age) && hasValidEmail(user.email) && isApproved(user)
}

// ❌ Bad: Monolithic function
def canRegister(user: User): Boolean = {
  val isAdultCheck = user.age >= 18
  val hasValidEmailCheck = user.email.contains("@")
  val isApprovedCheck = user.status == "approved"
  isAdultCheck && hasValidEmailCheck && isApprovedCheck
}

// Issues:
// ├─ Hard to test individual parts
// ├─ Hard to reuse conditions
// ├─ Hard to combine differently
// └─ Mixing concerns
```

---

## Scala Ecosystem & Common Libraries

**Popular Libraries:**

```
Web Development:
├─ Play Framework (full-stack web framework)
├─ Akka HTTP (lightweight HTTP server)
└─ Finagle (functional RPC framework)

Data Processing:
├─ Apache Spark (distributed computing)
├─ Kafka (streaming platform)
└─ Scala Collections (built-in)

Testing:
├─ ScalaTest (comprehensive testing)
├─ Specs2 (BDD-style testing)
└─ Property-Based Testing (QuickCheck-style)

Functional Programming:
├─ Cats (functional abstractions)
├─ Scalaz (functional programming library)
└─ ZIO (effect type system)

Concurrency:
├─ Akka Actors (concurrent actors)
├─ Akka Streams (reactive streams)
└─ Futures/Promises (async operations)
```

---

**Last Updated**: December 2025
**Version**: 2.0
**Scope**: Comprehensive Scala Language Guide with Advanced Topics
**Contents**: 18+ chapters, theory, patterns, practical examples, Q&A
