# Perl Complete Notes & Theory

## Table of Contents
1. [Introduction & Overview](#introduction--overview)
2. [History & Evolution](#history--evolution)
3. [Language Fundamentals](#language-fundamentals)
4. [Data Types & Variables](#data-types--variables)
5. [Operators & Control Structures](#operators--control-structures)
6. [Subroutines & Functions](#subroutines--functions)
7. [Regular Expressions](#regular-expressions)
8. [File Operations](#file-operations)
9. [References & Data Structures](#references--data-structures)
10. [Object-Oriented Perl](#object-oriented-perl)
11. [Modules & CPAN](#modules--cpan)
12. [Advanced Concepts](#advanced-concepts)
13. [Best Practices](#best-practices)
14. [Interview Questions](#interview-questions)

---

## Introduction & Overview

### What is Perl?

**Perl** (Practical Extraction and Report Language) is a high-level, interpreted programming language designed for text processing, system administration, and general-purpose programming. Key characteristics:

```
┌─────────────────────────────────────┐
│      PERL CORE FEATURES             │
├─────────────────────────────────────┤
│ ✓ Interpreted language              │
│ ✓ Cross-platform (Unix, Windows)    │
│ ✓ Powerful regex support            │
│ ✓ Flexible syntax (TMTOWTDI)        │
│ ✓ Easy text processing              │
│ ✓ System administration tools       │
│ ✓ Web development (CGI, frameworks) │
│ ✓ Data transformation               │
│ ✓ Rapid development                 │
│ ✓ Large module ecosystem (CPAN)     │
└─────────────────────────────────────┘
```

### TMTOWTDI Philosophy

**"There's More Than One Way To Do It"** - Perl's design principle

```
Multiple Ways to Achieve Same Result:

Print String:
├─ print "Hello\n";
├─ print("Hello\n");
├─ print 'Hello', "\n";
├─ say "Hello";  (with use feature 'say')
└─ All valid and acceptable

This Flexibility:
├─ Powerful for experienced programmers
├─ Readable by those familiar with style
├─ Can be confusing for beginners
├─ Requires good coding standards
└─ Makes Perl expressive and concise
```

### Why Perl?

```
Problem Domains:
├─ Text processing (parsing, extraction)
├─ System administration (automation)
├─ Log file analysis (large datasets)
├─ Data transformation (ETL)
├─ Web development (older applications)
├─ Quick scripting (rapid prototyping)
└─ Bioinformatics (sequence analysis)

Advantages:
├─ Fast development
├─ Powerful regex
├─ Rich ecosystem (CPAN)
├─ Backward compatible
├─ Runs on any platform
└─ Large installed base
```

---

## History & Evolution

### Timeline

| Year | Version | Event | Impact |
|------|---------|-------|--------|
| **1987** | Perl 1 | First release by Larry Wall | System admin tool |
| **1991** | Perl 4 | Major release | Widely adopted |
| **1994** | Perl 5 | Revolutionary version | Modern Perl, OOP, modules |
| **1997** | Perl 5.004 | Standardized | Enterprise adoption |
| **2007** | Perl 5.10 | Say feature, regex improvements | Modernization |
| **2014** | Perl 5.20 | Subroutine signatures | Better syntax |
| **2023** | Perl 5.38 | Current stable | Still actively developed |
| **Future** | Perl 7 | (In planning) | Major overhaul |

### Perl Philosophy

```
Evolution of Style:

Perl 4 (1991):
└─ Procedural style
└─ Simple scripts
└─ Global variables

Perl 5 (1994):
├─ Object-oriented programming
├─ References and data structures
├─ Modules and packages
├─ Lexical variables
└─ Modern enterprise use

Modern Perl (2010+):
├─ Best practices established
├─ Web frameworks (Mojolicious, Catalyst)
├─ Type systems (Moose)
├─ Async/concurrency
└─ Cloud-native applications
```

---

## Language Fundamentals

### Hello World

```perl
#!/usr/bin/perl
# Simplest Perl script

print "Hello, World!\n";
```

### Shebang & Execution

```bash
# Make script executable
chmod +x hello.pl

# Run directly
./hello.pl

# Or run with perl explicitly
perl hello.pl

# First line tells system how to run script
#!/usr/bin/perl
```

### Comments

```perl
# Single line comment

=pod
Multi-line comment
using POD (Plain Old Documentation)
format
=cut

# Alternative multi-line with =begin/=end
=begin comment

This is also a comment
Multiple lines

=end comment
```

### Basic Syntax Rules

```perl
# Statements end with semicolon
print "Hello";

# Case-sensitive
$var = 5;      # Different from $Var or $VAR
my $local = 5; # Different from local or my

# Whitespace mostly ignored
print("Hello");
print  (  "Hello"  ) ;  # Both valid

# Quotes matter
"double quoted"  # Variable interpolation
'single quoted'  # No interpolation (literal)

# No required indentation (but good practice)
if ($x > 0) {
    print "positive\n";
}
```

---

## Data Types & Variables

### Scalars ($)

```perl
# String scalar
my $name = "Alice";
my $greeting = 'Hello';

# Numeric scalar
my $count = 42;
my $pi = 3.14159;

# Underscore in numbers (for readability)
my $million = 1_000_000;
my $binary = 0b1010;
my $hex = 0xFF;
my $octal = 0755;

# Undefined scalar
my $undefined;  # undefined value
my $null = undef;

# References (scalar containing reference)
my $ref = \$name;
my $array_ref = [1, 2, 3];
my $hash_ref = { key => 'value' };
```

### Arrays (@)

```perl
# Array declaration
my @numbers = (1, 2, 3, 4, 5);
my @words = qw(apple banana cherry);  # qw = quote words
my @range = (1..10);  # Range operator

# Accessing elements (0-indexed)
my $first = $numbers[0];   # 1
my $last = $numbers[-1];   # 5 (negative index)

# Modifying arrays
push @numbers, 6;           # Add to end
my $popped = pop @numbers;  # Remove from end
unshift @numbers, 0;        # Add to beginning
my $shifted = shift @numbers; # Remove from beginning

# Array slices
my @subset = @numbers[1..3];  # Elements 1-3
my @scattered = @numbers[0,2,4]; # Specific indices

# Array length
my $len = scalar @numbers;
my $last_idx = $#numbers;  # Last index

# Array operations
my @combined = (@array1, @array2);
my $joined = join(",", @array);  # Join with separator
my @split = split(",", "a,b,c");  # Split by separator
```

### Hashes (%)

```perl
# Hash declaration
my %person = (
    name => "Alice",
    age => 30,
    city => "NYC"
);

# Alternative syntax
my %person = (
    name => "Alice",
    age => 30
);

# Using qw (note: odd number of elements!)
my %codes = qw(A alarm B bravo C charlie);

# Accessing values (scalar context)
my $name = $person{name};   # Alice
my $age = $person{age};     # 30

# Modifying hash
$person{phone} = "555-1234";  # Add/update
delete $person{city};          # Remove key

# Check if key exists
if (exists $person{name}) {
    print "Name exists\n";
}

# Get all keys/values
my @keys = keys %person;      # (name, age, phone)
my @values = values %person;  # (Alice, 30, 555-1234)
my @pairs = each %person;     # One key-value pair

# Iterate hash
while (my ($key, $value) = each %person) {
    print "$key: $value\n";
}
```

### String Interpolation

```perl
# Double quotes: interpolate variables
my $name = "Alice";
print "Hello, $name\n";  # Hello, Alice

# Single quotes: no interpolation
print 'Hello, $name\n';  # Hello, $name\n (literal)

# Escape interpolation with backslash
print "Hello, \$name\n";  # Hello, $name

# Complex interpolation
my @items = qw(apple banana);
print "Items: @items\n";  # Items: apple banana

# Interpolate function calls
print "Current dir: " . `pwd` . "\n";

# Escape sequences
print "Tab:\t Column aligned\n";
print "Newline:\n";
print "Quote: \"hello\"\n";
print "Backslash: \\\n";
```

---

## Operators & Control Structures

### Operators

#### Arithmetic

```perl
my $sum = 5 + 3;        # 8
my $diff = 5 - 3;       # 2
my $prod = 5 * 3;       # 15
my $div = 15 / 3;       # 5
my $mod = 17 % 5;       # 2 (modulo)
my $exp = 2 ** 3;       # 8 (exponent)

# Assignment with operation
my $x = 5;
$x += 3;    # $x = 8
$x -= 2;    # $x = 6
$x *= 2;    # $x = 12
$x /= 3;    # $x = 4
$x %= 3;    # $x = 1
```

#### String Operators

```perl
# Concatenation
my $greeting = "Hello, " . "World";

# Repetition
my $dashes = "-" x 10;  # ----------

# String comparison
if ($name eq "Alice") { }     # eq = string equal
if ($name ne "Bob") { }       # ne = string not equal
if ($str lt "zebra") { }      # lt = string less than
if ($str gt "apple") { }      # gt = string greater than
if ($str le "zoo") { }        # le = string less or equal
if ($str ge "aaa") { }        # ge = string greater or equal
if ($str cmp $other) { }      # cmp = string compare (-1, 0, 1)
```

#### Numeric Comparison

```perl
if ($x == 5) { }      # == equals
if ($x != 5) { }      # != not equal
if ($x < 5) { }       # < less than
if ($x > 5) { }       # > greater than
if ($x <= 5) { }      # <= less or equal
if ($x >= 5) { }      # >= greater or equal
if ($x <=> 5) { }     # <=> spaceship (-1, 0, 1)
```

#### Logical Operators

```perl
# AND operators
if ($x > 0 && $x < 10) { }    # && = logical AND
if ($x > 0 and $x < 10) { }   # and = lower precedence

# OR operators
if ($x < 0 || $x > 10) { }    # || = logical OR
if ($x < 0 or $x > 10) { }    # or = lower precedence

# NOT operator
if (!$flag) { }               # ! = logical NOT
if (not $flag) { }            # not = lower precedence

# Ternary operator
my $status = ($age >= 18) ? "adult" : "minor";
```

### Control Structures

#### if/elsif/else

```perl
if ($age < 13) {
    print "Child\n";
} elsif ($age < 18) {
    print "Teen\n";
} elsif ($age < 65) {
    print "Adult\n";
} else {
    print "Senior\n";
}

# Statement modifier
print "Positive\n" if $x > 0;
print "Negative\n" unless $x > 0;
```

#### while/until loops

```perl
# while loop
while ($count < 10) {
    print "$count\n";
    $count++;
}

# until loop (opposite of while)
until ($count >= 10) {
    print "$count\n";
    $count++;
}

# do-while (execute at least once)
do {
    print "$count\n";
    $count++;
} while ($count < 10);

# Loop control
while ($x < 100) {
    next if $x % 2 == 0;    # Skip rest of iteration
    last if $x > 50;        # Exit loop
    redo if $x < 0;         # Redo without re-evaluating condition
    print "$x\n";
    $x++;
}
```

#### for loops

```perl
# C-style for loop
for (my $i = 0; $i < 10; $i++) {
    print "$i\n";
}

# foreach loop (preferred)
foreach my $item (@array) {
    print "$item\n";
}

# foreach with hash
foreach my $key (keys %hash) {
    print "$key: $hash{$key}\n";
}

# Simplified foreach (uses $_)
foreach (@array) {
    print "$_\n";
}

# Range iteration
foreach my $i (1..10) {
    print "$i\n";
}

# Reverse iteration
foreach my $i (reverse 1..10) {
    print "$i\n";
}
```

---

## Subroutines & Functions

### Basic Subroutine

```perl
# Subroutine definition
sub greet {
    print "Hello!\n";
}

# Call subroutine
greet();
greet;  # Parentheses optional if no args

# With parameters
sub add {
    my ($a, $b) = @_;  # @_ contains all arguments
    return $a + $b;
}

my $sum = add(5, 3);  # 8

# Multiple return values
sub get_stats {
    my @numbers = @_;
    my $count = scalar @numbers;
    my $sum = 0;
    $sum += $_ foreach @numbers;
    my $avg = $sum / $count;
    return ($count, $sum, $avg);
}

my ($count, $total, $average) = get_stats(1..10);
```

### Lexical vs Package Variables

```perl
# Lexical variable (my) - block scope
sub lexical_demo {
    my $local = "Inside function";
    if (1) {
        my $inner = "Inside if";
        print "$local\n";   # OK
    }
    # print "$inner\n";     # ERROR - out of scope
}

# Package variable (our) - package scope
our $global = "Package scope";

sub can_access {
    print "$global\n";  # OK - accessible
}

# Dynamic variable (local) - avoid in new code
local $old_style = "deprecated";  # Old Perl style
```

### Prototypes & Signatures

```perl
# Old-style prototypes (compile-time)
sub my_length($) {      # Expects exactly one scalar
    my $str = shift;
    return length($str);
}

# Modern subroutine signatures (Perl 5.20+)
use feature 'signatures';

sub add($a, $b) {
    return $a + $b;
}

sub greet($name, $greeting = "Hello") {
    print "$greeting, $name!\n";
}

greet("Alice");
greet("Bob", "Hi");
```

---

## Regular Expressions

### Theory: Pattern Matching

```
Regular Expressions (Regex):
└─ Powerful text pattern matching
└─ Used for validation, extraction, replacement
└─ Perl has native regex support
└─ Can be complex but worth learning
```

### Basic Regex

```perl
# Match operator
if ($string =~ /pattern/) {
    print "Pattern found\n";
}

# Not match operator
if ($string !~ /pattern/) {
    print "Pattern not found\n";
}

# Case insensitive match
if ($string =~ /pattern/i) {
    print "Found (ignoring case)\n";
}

# Global match (all occurrences)
my @matches = $string =~ /\w+/g;  # Extract all words

# Substitution
$string =~ s/old/new/;       # Replace first occurrence
$string =~ s/old/new/g;      # Replace all occurrences
$string =~ s/old/new/gi;     # Replace all (case-insensitive)

# Count substitutions
my $count = $string =~ s/pattern/replacement/g;
```

### Character Classes

```perl
# Basic character classes
/a.c/           # . matches any character
/[abc]/         # Character class: a, b, or c
/[^abc]/        # Negated class: anything except a, b, c
/[a-z]/         # Range: lowercase letters
/[A-Z0-9]/      # Uppercase or digits
/[a-zA-Z0-9_]/  # Alphanumeric or underscore

# Predefined character classes
/\d/            # Digit [0-9]
/\D/            # Non-digit
/\w/            # Word character [a-zA-Z0-9_]
/\W/            # Non-word
/\s/            # Whitespace
/\S/            # Non-whitespace
```

### Quantifiers

```perl
# Quantifiers (how many times pattern repeats)
/a/             # Exactly one 'a'
/a*/            # Zero or more 'a's
/a+/            # One or more 'a's
/a?/            # Zero or one 'a'
/a{3}/          # Exactly 3 'a's
/a{3,5}/        # 3 to 5 'a's
/a{3,}/         # 3 or more 'a's
/a{,5}/         # Up to 5 'a's

# Greedy vs non-greedy
/a+/            # Greedy (match as much as possible)
/a+?/           # Non-greedy (match as little as possible)
/a.*b/          # Greedy: from first a to last b
/a.*?b/         # Non-greedy: from first a to first b
```

### Capturing Groups

```perl
# Capturing groups with parentheses
if ("John Smith" =~ /(\w+)\s(\w+)/) {
    my $first = $1;   # John
    my $last = $2;    # Smith
    print "$first, $last\n";
}

# Multiple matches
my @words = "apple banana cherry" =~ /(\w+)/g;

# Named groups (Perl 5.10+)
if ("test@example.com" =~ /(?<user>\w+)\@(?<domain>.+)/) {
    print $+{user}, "\n";      # test
    print $+{domain}, "\n";    # example.com
}

# Non-capturing group (just group, don't capture)
if ("test123" =~ /(?:\w+)(\d+)/) {
    print $1, "\n";  # 123 (second group)
}
```

### Common Regex Examples

```perl
# Email validation
if ($email =~ /^[\w.-]+\@[\w.-]+\.\w+$/) {
    print "Valid email\n";
}

# Phone number
if ($phone =~ /^\d{3}-\d{3}-\d{4}$/) {
    print "Valid format: 555-123-4567\n";
}

# Extract data
my $log = "ERROR: File not found at line 42";
if ($log =~ /(\w+):\s(.+)\sat\sline\s(\d+)/) {
    my ($level, $msg, $line) = ($1, $2, $3);
}

# URL parsing
if ($url =~ m|^https?://([^/]+)(/.*)?$|) {
    my $host = $1;
    my $path = $2 // "/";
}

# Split by regex
my @words = split(/\s+/, $text);  # Split by whitespace
my @parts = split(/[,;:]/, $csv);  # Split by multiple delimiters
```

---

## File Operations

### File Handles & Basic I/O

```perl
# Open for reading
open(my $fh, '<', 'filename.txt') 
    or die "Cannot open: $!\n";

# Open for writing (overwrite)
open(my $fh, '>', 'filename.txt') 
    or die "Cannot open: $!\n";

# Open for appending
open(my $fh, '>>', 'filename.txt') 
    or die "Cannot open: $!\n";

# Open for read-write
open(my $fh, '+<', 'filename.txt') 
    or die "Cannot open: $!\n";

# Reading
my $line = <$fh>;           # Read one line
my @lines = <$fh>;          # Read all lines into array
while (my $line = <$fh>) {  # Read line by line
    chomp($line);           # Remove newline
    print "$line\n";
}

# Writing
print $fh "Hello, World!\n";
printf $fh "Number: %d\n", 42;

# Close file
close($fh) or die "Cannot close: $!\n";
```

### File Tests

```perl
# File existence and type tests
if (-e $filename) { print "File exists\n"; }
if (-f $filename) { print "Regular file\n"; }
if (-d $dirname) { print "Directory\n"; }
if (-l $path) { print "Symbolic link\n"; }

# File permissions
if (-r $filename) { print "Readable\n"; }
if (-w $filename) { print "Writable\n"; }
if (-x $filename) { print "Executable\n"; }

# File size
if (-s $filename) { print "File has size\n"; }
my $size = -s $filename;  # File size in bytes

# Modification time
my $mtime = -M $filename;  # Days since modification
```

### Directory Operations

```perl
# List directory
opendir(my $dh, '.') or die "Cannot open: $!\n";
my @files = readdir($dh);
closedir($dh);

# Using glob
my @txt_files = glob("*.txt");
my @all_files = glob("*");

# Create/remove directories
mkdir("new_dir") or die "Cannot create: $!\n";
rmdir("empty_dir") or die "Cannot remove: $!\n";

# Change directory
chdir("/tmp") or die "Cannot chdir: $!\n";
my $current = `pwd`;  # Get current directory
```

---

## References & Data Structures

### References

```perl
# Creating references
my $scalar_ref = \$scalar;
my $array_ref = \@array;
my $hash_ref = \%hash;
my $sub_ref = \&subroutine;

# Dereferencing
my $value = $$scalar_ref;           # Dereference scalar
my @copy = @$array_ref;             # Dereference array
my %copy = %$hash_ref;              # Dereference hash
$sub_ref->();                       # Call subroutine ref

# Arrow dereference (cleaner)
my $element = $array_ref->[0];
my $value = $hash_ref->{key};
my $sub_ref->($arg1, $arg2);

# Anonymous arrays and hashes
my $aref = [1, 2, 3];           # Anonymous array
my $href = {name => "Alice"};   # Anonymous hash

# Access anonymous structures
print $aref->[0], "\n";         # 1
print $href->{name}, "\n";      # Alice
```

### Complex Data Structures

```perl
# Array of hashes
my @people = (
    { name => "Alice", age => 30 },
    { name => "Bob", age => 25 },
    { name => "Charlie", age => 35 }
);

foreach my $person (@people) {
    print $person->{name}, " is ", $person->{age}, "\n";
}

# Hash of arrays
my %teams = (
    engineering => ["Alice", "Bob", "Charlie"],
    sales => ["David", "Eve"],
    marketing => ["Frank"]
);

foreach my $member (@{$teams{engineering}}) {
    print "$member\n";
}

# Hash of hashes
my %config = (
    database => {
        host => "localhost",
        port => 5432,
        user => "admin"
    },
    cache => {
        host => "localhost",
        port => 6379
    }
);

print $config{database}{host}, "\n";  # localhost
```

---

## Object-Oriented Perl

### Basic OOP

```perl
# Package definition
package Person;

# Constructor
sub new {
    my ($class, $name, $age) = @_;
    my $self = {
        name => $name,
        age => $age
    };
    bless $self, $class;
    return $self;
}

# Method
sub greet {
    my $self = shift;
    print "Hello, I am $self->{name}\n";
}

# Destructor
sub DESTROY {
    my $self = shift;
    print "Destroying $self->{name}\n";
}

# Usage
package main;

my $person = Person->new("Alice", 30);
$person->greet();

# Perl OOP is just syntax over hashes and packages
```

### Inheritance

```perl
package Animal;

sub new {
    my ($class, $name) = @_;
    my $self = { name => $name };
    bless $self, $class;
}

sub speak {
    my $self = shift;
    print "$self->{name} makes a sound\n";
}

# Inheritance
package Dog;
our @ISA = ('Animal');  # Inheritance

sub speak {
    my $self = shift;
    print "$self->{name} barks\n";
}

package main;
my $dog = Dog->new("Buddy");
$dog->speak();  # Buddy barks
```

### Modern OOP with Moose

```perl
use Moose;

package Person;
use Moose;

has 'name' => (is => 'rw', isa => 'Str');
has 'age' => (is => 'rw', isa => 'Int');

sub greet {
    my $self = shift;
    print "Hello, I am ", $self->name, "\n";
}

__PACKAGE__->meta->make_immutable;

package main;
my $person = Person->new(name => "Alice", age => 30);
$person->greet();
```

---

## Modules & CPAN

### Using Modules

```perl
# Use module
use strict;          # Require variable declaration
use warnings;        # Warn about problematic code
use Data::Dumper;    # Pretty-print data structures
use File::Basename;  # File manipulation
use Time::Local;     # Time functions

# Import specific functions
use List::Util qw(sum max min);
my $total = sum(@numbers);

# No import (can use fully qualified names)
use File::Copy ();
File::Copy::copy("src.txt", "dst.txt");

# Import into different namespace
use List::Util max => { -as => 'maximum' };
my $largest = maximum(@numbers);
```

### Creating Modules

```perl
# File: MyModule.pm
package MyModule;

use strict;
use warnings;

sub greet {
    my ($name) = @_;
    return "Hello, $name!";
}

sub calculate {
    my ($a, $b) = @_;
    return $a + $b;
}

# Export list
our @EXPORT = qw(greet calculate);
our @EXPORT_OK = qw(internal_func);

1;  # Return true to signal successful load

# Using the module
use MyModule qw(greet);
print greet("Alice"), "\n";  # Hello, Alice!
```

### Popular CPAN Modules

```perl
# Web development
use Mojolicious;        # Web framework
use Catalyst;           # Enterprise framework
use Plack;              # PSGI server

# Database
use DBI;                # Database interface
use DBIx::Class;        # ORM
use Mojo::Pg;           # PostgreSQL driver

# Text processing
use Text::CSV;          # CSV parsing
use JSON;               # JSON encode/decode
use YAML;               # YAML processing

# Testing
use Test::More;         # Testing framework
use Test::Class;        # OOP testing
use Test::Exception;    # Exception testing

# Utilities
use List::Util;         # List operations
use File::Slurp;        # Read entire file
use DateTime;           # Date/time handling
```

---

## Advanced Concepts

### Context Awareness

```perl
# Perl is context-sensitive - behavior changes based on context

# Scalar context - single value expected
my $scalar = @array;           # Returns array length (5)
my $first = (1, 2, 3);         # Returns last value (3)

# List context - multiple values expected
my @list = (1, 2, 3);          # Gets all values
my ($x, $y, $z) = (1, 2, 3);   # Distributes values
my ($a, $b) = (1, 2, 3);       # $a=1, $b=2, ignores 3

# Boolean context
if (@array) { }                # True if array has elements
if ($scalar) { }               # True if non-zero/non-empty

# Void context - return value ignored
function_call();               # Result not used

# Examples of context-aware functions
my $count = keys %hash;        # Scalar context: returns count
my @keys = keys %hash;         # List context: returns all keys

# Wantarray to detect context
sub context_demo {
    if (wantarray) {
        return (1, 2, 3);      # List context
    } else {
        return 42;             # Scalar context
    }
}

my @list = context_demo();     # Returns (1, 2, 3)
my $val = context_demo();      # Returns 42
```

### Closures & Lexical Scope

```perl
# Closures: functions that remember their environment

# Simple closure
sub make_counter {
    my $count = 0;
    return sub {
        return ++$count;
    };
}

my $counter = make_counter();
print $counter->(), "\n";      # 1
print $counter->(), "\n";      # 2
print $counter->(), "\n";      # 3

# Each closure has its own copy of $count
my $another = make_counter();
print $another->(), "\n";      # 1 (independent counter)

# Practical example: function factory
sub make_multiplier {
    my $factor = shift;
    return sub {
        my $value = shift;
        return $value * $factor;
    };
}

my $double = make_multiplier(2);
my $triple = make_multiplier(3);

print $double->(5), "\n";      # 10
print $triple->(5), "\n";      # 15

# Closures in callbacks
my @processors = ();
foreach my $num (1..5) {
    push @processors, sub { return $_[0] * $num; };
}

# Each closure remembers its $num value
print $processors[0]->(10), "\n";  # 10
print $processors[4]->(10), "\n";  # 50
```

### Symbolic References & Dynamic Code

```perl
# Symbolic references: variable names as strings
my $var_name = "message";
$$var_name = "Hello";          # Creates $message
print $$var_name, "\n";        # Hello

# Hash references (safer alternative)
my %vars = ();
$vars{message} = "Hello";
print $vars{message}, "\n";    # Hello

# Symbol table manipulation
our $global = "I exist";
my $name = "global";
print $$name, "\n";            # I exist

# Dynamic subroutine calls
my $sub_name = "greet";
&$sub_name();                  # Calls &greet()
$sub_name->("Alice");          # With arguments

# Code generation with eval
my $code = q{
    sub dynamic {
        print "I was created dynamically\n";
    }
};
eval $code;                    # Create subroutine
dynamic();                     # Call it

# Caution: eval can be security risk with untrusted input
# Use only with trusted strings
```

### Prototypes & Overloading

```perl
# Subroutine prototypes (compile-time hints)
sub get_first($) {             # Expects one scalar
    my $array = shift;
    return $array->[0];
}

sub add_numbers($$) {          # Expects two scalars
    my ($a, $b) = @_;
    return $a + $b;
}

# Prototype symbols
# $ = scalar, @ = array, % = hash
# & = subroutine ref, * = typeglob
# ; separates required from optional args

sub flexible($$;$$) {          # 2 required, 2 optional
    my ($req1, $req2, $opt1, $opt2) = @_;
}

# Overloading operators
package Vector;
use overload
    '+' => \&add,
    '*' => \&scale,
    '""' => \&stringify;

sub new {
    my ($class, $x, $y) = @_;
    return bless {x => $x, y => $y}, $class;
}

sub add {
    my ($self, $other) = @_;
    return Vector->new(
        $self->{x} + $other->{x},
        $self->{y} + $other->{y}
    );
}

sub scale {
    my ($self, $factor) = @_;
    return Vector->new(
        $self->{x} * $factor,
        $self->{y} * $factor
    );
}

sub stringify {
    my $self = shift;
    return "($self->{x}, $self->{y})";
}

# Usage
package main;
my $v1 = Vector->new(1, 2);
my $v2 = Vector->new(3, 4);
my $v3 = $v1 + $v2;            # Calls overloaded +
my $v4 = $v1 * 2;              # Calls overloaded *
print "$v3\n";                 # (4, 6)
```

### Tied Variables

```perl
# Tied variables: custom behavior for variable access

package MyTieClass;

sub TIESCALAR {
    my ($class, $initial) = @_;
    my $self = { value => $initial, access_count => 0 };
    return bless $self, $class;
}

sub FETCH {
    my $self = shift;
    $self->{access_count}++;
    return $self->{value};
}

sub STORE {
    my ($self, $value) = @_;
    print "Setting to $value\n";
    $self->{value} = $value;
}

sub TIEHASH {
    my $class = shift;
    return bless {}, $class;
}

sub FETCH {
    my ($self, $key) = @_;
    print "Fetching $key\n";
    return $self->{$key};
}

sub STORE {
    my ($self, $key, $value) = @_;
    print "Storing $key => $value\n";
    $self->{$key} = $value;
}

# Usage
package main;
tie my $var, 'MyTieClass', 'initial';
print $var, "\n";              # Calls FETCH
$var = 'new';                  # Calls STORE

# Practical use: auto-vivifying hashes, logging access
```

### Special Variables

```perl
# Special variables in Perl

# Input/Output
$_          # Default variable (used in many functions)
$|          # Autoflush output buffer
$\          # Output record separator
$/          # Input record separator (usually "\n")

# Pattern matching
$1, $2, ... # Captured groups from regex
$&          # Entire matched string
$`          # String before match
$'          # String after match
$+          # Last captured group

# File and process info
$!          # System error message
$@          # Eval error message
$0          # Program name
$?          # Child process exit status
$$          # Process ID
$ARGV       # Current file in <>

# Example usage
if ($string =~ /(\w+)\@(\w+\.\w+)/) {
    my $user = $1;
    my $domain = $2;
    print "Before: $`\n";
    print "After: $'\n";
    print "Whole: $&\n";
}

# Iterator with $_
foreach (@array) {
    print;                     # Prints $_
    s/old/new/;               # Modifies $_
    chomp;                     # Removes newline from $_
}

# Safe alternatives (avoid most special variables in new code)
foreach my $item (@array) {
    print $item;
    # More readable
}
```

### File Test Operators

```perl
# Complete file test operators
-e  # File exists
-f  # Regular file
-d  # Directory
-l  # Symbolic link
-p  # Named pipe (FIFO)
-S  # Socket
-b  # Block device
-c  # Character device
-u  # Setuid bit set
-g  # Setgid bit set
-k  # Sticky bit set
-r  # Readable
-w  # Writable
-x  # Executable
-o  # Owned by effective uid
-O  # Owned by real uid
-s  # Non-zero file size (returns size)
-z  # Zero file size
-t  # Opened to tty
-T  # Text file
-B  # Binary file
-M  # Modification time (days since)
-A  # Access time (days since)
-C  # Change time (days since)

# Examples
if (-r $file) { print "Readable\n"; }
if (-T $file) { print "Text file\n"; }
my $size = -s $file;                  # Get size
if (-M $file > 7) { print "Old\n"; }  # Older than 7 days
```

### Sorting & List Operations

```perl
# Default sort (ASCII order)
my @sorted = sort @words;

# Custom sort (numeric)
my @nums = sort { $a <=> $b } @unsorted;

# Reverse sort
my @reverse = sort { $b <=> $a } @nums;

# String sort (case-insensitive)
my @case_insensitive = sort { lc($a) cmp lc($b) } @words;

# Sort by multiple criteria
my @people = (
    {name => "Alice", age => 30},
    {name => "Bob", age => 25},
    {name => "Charlie", age => 30}
);

# By age, then by name
my @sorted = sort {
    $a->{age} <=> $b->{age} || $a->{name} cmp $b->{name}
} @people;

# Using Sort::Key for complex sorts
use Sort::Key qw(keysort);
my @by_key = keysort { $_->{id} } @people;

# List operations
use List::Util qw(sum max min first);
my $total = sum @numbers;
my $maximum = max @numbers;
my $minimum = min @numbers;
my $first_even = first { $_ % 2 == 0 } @numbers;

# List::MoreUtils
use List::MoreUtils qw(uniq any all);
my @unique = uniq @list;              # Remove duplicates
if (any { $_ > 100 } @numbers) { }    # Check if any > 100
if (all { $_ > 0 } @numbers) { }      # Check if all > 0

# Map and grep
my @doubled = map { $_ * 2 } @numbers;
my @evens = grep { $_ % 2 == 0 } @numbers;
my @uppercased = map { uc($_) } @words;
```

### Exception Handling

```perl
# Try-catch with eval

# String eval (caution with untrusted input)
eval {
    risky_function();
    another_risky();
};
if ($@) {
    warn "Error: $@\n";
}

# Try-Tiny module (cleaner)
use Try::Tiny;

try {
    dangerous_operation();
} catch {
    warn "Caught error: $_\n";
} finally {
    print "Always runs\n";
};

# Custom exceptions with die
sub validate_email {
    my ($email) = @_;
    die "Email required\n" unless $email;
    die "Invalid format\n" unless $email =~ /@/;
    return 1;
}

eval {
    validate_email($user_input);
};
if ($@) {
    if ($@ =~ /Email required/) {
        # Handle missing email
    } elsif ($@ =~ /Invalid format/) {
        # Handle bad format
    }
}

# Exception objects
package MyException;
sub new {
    my ($class, $message) = @_;
    return bless {message => $message}, $class;
}

# Usage
eval {
    die MyException->new("Something went wrong");
};
if ($@) {
    if (ref($@) eq 'MyException') {
        print "Got exception: ", $@->{message}, "\n";
    }
}
```

---

## Best Practices

### Coding Standards

```perl
# Always use strict and warnings
use strict;
use warnings;

# Declare variables with my
my $name = "Alice";     # Lexical variable
our $global = "global"; # Package variable
# Avoid: $variable without declaration

# Meaningful variable names
my $customer_name = "Alice";    # Good
my $cn = "Alice";               # Avoid
my $x = "Alice";                # Very bad

# Comments for complex logic
# Regular expression to validate email
if ($email =~ /^[\w.-]+\@[\w.-]+\.\w+$/) {
    # Store valid email
    $valid_emails{$email}++;
}
```

### Error Handling

```perl
# Check for errors
open(my $fh, '<', 'file.txt') 
    or die "Cannot open file: $!\n";

# Try-catch pattern (using eval)
eval {
    my $result = risky_operation();
    process($result);
};
if ($@) {
    warn "Error occurred: $@\n";
    # Handle error
}

# Return error codes
sub validate {
    my ($input) = @_;
    return 1 if is_valid($input);
    return 0;
}

if (!validate($data)) {
    die "Invalid data\n";
}
```

### Performance Tips

```perl
# Use proper data structures
my %lookup = map { $_ => 1 } @list;  # Hash for O(1) lookup
if (exists $lookup{$item}) { }       # Fast

# Avoid repeated regex compilation
my $regex = qr/pattern/;  # Compile once
if ($string =~ $regex) { }           # Reuse

# Efficient string operations
my $text = join("", @parts);         # Better than concatenation
my @lines = split(/\n/, $content);   # Good

# Use references for large data
sub process {
    my ($array_ref) = @_;  # Pass reference
    foreach my $item (@$array_ref) {
        # Process
    }
}
```

### Testing Best Practices

```perl
# Test file: t/my_test.t
use Test::More tests => 5;
use MyModule qw(add greet);

# Test scalar return
is(add(2, 3), 5, "Add two numbers");

# Test string return
is(greet("Alice"), "Hello, Alice", "Greeting");

# Test boolean
ok($result, "Result is true");

# Test array/hash (deep comparison)
is_deeply([1, 2, 3], [1, 2, 3], "Arrays match");

# Test regex
like("test123", qr/\d+/, "Contains digits");
```

---

## Interview Questions

### Basic Level (Foundation Understanding)

**Q1: What is Perl and what is it used for?**

A: Perl (Practical Extraction and Report Language) is an interpreted programming language designed for text processing, system administration, and general-purpose programming. 

Primary use cases:
- Text processing and regex operations
- System administration automation
- Log file analysis and reporting
- Data transformation and ETL
- Web development (CGI, older applications)
- Bioinformatics and data science

Key strengths: powerful regex support, CPAN ecosystem (250,000+ modules), rapid development, and cross-platform compatibility.

**Q2: What does the shebang line do and how do you use it?**

A: The shebang line (#!/usr/bin/perl) at the top tells Unix/Linux which interpreter to execute the script with.

```perl
#!/usr/bin/perl
use strict;
use warnings;

print "Hello, World!\n";
```

Usage:
```bash
chmod +x script.pl     # Make executable
./script.pl            # Execute directly (uses shebang)
perl script.pl         # Or explicitly call perl
```

The shebang is platform-specific. On Windows, it's often ignored unless using WSL or Git Bash.

**Q3: What's the difference between single and double quotes in Perl?**

A: Both are string literals but have different interpolation behavior:

```perl
# Double quotes - interpolate variables and escape sequences
my $name = "Alice";
print "Hello, $name\n";     # Hello, Alice
print "Tab:\tSeparated\n";  # Tab:    Separated

# Single quotes - literal strings (no interpolation)
print 'Hello, $name\n';     # Hello, $name\n (literal)
print 'No tab: \t here';    # No tab: \t here (literal)

# Escape in double quotes
print "Cost: \$100\n";      # Cost: $100
print "Path: C:\\Users\n";  # Path: C:\Users

# qw() for word lists
my @words = qw(apple banana cherry);  # No quotes needed
my @fields = split(/,/, "a,b,c");    # Regex delimiter
```

**Q4: Explain the sigils ($, @, %) and their meaning.**

A: Sigils denote variable types in Perl:

```perl
# $ - Scalar (single value)
my $age = 25;              # String or number
my $ref = \@array;         # Reference
$array[0];                 # Scalar element of array

# @ - Array (ordered list)
my @colors = qw(red green blue);
my $first = $colors[0];    # Scalar element (note: $, not @)
push @colors, "yellow";    # @ when accessing whole array

# % - Hash (key-value pairs)
my %person = (name => "Alice", age => 30);
my $name = $person{name};  # Scalar value from hash
my @keys = keys %person;   # List of keys

# The sigil changes based on context:
@array[1,2,3];             # @array = array slice (returns list)
@array{$key1, $key2};      # @array = hash slice (returns list)
```

**Q5: What is CPAN and how do you use modules from it?**

A: CPAN (Comprehensive Perl Archive Network) is a repository of reusable Perl modules.

```perl
# Using CPAN modules
use strict;
use warnings;
use DateTime;              # Date/time
use JSON;                  # JSON parsing
use DBI;                   # Database interface
use LWP::UserAgent;        # HTTP requests

# Installing modules
cpan install DateTime      # From command line
perl -MCPAN -e 'install DateTime'  # Programmatically

# Using specific functions
use List::Util qw(sum max min);
my $total = sum(@numbers);
my $largest = max(@numbers);

# Without importing
use Data::Dumper ();
print Data::Dumper::Dumper(\%hash);
```

**Q6: What is the difference between my, our, and local?**

A: These create variables with different scopes:

```perl
# my - Lexical scope (block-local, MODERN)
{
    my $x = 1;
    print $x;      # OK
}
# print $x;        # ERROR - out of scope

# our - Package scope (entire package)
our $global = "package level";
sub func1 { print $global; }   # OK
sub func2 { print $global; }   # OK

# local - Dynamic scope (OLD, avoid in new code)
our $value = "original";
{
    local $value = "temporary";
    print $value;  # "temporary"
}
print $value;      # "original" - restored

# Best practices: Use my for almost everything
my $count = 0;          # Excellent
our $DEBUG = 0;         # For package-wide flags
# Avoid local - too confusing
```

### Intermediate Level (Practical Knowledge)

**Q7: Explain how regular expressions work in Perl with examples.**

A: Regular expressions use pattern matching with capture groups and substitutions.

```perl
# Basic matching
if ($email =~ /\w+\@\w+\.\w+/) {
    print "Valid email format\n";
}

# Capture groups
if ("John Smith" =~ /(\w+)\s+(\w+)/) {
    my $first = $1;    # John
    my $last = $2;     # Smith
}

# Modifiers
if ($text =~ /pattern/i) { }    # Case-insensitive
while ($text =~ /\w+/g) { }     # Global (all matches)
$text =~ s/old/new/;            # Substitute first
$text =~ s/old/new/g;           # Substitute all
$text =~ s/old/new/gi;          # Substitute all (case-insensitive)

# Character classes
/[aeiou]/       # Vowel
/[^0-9]/        # Non-digit
/[a-z]/         # Lowercase
/\d/            # Digit [0-9]
/\w/            # Word char [a-zA-Z0-9_]
/\s/            # Whitespace

# Quantifiers
/a?/            # Zero or one
/a*/            # Zero or more
/a+/            # One or more
/a{3}/          # Exactly 3
/a{3,5}/        # 3 to 5

# Anchors
/^start/        # Beginning of string
/end$/          # End of string
/\bword\b/      # Word boundary

# Pre-compile for efficiency
my $regex = qr/pattern/;
while (<$fh>) {
    print if /$regex/;
}
```

**Q8: What are references and how do you use them?**

A: References are scalar values pointing to other variables or data structures. They're essential for complex data structures.

```perl
# Creating references
my $scalar_ref = \$scalar;
my $array_ref = \@array;
my $hash_ref = \%hash;
my $code_ref = \&subroutine;

# Anonymous references (no original variable needed)
my $aref = [1, 2, 3];           # Anonymous array
my $href = {name => "Alice"};   # Anonymous hash

# Dereferencing
print $$scalar_ref;             # Dereference scalar
print @$array_ref;              # Dereference array
print %$hash_ref;               # Dereference hash
$code_ref->();                 # Call code reference

# Arrow notation (cleaner for nested access)
print $array_ref->[0];          # First element
print $hash_ref->{name};        # Hash key
$array_ref->[0] = 10;           # Modify element

# Complex structures
my $data = {
    users => [
        {id => 1, name => "Alice"},
        {id => 2, name => "Bob"}
    ]
};

print $data->{users}->[0]->{name};  # Alice
```

**Q9: How do you handle file operations in Perl?**

A: File operations use filehandles and standard I/O operations.

```perl
# Reading
open(my $fh, '<', 'input.txt') or die "Cannot open: $!\n";
my $line = <$fh>;           # Read one line
my @lines = <$fh>;          # Read all lines
while (my $line = <$fh>) {  # Read line-by-line
    chomp($line);           # Remove newline
    process($line);
}
close($fh);

# Writing
open(my $out, '>', 'output.txt') or die "Cannot open: $!\n";
print $out "Hello\n";
printf $out "Number: %d\n", 42;
close($out);

# Appending
open(my $app, '>>', 'log.txt') or die "Cannot open: $!\n";
print $app "Log entry\n";
close($app);

# File tests
if (-e $file) { print "Exists\n"; }
if (-f $file) { print "Regular file\n"; }
if (-d $dir) { print "Directory\n"; }
if (-r $file) { print "Readable\n"; }
my $size = -s $file;        # File size in bytes

# Directory operations
opendir(my $dh, '.') or die "Cannot open: $!\n";
my @files = readdir($dh);
closedir($dh);

# Glob for pattern matching
my @txt_files = glob("*.txt");
```

**Q10: What is the difference between map, grep, and sort?**

A: These are higher-order functions for transforming lists.

```perl
# map - Transform each element
my @doubled = map { $_ * 2 } (1, 2, 3, 4, 5);  # [2, 4, 6, 8, 10]
my @uppercase = map { uc($_) } @words;
my @lengths = map { length($_) } @strings;

# grep - Filter elements (like map but returns boolean)
my @evens = grep { $_ % 2 == 0 } (1..10);
my @long_words = grep { length($_) > 5 } @words;
my @valid = grep { is_valid($_) } @data;

# sort - Order elements
my @sorted = sort @words;                           # Alphabetical
my @numeric = sort { $a <=> $b } @numbers;         # Numeric ascending
my @reverse = sort { $b <=> $a } @numbers;         # Numeric descending
my @by_length = sort { length($a) <=> length($b) } @words;

# Combining operations
my @result = map { $_->{value} * 2 }
             grep { $_->{status} eq "active" }
             @records;

# Using with CPAN modules
use List::Util qw(sum max min first);
my $total = sum @numbers;
my $max_val = max @numbers;
my $first_positive = first { $_ > 0 } @numbers;
```

### Advanced Level (Deep Understanding)

**Q11: Design an object-oriented module with inheritance.**

A: Modern Perl OOP using both traditional and Moose approaches.

```perl
# Traditional Perl OOP
package Shape;
use strict;
use warnings;

sub new {
    my ($class, %attrs) = @_;
    return bless \%attrs, $class;
}

sub area {
    die "Subclasses must implement area\n";
}

package Circle;
use parent 'Shape';

sub new {
    my ($class, $radius) = @_;
    return $class->SUPER::new(radius => $radius);
}

sub area {
    my $self = shift;
    return 3.14159 * $self->{radius} ** 2;
}

package Rectangle;
use parent 'Shape';

sub new {
    my ($class, $width, $height) = @_;
    return $class->SUPER::new(width => $width, height => $height);
}

sub area {
    my $self = shift;
    return $self->{width} * $self->{height};
}

# Usage
package main;
my $circle = Circle->new(5);
print $circle->area(), "\n";   # 78.54

my $rect = Rectangle->new(4, 6);
print $rect->area(), "\n";     # 24

# Modern Moose approach
package Moose::Shape;
use Moose;

has 'name' => (is => 'ro', isa => 'Str');

sub area { die "Must implement\n"; }

package Moose::Circle;
use Moose;
extends 'Moose::Shape';

has 'radius' => (is => 'rw', isa => 'Num');

sub area {
    my $self = shift;
    return 3.14159 * $self->radius ** 2;
}

__PACKAGE__->meta->make_immutable;
```

**Q12: Write error handling code demonstrating eval and exception handling.**

A: Multiple approaches to handling errors robustly.

```perl
# Basic eval
eval {
    risky_function();
    another_risky();
};
if ($@) {
    warn "Caught error: $@\n";
    # Continue or recover
}

# With error recovery
my $result = eval {
    expensive_operation();
};
if ($@) {
    $result = default_value();
}

# Try::Tiny for cleaner syntax
use Try::Tiny;

try {
    validate_and_process($data);
} catch {
    my $error = $_;
    warn "Error: $error\n";
    log_error($error);
} finally {
    cleanup();
};

# Custom exceptions
eval {
    validate_email($email) or die "Invalid email\n";
    validate_age($age) or die "Invalid age\n";
};
if ($@) {
    if ($@ =~ /email/i) {
        handle_email_error();
    } elsif ($@ =~ /age/i) {
        handle_age_error();
    } else {
        handle_generic_error();
    }
}

# Exception objects for better control
package ValidationError;
sub new {
    my ($class, $field, $message) = @_;
    return bless {field => $field, message => $message}, $class;
}

eval {
    die ValidationError->new('email', 'Invalid format');
};
if ($@) {
    if (ref($@) eq 'ValidationError') {
        print "Field $@->{field}: $@->{message}\n";
    } else {
        die $@;  # Re-throw if not expected
    }
}
```

**Q13: Optimize the following code for performance. Explain each optimization.**

Original inefficient code:
```perl
# INEFFICIENT
foreach my $item (@large_array) {
    # O(n) search for each item
    if (grep { $_ eq $item } @check_list) {
        push @results, $item;
    }
}
```

Optimized solutions:

```perl
# OPTIMIZATION 1: Hash lookup O(1)
my %check = map { $_ => 1 } @check_list;
my @results = grep { $check{$_} } @large_array;

# OPTIMIZATION 2: Pre-compile regex if using patterns
my $pattern = qr/^active_/;  # Compile once
foreach my $item (@array) {
    if ($item =~ $pattern) {
        process($item);
    }
}

# OPTIMIZATION 3: Avoid repeated function calls
my $len = scalar @array;  # Cache length
for (my $i = 0; $i < $len; $i++) {
    process($array[$i]);
}

# OPTIMIZATION 4: Use appropriate data structures
# Instead of linear search:
if (grep { $_ == $target } @numbers) { }

# Use Set::Object for membership testing:
use Set::Object;
my $set = Set::Object->new(@list);
if ($set->contains($item)) { }

# OPTIMIZATION 5: Lazy evaluation
use List::Util qw(first);
my $found = first { expensive_check($_) } @items;

# OPTIMIZATION 6: Vectorized operations where possible
use PDL;  # Perl Data Language for numerical ops
my $pdl = pdl \@large_array;
my $result = $pdl * 2;  # Much faster than Perl loop
```

**Q14: Explain metaprogramming capabilities in Perl.**

A: Perl's ability to write code that modifies itself or generates code dynamically.

```perl
# Symbol table manipulation
sub create_getter {
    my ($class, $field) = @_;
    my $method_name = "get_$field";
    
    # Create method dynamically
    no strict 'refs';
    *{"${class}::${method_name}"} = sub {
        my $self = shift;
        return $self->{$field};
    };
}

# Symbolic references
my $var_name = "message";
my $var = "Hello";
$$var_name = $var;          # Sets $message = "Hello"
print $$var_name, "\n";

# Code generation with eval
sub generate_class {
    my ($name, @fields) = @_;
    my $code = qq{
        package $name;
        sub new {
            my (\$class, %args) = \@_;
            return bless \\\%args, \$class;
        }
    };
    
    foreach my $field (@fields) {
        $code .= qq{
            sub $field {
                my \$self = shift;
                return \$self->{$field};
            }
        };
    }
    
    eval $code;
    die "Code eval failed: $@" if $@;
}

# Advanced: Subroutine references and modification
my $original = sub { print "Original\n"; };
my $wrapped = sub {
    print "Before\n";
    $original->();
    print "After\n";
};

# Runtime code instrumentation
use Sub::Instrument;
my $timer = sub {
    my ($sub) = @_;
    return sub {
        my $start = time();
        my @result = $sub->(@_);
        my $elapsed = time() - $start;
        print "Took $elapsed seconds\n";
        return wantarray ? @result : $result[0];
    };
};
```

**Q15: Explain the difference between functional and imperative programming styles in Perl and when to use each.**

A: Perl supports both paradigms; choosing wisely improves code quality.

```perl
# IMPERATIVE STYLE
# Step-by-step procedure, mutating state

# Example 1: Filtering and transforming
my @numbers = (1, 2, 3, 4, 5);
my @result = ();
foreach my $num (@numbers) {
    if ($num > 2) {
        push @result, $num * 2;
    }
}
print "@result\n";  # 6 8 10

# FUNCTIONAL STYLE
# Data transformations, composable operations, immutable

my @numbers = (1, 2, 3, 4, 5);
my @result = map { $_ * 2 } grep { $_ > 2 } @numbers;
print "@result\n";  # Same result, but declarative

# More complex example
# Imperative
my @customers = get_customers();
my @local = ();
foreach my $c (@customers) {
    if ($c->{country} eq 'USA') {
        push @local, $c;
    }
}
my @by_name = ();
foreach my $c (sort { $a->{name} cmp $b->{name} } @local) {
    push @by_name, $c->{name};
}

# Functional
my @names = 
    map { $_->{name} }
    sort { $a->{name} cmp $b->{name} }
    grep { $_->{country} eq 'USA' }
    get_customers();

# Use functional when:
# ✓ Transforming data (cleaner, more readable)
# ✓ No side effects needed
# ✓ Working with small-to-medium lists
# ✓ Want declarative code

# Use imperative when:
# ✓ Performance critical (large datasets)
# ✓ Complex control flow needed
# ✓ Modifying structures in place
# ✓ Early exit conditions required

# Hybrid approach (often best)
use List::Util qw(sum);
my @data = get_data();
my $total = 0;
foreach my $item (@data) {
    next unless $item->{valid};    # Early exit
    $total += $item->{value};       # Accumulation
}
print "Total: $total\n";

# Or more functional:
my $total = sum map { $_->{value} } grep { $_->{valid} } @data;
```

---

## Summary

### Key Perl Takeaways

1. **Flexibility** - TMTOWTDI: Multiple ways to achieve same result
2. **Text Processing** - Powerful regex support, built-in
3. **Ecosystem** - 250,000+ modules on CPAN
4. **Rapid Development** - Less boilerplate than compiled languages
5. **System Administration** - Excellent for automation scripts
6. **Backward Compatible** - 30+ years of evolution, code still works
7. **Expressive** - Can write concise, powerful code

### Career Value

- System administration automation
- Log file analysis and parsing
- Web scraping and data extraction
- Legacy system maintenance
- Bioinformatics (sequence analysis)
- Still relevant despite newer languages
- Good foundation for understanding programming concepts

---

## References

- Perl Official Documentation (perldoc)
- "Programming Perl" (Camel Book)
- "Modern Perl" by Chromatic
- Perl Best Practices
- CPAN Module Documentation
- PerlMonks Community
# Perl Interview Q&A - Comprehensive Guide

## Table of Contents
1. [Basic Level Questions](#basic-level-questions)
2. [Intermediate Level Questions](#intermediate-level-questions)
3. [Advanced Level Questions](#advanced-level-questions)
4. [Topic-Specific Deep Dives](#topic-specific-deep-dives)
5. [Real-World Scenarios](#real-world-scenarios)

---

## Basic Level Questions

### Q1: What is Perl and what makes it unique?

**A:** Perl (Practical Extraction and Report Language) is a high-level, interpreted programming language created by Larry Wall in 1987. 

**Unique characteristics:**

```
Design Philosophy:
├─ TMTOWTDI (There's More Than One Way To Do It)
├─ Borrows syntax from shell, awk, sed, C
├─ Optimized for text processing and system admin
├─ Perl makes easy things easy and hard things possible
└─ Expressive and concise

Key Strengths:
├─ Powerful regular expression support (native to language)
├─ Rapid development (less boilerplate)
├─ Cross-platform compatibility
├─ Large CPAN ecosystem (250,000+ modules)
├─ Excellent string/text processing
├─ Strong in system administration automation
└─ Backward compatible (30+ years of code still works)

Modern Use:
├─ System administration scripts
├─ Log file analysis
├─ Data ETL/transformation
├─ Legacy system maintenance
├─ Bioinformatics (sequence analysis)
└─ Web applications (though declining in favor of Python/Node.js)
```

### Q2: Explain Perl's sigils ($, @, %) and provide examples.

**A:** Sigils are prefix characters that denote variable types and context:

```perl
# $ - Scalar (single value)
my $age = 25;                   # String or number
my $ref = \@array;              # Reference
my $name = "Alice";
print $age, $name;

# @ - Array (ordered list of scalars)
my @colors = qw(red green blue);
my @numbers = (1..10);
push @colors, "yellow";         # Add element
my $first = $colors[0];         # Single element uses $
my @slice = @colors[0,2];       # Slice uses @

# % - Hash (key-value pairs)
my %person = (
    name => "Alice",
    age => 30,
    city => "NYC"
);
my $name = $person{name};       # Single value uses $
my @keys = keys %person;        # All keys use @

# Context-sensitive usage
@array[1..3];                   # Array slice (@array)
@hash{$key1, $key2};            # Hash slice (@hash)
scalar(@array);                 # Array in scalar context (length)
scalar(keys %hash);             # Hash keys in scalar context (count)

# Real-world example
my %config = (
    db_host => "localhost",
    db_port => 5432,
    db_user => "admin"
);

# Accessing: context determines form
foreach my $key (keys %config) {           # @ context for keys
    print "$key: $config{$key}\n";         # $ context for value
}

my @all_values = values %config;           # @ context for values
my $first_value = (values %config)[0];     # Single value
```

### Q3: What is the difference between `my`, `our`, and `local`?

**A:** These keywords control variable scope and lifetime:

```perl
# my - Lexical scope (PREFERRED in modern Perl)
# Block-scoped, compile-time, creates new variable
{
    my $x = 10;
    print "$x\n";           # 10 - accessible
}
# print "$x\n";             # ERROR - out of scope

sub lexical_demo {
    my $count = 0;          # Scoped to this function
    return sub {
        return ++$count;    # Closure: captures $count
    };
}

# our - Package scope (for globals)
# Entire package has access, compile-time
package MyPackage;
our $version = "1.0";

sub get_version {
    return $version;        # Accessible anywhere in package
}

sub set_version {
    $version = shift;       # Can modify
}

# local - Dynamic scope (DEPRECATED, avoid in new code)
# Temporarily saves/restores package variable
our $global = "original";

sub dynamic_demo {
    local $global = "temporary";    # Save old value
    print "$global\n";              # "temporary"
}

print "$global\n";                  # "original" - restored

# Best practice comparison
# Good: Use my
{
    my $private = "safe";
}

# Acceptable: Use our for package globals
our $DEBUG = 0;
sub debug { print "Debug\n" if $DEBUG; }

# Avoid: local is confusing
# local $var = value;  # Don't do this
```

**Comparison table:**

| Feature | my | our | local |
|---------|-----|-----|-------|
| **Scope** | Lexical (block) | Package | Dynamic (until end of block) |
| **Lifetime** | Compile-time | Compile-time | Runtime |
| **Creates New** | Yes | No (alias) | No (temporary) |
| **Modern Usage** | ✓ Preferred | ✓ For globals | ✗ Avoid |
| **Thread-safe** | Yes | Depends | No |

### Q4: Explain variable interpolation in Perl.

**A:** Interpolation is substitution of variables within strings:

```perl
# Double quotes - INTERPOLATE variables and escapes
my $name = "Alice";
my $age = 30;

print "Name: $name\n";              # Name: Alice
print "Age: $age\n";                # Age: 30
print "Next year: $age years old\n"; # Next year: 30 years old

# Complex interpolation
my @items = qw(apple banana cherry);
print "Items: @items\n";            # Items: apple banana cherry

my $ref = \$name;
print "Reference: $$ref\n";         # Reference: Alice

# Escape special characters
print "Cost: \$100\n";              # Cost: $100
print "Path: C:\\Users\\Files\n";   # Path: C:\Users\Files
print "Quote: \"Hello\"\n";         # Quote: "Hello"

# Escape sequences
print "Tab:\tSeparated\n";          # Tab separation
print "Line 1\nLine 2\n";           # Newline

# Single quotes - NO INTERPOLATION (literal)
print 'Name: $name\n';              # Name: $name\n (literal)
print 'No interpolation here\n';    # No interpolation here\n

# qw() - quote words (no interpolation)
my @static = qw(one two three);    # ('one', 'two', 'three')
my @words = qw($name should not interpolate);

# Alternative: qq{} double-quote-like
my $message = qq{Hello $name, you are $age};

# Complex case: method calls don't interpolate
my $obj = get_object();
# print "Result: $obj->method\n";    # WRONG - prints literal
print "Result: " . $obj->method . "\n";  # CORRECT

# hash/array elements DO interpolate
my %data = (key => "value");
print "Data: $data{key}\n";         # Data: value

my @list = (1, 2, 3);
print "First: $list[0]\n";          # First: 1

# Best practice: use qq{} for complex strings
my $complex = qq{
    User: $name
    Age: $age
    Items: @items
};
print $complex;
```

### Q5: What is CPAN and how do you use modules?

**A:** CPAN (Comprehensive Perl Archive Network) is a vast repository of reusable Perl modules:

```perl
# Using CPAN modules - Installation

# Command line (cpan utility)
cpan install DateTime
cpan install JSON
cpan install DBI

# Using cpanm (Perl package manager)
cpanm DateTime
cpanm JSON
cpanm List::Util

# From perl directly
perl -MCPAN -e 'install DateTime'

# Manual: download, extract, build
tar xzf Module-Name.tar.gz
cd Module-Name
perl Makefile.PL
make
make test
make install

# Using modules in code
use strict;
use warnings;
use DateTime;
use JSON;
use DBI;
use List::Util qw(sum max min first);

# Without importing specific functions
use Data::Dumper ();
print Data::Dumper::Dumper(\%hash);

# With specific imports
use List::Util qw(sum max min);
my $total = sum(@numbers);

# Import with alias
use List::Util max => { -as => 'maximum' };
my $largest = maximum(@numbers);

# Popular CPAN modules by category

# Web & Networking
use LWP::UserAgent;        # HTTP client
use Mojo::UserAgent;       # HTTP client (modern)
use Mojolicious;           # Web framework
use Catalyst;              # Enterprise web framework
use Plack;                 # PSGI server

# Database
use DBI;                   # Database interface
use DBD::mysql;            # MySQL driver
use DBIx::Class;           # ORM
use DBIx::Connector;       # Connection management

# Data Processing
use JSON;                  # JSON encode/decode
use YAML;                  # YAML parsing
use Text::CSV;             # CSV parsing
use XML::Simple;           # XML handling

# Date & Time
use DateTime;              # Date/time handling
use Time::HiRes;           # High-resolution timing
use Date::Format;          # Formatting dates

# Testing
use Test::More;            # Testing framework
use Test::Deep;            # Deep comparison
use Test::Exception;       # Exception testing
use Test::Mock::Simple;    # Mocking

# Text & Utilities
use List::Util;            # List operations
use List::MoreUtils;       # Additional list operations
use File::Slurp;           # File reading
use Digest::MD5;           # MD5 hashing
use Crypt::Digest::SHA256; # SHA256

# OOP & Type System
use Moose;                 # Modern OOP
use Moo;                   # Lightweight OOP
use Types::Standard;       # Type checking

# Command line
use Getopt::Long;          # Command-line arguments
use Term::ReadLine;        # Interactive input
use Term::ANSIColor;       # Colored output

# Checking if module is installed
eval { require JSON; };
if ($@) {
    die "JSON module not installed\n";
} else {
    print "JSON is available\n";
}

# Conditional use
eval { require DateTime; };
if (!$@) {
    use DateTime;
    my $now = DateTime->now;
}

# Version checking
use JSON 2.00;             # Require version 2.00 or later
```

### Q6: How do subroutines work in Perl?

**A:** Subroutines are reusable blocks of code:

```perl
# Basic subroutine definition
sub greet {
    print "Hello, World!\n";
}

greet();        # Call with parentheses
greet;          # Call without (if no strict subs disabled)

# With parameters - use @_ array
sub add {
    my ($a, $b) = @_;      # Extract arguments
    return $a + $b;
}

my $sum = add(5, 3);       # 8

# Multiple parameters
sub person_info {
    my ($name, $age, $city) = @_;
    print "$name is $age years old from $city\n";
}

person_info("Alice", 30, "NYC");

# Variable number of arguments
sub sum_all {
    my $total = 0;
    foreach my $num (@_) {
        $total += $num;
    }
    return $total;
}

print sum_all(1, 2, 3, 4, 5);   # 15

# Return multiple values
sub get_coordinates {
    my $x = 10;
    my $y = 20;
    return ($x, $y);
}

my ($x, $y) = get_coordinates();

# Return hash (key-value)
sub get_person {
    return (name => "Alice", age => 30);
}

my %person = get_person();
print $person{name};           # Alice

# Subroutine references
my $add_ref = sub {
    my ($a, $b) = @_;
    return $a + $b;
};

my $result = $add_ref->(5, 3);  # 8

# Passing by reference
sub double_array {
    my $array_ref = shift;
    foreach my $item (@$array_ref) {
        $item *= 2;
    }
}

my @numbers = (1, 2, 3);
double_array(\@numbers);
print "@numbers";              # 2 4 6

# Modern Perl - subroutine signatures (5.20+)
use feature 'signatures';

sub calculate($a, $b, $op = '+') {
    return $op eq '+' ? $a + $b : $a - $b;
}

print calculate(10, 5);        # 15
print calculate(10, 5, '-');   # 5

# Prototypes (compile-time hints)
sub get_first($) {             # Expects one scalar
    my $array = shift;
    return $array->[0];
}

sub add_two($$) {              # Expects two scalars
    my ($a, $b) = @_;
    return $a + $b;
}
```

### Q7: Explain regular expressions basics.

**A:** Regular expressions are patterns for matching and manipulating text:

```perl
# Match operator (=~)
if ($string =~ /pattern/) {
    print "Pattern found\n";
}

# Not match operator (!~)
if ($string !~ /pattern/) {
    print "Pattern not found\n";
}

# Basic patterns
/hello/            # Literal string
/^start/           # Anchored at beginning
/end$/             # Anchored at end
/a.c/              # . matches any character
/[abc]/            # Character class (a, b, or c)
/[^abc]/           # Negated class (anything except a, b, c)
/[a-z]/            # Range (lowercase letters)
/[a-zA-Z0-9]/      # Multiple ranges

# Predefined character classes
/\d/               # Digit [0-9]
/\D/               # Non-digit
/\w/               # Word character [a-zA-Z0-9_]
/\W/               # Non-word
/\s/               # Whitespace
/\S/               # Non-whitespace

# Quantifiers (how many times)
/a/                # Exactly one 'a'
/a*/               # Zero or more 'a's
/a+/               # One or more 'a's
/a?/               # Zero or one 'a'
/a{3}/             # Exactly 3 'a's
/a{3,5}/           # 3 to 5 'a's
/a{3,}/            # 3 or more 'a's

# Modifiers
/pattern/i         # Case-insensitive
/pattern/g         # Global (all occurrences)
/pattern/m         # Multiline
/pattern/s         # Dot matches newlines
/pattern/x         # Extended (ignore whitespace)

# Capturing groups
if ("John Smith" =~ /(\w+)\s+(\w+)/) {
    my $first = $1;    # John
    my $last = $2;     # Smith
}

# Substitution
$string =~ s/old/new/;        # Replace first occurrence
$string =~ s/old/new/g;       # Replace all occurrences
$count = ($string =~ s/old/new/g);  # Count replacements

# Global matching (extract all)
my @words = $string =~ /\b(\w+)\b/g;

# Common patterns
# Email
if ($email =~ /^[\w.-]+\@[\w.-]+\.\w+$/) { }

# Phone number (XXX-XXX-XXXX)
if ($phone =~ /^\d{3}-\d{3}-\d{4}$/) { }

# URL
if ($url =~ m|^https?://(\w+\.\w+)(.*)$|) { }

# IP address
if ($ip =~ /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/) { }

# Pre-compile regex for efficiency
my $email_regex = qr/^[\w.-]+\@[\w.-]+\.\w+$/;
if ($email =~ $email_regex) { }
if ($other_email =~ $email_regex) { }

# Split by regex
my @words = split(/\s+/, $text);        # Split by whitespace
my @parts = split(/[,;:]/, $csv);       # Split by multiple delimiters
my @lines = split(/\n/, $content);      # Split by newline
```

---

## Intermediate Level Questions

### Q8: What are references and how do you use them?

**A:** References are scalar values that point to other variables or data structures:

```perl
# Creating references (using backslash \)
my $scalar_ref = \$scalar;
my $array_ref = \@array;
my $hash_ref = \%hash;
my $code_ref = \&subroutine;

# Dereferencing
print $$scalar_ref;            # $ prefix to dereference scalar
print @$array_ref;             # @ prefix to dereference array
print %$hash_ref;              # % prefix to dereference hash
$code_ref->();                # Call code reference

# Arrow notation (cleaner for complex structures)
my $first = $array_ref->[0];   # First array element
my $value = $hash_ref->{key};  # Hash value
$code_ref->(1, 2);             # Call with arguments

# Anonymous data structures
my $aref = [1, 2, 3];          # Anonymous array reference
my $href = {                   # Anonymous hash reference
    name => "Alice",
    age => 30
};

# Accessing anonymous structures
print $aref->[0];              # 1
print $href->{name};           # Alice
push @$aref, 4;                # Add to array

# Complex nested structures
my $data = {
    users => [
        {id => 1, name => "Alice", skills => [qw(Perl Python)]},
        {id => 2, name => "Bob", skills => [qw(Java C++)]}
    ],
    config => {
        db_host => "localhost",
        db_port => 5432
    }
};

# Accessing nested data
print $data->{users}->[0]->{name};          # Alice
print $data->{users}->[0]->{skills}->[0];   # Perl
print $data->{config}->{db_host};           # localhost

# Array of hashes
my @people = (
    {name => "Alice", age => 30},
    {name => "Bob", age => 25}
);

foreach my $person (@people) {
    print $person->{name}, "\n";
}

# Hash of arrays
my %teams = (
    engineering => ["Alice", "Bob", "Charlie"],
    sales => ["David", "Eve"]
);

print $teams{engineering}->[0];      # Alice
foreach my $member (@{$teams{engineering}}) {
    print "$member\n";
}

# References as function arguments
sub process_array {
    my $aref = shift;
    foreach my $item (@$aref) {
        print "$item\n";
    }
}

process_array([1, 2, 3]);
process_array(\@existing_array);

# References for passing large data efficiently
sub modify_hash {
    my $href = shift;
    $href->{modified} = 1;
}

modify_hash(\%data);  # Passed by reference, not copied

# Type checking references
if (ref($var) eq 'ARRAY') { print "Array ref\n"; }
if (ref($var) eq 'HASH') { print "Hash ref\n"; }
if (ref($var) eq 'CODE') { print "Code ref\n"; }
if (ref($var) eq 'SCALAR') { print "Scalar ref\n"; }

# UNIVERSAL::isa for type checking
if ($data->isa('SomeClass')) { }

# Dereferencing shortcuts
my ($x, $y) = @$array_ref;           # Multi-element
my ($first, @rest) = @$array_ref;    # First and rest
```

### Q9: How do you work with files in Perl?

**A:** File operations are central to system administration scripts:

```perl
# Opening files - three forms

# Reading
open(my $fh, '<', 'input.txt') 
    or die "Cannot open input.txt: $!\n";

# Writing (create/overwrite)
open(my $out, '>', 'output.txt')
    or die "Cannot open output.txt: $!\n";

# Appending
open(my $app, '>>', 'logfile.txt')
    or die "Cannot open logfile.txt: $!\n";

# Reading operations
my $line = <$fh>;              # Read one line
my @all_lines = <$fh>;         # Read all lines into array
while (my $line = <$fh>) {      # Read line by line (memory efficient)
    chomp($line);              # Remove trailing newline
    process($line);
}

# Writing operations
print $fh "Hello\n";
printf $fh "Number: %d\n", 42;
print $fh join("\n", @lines);

# Closing
close($fh) or warn "Cannot close: $!\n";

# File tests (checking file properties)
if (-e $filename) { print "Exists\n"; }
if (-f $filename) { print "Regular file\n"; }
if (-d $dirname) { print "Directory\n"; }
if (-l $path) { print "Symbolic link\n"; }

# Permissions
if (-r $file) { print "Readable\n"; }
if (-w $file) { print "Writable\n"; }
if (-x $file) { print "Executable\n"; }

# Size and modification time
my $size = -s $filename;       # File size in bytes
my $mtime = -M $filename;      # Days since modification
if ($mtime > 7) { print "Older than 7 days\n"; }

# File operations
unlink($filename) or die "Cannot delete: $!\n";
rename($old, $new) or die "Cannot rename: $!\n";
copy($src, $dst) or die "Cannot copy: $!\n";

# Directory operations
opendir(my $dh, '.') or die "Cannot open: $!\n";
my @files = readdir($dh);
closedir($dh);

mkdir("newdir") or die "Cannot mkdir: $!\n";
rmdir("emptydir") or die "Cannot rmdir: $!\n";
chdir("/path") or die "Cannot chdir: $!\n";

# Glob for pattern matching
my @txt_files = glob("*.txt");
my @all_files = glob("*");
my @deep = glob("src/**/*.pl");

# Reading entire file into memory
open(my $fh, '<', $file) or die "Cannot open: $!\n";
my $content = do { local $/; <$fh> };  # Read entire file
close($fh);

# Or use File::Slurp module
use File::Slurp;
my $text = read_file($filename);
my @lines = read_file($filename, chomp => 1);

# Writing multiple lines
open(my $fh, '>', $file) or die "Cannot open: $!\n";
print $fh @lines;
close($fh);

# Safer file handling with autodie
use autodie;
open(my $fh, '<', $file);  # Dies automatically on error
while (<$fh>) {
    # Process
}
close($fh);

# Temporary files
use File::Temp qw(tempfile);
my ($fh, $filename) = tempfile();
print $fh "temporary content\n";
close($fh);
unlink($filename);
```

### Q10: Explain map, grep, and sort functions.

**A:** These are higher-order functions for transforming lists:

```perl
# map - Transform each element, returns new list
my @numbers = (1, 2, 3, 4, 5);
my @doubled = map { $_ * 2 } @numbers;           # [2, 4, 6, 8, 10]

my @squares = map { $_ ** 2 } @numbers;          # [1, 4, 9, 16, 25]

my @words = qw(apple banana cherry);
my @uppercase = map { uc($_) } @words;           # [APPLE, BANANA, CHERRY]

my @lengths = map { length($_) } @words;         # [5, 6, 6]

# map with hash
my @keys = map { $_->{id} } @users;
my @names = map { $_->{name} } @users;

# Complex transformation
my @results = map {
    my $squared = $_ * $_;
    my $cubed = $_ ** 3;
    "$_: sq=$squared, cb=$cubed"
} @numbers;

# grep - Filter elements (keep those where block returns true)
my @evens = grep { $_ % 2 == 0 } @numbers;       # [2, 4]

my @odds = grep { $_ % 2 != 0 } @numbers;        # [1, 3, 5]

my @long_words = grep { length($_) > 5 } @words; # [banana, cherry]

# grep with complex logic
my @valid = grep { defined && $_ > 0 } @data;

my @active_users = grep { $_->{status} eq 'active' } @users;

# Combining map and grep (pipeline)
my @result = map { $_->{name} }                  # Extract names
             grep { $_->{status} eq 'active' }   # Filter active
             @users;                             # From users

# Alternative chaining (same result, different style)
my @names = grep { $_ }
            map { $_->{status} eq 'active' ? $_->{name} : undef }
            @users;

# sort - Order elements
my @sorted = sort @words;                        # Alphabetical: [apple, banana, cherry]

my @numeric = sort { $a <=> $b } @numbers;      # Numeric ascending: [1, 2, 3, 4, 5]

my @reverse = sort { $b <=> $a } @numbers;      # Numeric descending: [5, 4, 3, 2, 1]

# sort strings (custom order)
my @by_length = sort { length($a) <=> length($b) } @words;

my @case_insensitive = sort { lc($a) cmp lc($b) } @mixed_case;

# sort objects/hashes
my @by_age = sort { $a->{age} <=> $b->{age} } @people;

my @by_name = sort { $a->{name} cmp $b->{name} } @people;

# Multi-level sort (age, then name)
my @sorted = sort {
    $a->{age} <=> $b->{age} ||      # Primary: age
    $a->{name} cmp $b->{name}       # Secondary: name
} @people;

# Reverse sort (opposite order)
my @reverse = sort { $b cmp $a } @words;

# Using Sort::Key for performance
use Sort::Key qw(keysort);
my @by_id = keysort { $_->{id} } @records;

# Using List::Util
use List::Util qw(sum max min first);
my $total = sum @numbers;
my $maximum = max @numbers;
my $minimum = min @numbers;
my $first_even = first { $_ % 2 == 0 } @numbers;

# Combining operations (advanced)
my @final = 
    map { sprintf("%.2f", $_) }
    grep { $_ > 100 }
    map { $_ * 1.1 }  # Apply 10% increase
    sort { $a <=> $b }
    @prices;
```

### Q11: How do you create and use object-oriented Perl?

**A:** Perl OOP uses blessing and packages:

```perl
# Traditional Perl OOP

package Person;
use strict;
use warnings;

# Constructor
sub new {
    my ($class, %args) = @_;
    my $self = {
        name => $args{name},
        age => $args{age},
        email => $args{email}
    };
    bless $self, $class;
    return $self;
}

# Method
sub greet {
    my $self = shift;
    return "Hello, I'm " . $self->{name};
}

sub birthday {
    my $self = shift;
    $self->{age}++;
}

# Accessor methods
sub name {
    my $self = shift;
    if (@_) {
        $self->{name} = shift;  # Setter
    }
    return $self->{name};       # Getter
}

# Destructor (optional)
sub DESTROY {
    my $self = shift;
    print "Destroying " . $self->{name} . "\n";
}

package main;
use Person;

my $person = Person->new(
    name => "Alice",
    age => 30,
    email => "alice@example.com"
);

print $person->greet(), "\n";   # Hello, I'm Alice
$person->birthday();
print $person->{age}, "\n";     # 31
print $person->name(), "\n";    # Alice

# Inheritance

package Animal;
use strict;
use warnings;

sub new {
    my ($class, $name) = @_;
    my $self = {name => $name};
    bless $self, $class;
}

sub speak {
    my $self = shift;
    print "$self->{name} makes a sound\n";
}

# Derived class
package Dog;
use strict;
use warnings;
our @ISA = ('Animal');  # Inheritance

sub speak {
    my $self = shift;
    print "$self->{name} barks\n";
}

sub fetch {
    my $self = shift;
    print "$self->{name} fetches the ball\n";
}

package main;
my $dog = Dog->new("Buddy");
$dog->speak();      # Buddy barks
$dog->fetch();      # Buddy fetches the ball

# Modern OOP with Moose (recommended)
package Person::Modern;
use Moose;

has 'name' => (
    is => 'rw',
    isa => 'Str',
    required => 1
);

has 'age' => (
    is => 'rw',
    isa => 'Int',
    default => 0
);

has 'email' => (
    is => 'ro',
    isa => 'Str'
);

sub greet {
    my $self = shift;
    return "Hello, I'm " . $self->name;
}

__PACKAGE__->meta->make_immutable;

package main;
my $person = Person::Modern->new(
    name => "Bob",
    age => 25,
    email => "bob@example.com"
);

print $person->greet(), "\n";
$person->age(26);
print $person->age(), "\n";

# Lightweight OOP with Moo
package Lightweight;
use Moo;

has 'id' => (is => 'ro', required => 1);
has 'value' => (is => 'rw');

package main;
my $obj = Lightweight->new(id => 1);
$obj->value(42);
```

### Q12: What are closures and how do you create them?

**A:** Closures are anonymous subroutines that capture variables from their enclosing scope:

```perl
# Simple closure
sub make_counter {
    my $count = 0;          # Lexical variable
    return sub {
        return ++$count;    # Closure captures $count
    };
}

my $counter1 = make_counter();
print $counter1->(), "\n";  # 1
print $counter1->(), "\n";  # 2
print $counter1->(), "\n";  # 3

# Each closure has its own copy
my $counter2 = make_counter();
print $counter2->(), "\n";  # 1 (independent)

# Function factory
sub make_multiplier {
    my $factor = shift;
    return sub {
        my $value = shift;
        return $value * $factor;
    };
}

my $double = make_multiplier(2);
my $triple = make_multiplier(3);

print $double->(5), "\n";   # 10
print $triple->(5), "\n";   # 15

# Closures in loops
my @processors = ();
foreach my $i (1..5) {
    push @processors, sub {
        return $_[0] * $i;  # Each closure captures $i
    };
}

print $processors[0]->(10), "\n";  # 50 (not 10!)
# Note: All closures capture final value of $i

# Correct way (capture value, not variable)
my @correct = ();
foreach my $i (1..5) {
    push @correct, sub {
        my $captured = $i;  # Capture the value
        return $_[0] * $captured;
    };
}

print $correct[0]->(10), "\n";  # 10
print $correct[4]->(10), "\n";  # 50

# Closures for callbacks
sub process_files {
    my ($directory, $callback) = @_;
    opendir(my $dh, $directory) or die "Cannot open: $!\n";
    while (my $file = readdir($dh)) {
        next if $file =~ /^\./;
        $callback->($file);
    }
    closedir($dh);
}

my $count = 0;
process_files('.', sub {
    my $filename = shift;
    $count++;
});
print "Found $count files\n";

# Practical example: configurable handlers
sub make_logger {
    my $level = shift;
    return sub {
        my ($message) = @_;
        print "[$level] $message\n";
    };
}

my $error = make_logger("ERROR");
my $info = make_logger("INFO");

$error->("Something failed");   # [ERROR] Something failed
$info->("Process started");     # [INFO] Process started
```

---

## Advanced Level Questions

### Q13: Explain tie variables and their practical uses.

**A:** Tied variables provide custom behavior when accessing variables:

```perl
# Creating tied variables

package LoggingScalar;

sub TIESCALAR {
    my ($class, $initial) = @_;
    my $self = {
        value => $initial,
        access_count => 0
    };
    return bless $self, $class;
}

sub FETCH {
    my $self = shift;
    $self->{access_count}++;
    print "Accessing value (access #$self->{access_count})\n";
    return $self->{value};
}

sub STORE {
    my ($self, $value) = @_;
    print "Setting value to $value\n";
    $self->{value} = $value;
}

# Using tied scalar
package main;
tie my $var, 'LoggingScalar', 'initial_value';
print $var, "\n";              # Calls FETCH, prints access count
$var = 'new_value';            # Calls STORE

# Tied Hash

package CaseInsensitiveHash;

sub TIEHASH {
    my $class = shift;
    return bless {}, $class;
}

sub FETCH {
    my ($self, $key) = @_;
    return $self->{lc($key)};
}

sub STORE {
    my ($self, $key, $value) = @_;
    $self->{lc($key)} = $value;
}

sub EXISTS {
    my ($self, $key) = @_;
    return exists $self->{lc($key)};
}

# Usage
package main;
tie my %hash, 'CaseInsensitiveHash';
$hash{NAME} = "Alice";
print $hash{name}, "\n";       # Alice (case-insensitive)

# Practical: Lazy-loading hash
package LazyHash;

sub TIEHASH {
    my ($class, $loader) = @_;
    return bless {loader => $loader}, $class;
}

sub FETCH {
    my ($self, $key) = @_;
    # Load data only when accessed
    unless (exists $self->{$key}) {
        $self->{$key} = $self->{loader}->($key);
    }
    return $self->{$key};
}

# Common practical uses
# 1. Logging variable access
# 2. Case-insensitive lookups
# 3. Lazy loading (compute on demand)
# 4. Database-backed variables
# 5. Auto-vivification
# 6. Transaction tracking

# Example: Database-backed hash
package DBHash;

sub TIEHASH {
    my ($class, $dbh, $table) = @_;
    return bless {dbh => $dbh, table => $table}, $class;
}

sub FETCH {
    my ($self, $key) = @_;
    my $sth = $self->{dbh}->prepare(
        "SELECT value FROM $self->{table} WHERE key = ?"
    );
    $sth->execute($key);
    my ($value) = $sth->fetchrow_array;
    return $value;
}

sub STORE {
    my ($self, $key, $value) = @_;
    $self->{dbh}->do(
        "UPDATE $self->{table} SET value = ? WHERE key = ?",
        undef,
        $value, $key
    );
}
```

### Q14: What is context sensitivity in Perl?

**A:** Perl behaves differently based on the context (scalar, list, void):

```perl
# Context determines behavior

# SCALAR context - single value expected
my @array = (1, 2, 3, 4, 5);
my $count = @array;            # Returns length (5)

my $last = (1, 2, 3);          # Returns last value (3)

my $first = shift @array;      # Removes and returns first

# LIST context - multiple values expected
my @list = (1, 2, 3);
my ($x, $y, $z) = (1, 2, 3);  # Distributes values
my ($a, $b) = (1, 2, 3);      # Gets first two only

my @keys = keys %hash;         # List context: all keys
my $count = keys %hash;        # Scalar context: count

my @values = reverse @array;   # List context: reversed list
my $reversed = reverse @array; # Scalar context: concatenated

# BOOLEAN context - true/false
if (@array) { }                # True if array has elements
if ($scalar) { }               # True if non-zero/non-empty
unless (@array) { }            # False if empty

# VOID context - return value ignored
some_function();               # Result not captured
1 + 2;                        # Calculation not used

# Functions sensitive to context
sub context_demo {
    if (wantarray) {
        # List context
        return (1, 2, 3);
    } elsif (defined wantarray) {
        # Scalar context
        return 42;
    } else {
        # Void context
        print "Called in void context\n";
        return;
    }
}

my @list = context_demo();     # (1, 2, 3)
my $scalar = context_demo();   # 42
context_demo();                # "Called in void context"

# Built-in functions with context awareness
my @array = (1, 2, 3);
my $first = shift @array;      # Scalar: removes element
my @shifted = (shift @array);  # List: array with one element

my $keys_count = keys %hash;   # Scalar: count
my @keys = keys %hash;         # List: all keys

# readline (<>)
my $line = <$fh>;              # Scalar: one line
my @lines = <$fh>;             # List: all lines

# Detecting caller context
sub flexible {
    my @data = @_;
    
    if (wantarray) {
        # Return list
        return @data;
    } else {
        # Return scalar
        return scalar(@data);
    }
}

my @result = flexible(1..10);  # (1, 2, ..., 10)
my $count = flexible(1..10);   # 10

# Hash in scalar context
my $scalar = %hash;            # Returns "2/8" (buckets)
my $count = scalar keys %hash; # Returns count

# String in numeric context
my $num = "42abc";             # Converts to 42
my $zero = "abc42";            # Converts to 0
my $undef = "abc";             # Converts to 0 with warning

# Forcing context
my $first = (shift @array);    # Scalar context
my @shifted = shift @array;    # List context: creates array
```

### Q15: How do you handle errors and exceptions effectively?

**A:** Multiple strategies for robust error handling:

```perl
# Strategy 1: die and eval

eval {
    risky_function();
    another_risky();
};
if ($@) {
    warn "Error occurred: $@\n";
    # Handle error
}

# Return value from eval
my $result = eval {
    expensive_operation();
};
if ($@) {
    $result = default_value();
}

# Strategy 2: Try::Tiny (cleaner syntax)
use Try::Tiny;

try {
    validate_and_process($data);
} catch {
    my $error = $_;
    warn "Caught: $error\n";
    log_error($error);
} finally {
    cleanup();
};

# Strategy 3: Custom exceptions

package ValidationError;

sub new {
    my ($class, $field, $message) = @_;
    return bless {
        field => $field,
        message => $message
    }, $class;
}

sub as_string {
    my $self = shift;
    return "Validation error in $self->{field}: $self->{message}";
}

# Using custom exceptions
eval {
    die ValidationError->new('email', 'Invalid format');
};
if ($@) {
    if (ref($@) eq 'ValidationError') {
        print $@->as_string(), "\n";
    } else {
        die $@;  # Re-throw
    }
}

# Strategy 4: Multiple catch blocks
eval {
    open_connection($host) or die "Connection failed\n";
    execute_query($sql) or die "Query failed\n";
    process_results() or die "Processing failed\n";
};
if ($@) {
    if ($@ =~ /Connection/) {
        handle_connection_error();
    } elsif ($@ =~ /Query/) {
        handle_query_error();
    } else {
        handle_generic_error();
    }
}

# Strategy 5: File operations with autodie
use autodie;

open(my $fh, '<', $file);  # Dies automatically on error
while (my $line = <$fh>) {
    process($line);
}
close($fh);

# Strategy 6: Returning error codes
sub safe_operation {
    my $result = operation();
    return (0, "Error message") unless $result;
    return (1, $result);
}

my ($success, $data) = safe_operation();
if ($success) {
    print "Success: $data\n";
} else {
    warn "Failed: $data\n";
}

# Strategy 7: Exception hierarchy
package MyException;
sub new { my ($class, %args) = @_; return bless \%args, $class; }

package NetworkException;
our @ISA = ('MyException');

package DatabaseException;
our @ISA = ('MyException');

eval {
    # Code that might fail
};
if ($@) {
    if (ref($@) eq 'NetworkException') {
        # Handle network error
    } elsif (ref($@) eq 'DatabaseException') {
        # Handle DB error
    } elsif (ref($@)) {
        # Unknown exception type
        die $@;
    } else {
        # String error
        die "String error: $@\n";
    }
}

# Best practices
# 1. Always catch specific errors
# 2. Log errors appropriately
# 3. Clean up resources (finally blocks)
# 4. Re-throw if can't handle
# 5. Use Try::Tiny for clarity
# 6. Create custom exception classes
# 7. Never silently ignore errors
```

---

## Topic-Specific Deep Dives

### Regular Expression Advanced Techniques

```perl
# Named capture groups (Perl 5.10+)
if ("john@example.com" =~ /(?<user>\w+)\@(?<domain>.+)/) {
    my $user = $+{user};      # john
    my $domain = $+{domain};  # example.com
}

# Non-capturing groups
if ("test123" =~ /(?:\w+)(\d+)/) {
    print $1, "\n";           # 123 (second group)
}

# Lookahead and lookbehind
/foo(?=bar)/       # Positive lookahead
/foo(?!bar)/       # Negative lookahead
/(?<=foo)bar/      # Positive lookbehind
/(?<!foo)bar/      # Negative lookbehind

# Word boundaries
/\bword\b/         # Whole word match

# Greedy vs non-greedy
/a+/               # Greedy: matches maximum
/a+?/              # Non-greedy: matches minimum

/a.*b/             # Greedy: from first a to last b
/a.*?b/            # Non-greedy: from first a to first b

# Substitution with callbacks
$text =~ s/(\d+)/ sprintf("%.2f", $1) /ge;

# Split with capturing
my @parts = split(/(\d+)/, "a1b2c3");  # Captures delimiters

# Study for performance (optimization)
study($text);      # Pre-analyze string for faster matching
```

### Module Development Best Practices

```perl
# Proper module structure

package MyModule;
use strict;
use warnings;
our $VERSION = '1.0.0';

# POD documentation
=pod

=head1 NAME

MyModule - Description

=head1 SYNOPSIS

use MyModule;

=head1 DESCRIPTION

Detailed description.

=head1 METHODS

=head2 new()

Constructor description.

=cut

# Exports
our @EXPORT = qw(exported_func);
our @EXPORT_OK = qw(optional_func);
our %EXPORT_TAGS = (
    all => \@EXPORT,
    optional => \@EXPORT_OK
);

use Exporter qw(import);

sub exported_func {
    return "exported";
}

sub optional_func {
    return "optional";
}

sub private_func {
    return "private";
}

1;  # Required!

# Using the module
use MyModule;              # Imports @EXPORT
use MyModule qw(:all);     # Imports all
use MyModule qw(optional_func);  # Selective import
```

---

## Real-World Scenarios

### Scenario 1: Log File Parser with Error Handling

```perl
#!/usr/bin/perl
use strict;
use warnings;
use Try::Tiny;
use File::Basename;

my $logfile = shift @ARGV or die "Usage: $0 <logfile>\n";

my %stats = (
    total => 0,
    errors => 0,
    warnings => 0
);

try {
    open(my $fh, '<', $logfile)
        or die "Cannot open $logfile: $!\n";
    
    while (my $line = <$fh>) {
        chomp($line);
        $stats{total}++;
        
        if ($line =~ /ERROR/) {
            $stats{errors}++;
        } elsif ($line =~ /WARNING/) {
            $stats{warnings}++;
        }
    }
    
    close($fh);
    
    print "Log statistics:\n";
    print "  Total lines: $stats{total}\n";
    print "  Errors: $stats{errors}\n";
    print "  Warnings: $stats{warnings}\n";
    
} catch {
    die "Error processing log: $_\n";
};
```

### Scenario 2: Data Migration Tool

```perl
#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use Text::CSV;

my $csv_file = shift @ARGV or die "Usage: $0 <csv_file>\n";

my $dbh = DBI->connect(
    "DBI:mysql:database=mydb;host=localhost",
    "user", "password",
    { RaiseError => 1 }
) or die "Cannot connect: $DBI::errstr\n";

my $csv = Text::CSV->new({ auto_diag => 1 });
open(my $fh, '<', $csv_file) or die "Cannot open: $!\n";

my $header = $csv->getline($fh);
my @columns = @$header;

my $sth = $dbh->prepare(
    'INSERT INTO users (' . join(',', @columns) . 
    ') VALUES (' . join(',', ('?') x @columns) . ')'
);

my $count = 0;
while (my $row = $csv->getline($fh)) {
    $sth->execute(@$row);
    $count++;
    print "Inserted $count records\n" if $count % 1000 == 0;
}

close($fh);
$dbh->commit;
$dbh->disconnect;

print "Migration complete: $count records inserted\n";
```

---

## Summary

This guide covers Perl interview questions from basic through advanced levels:

- **Basic**: Core syntax, variables, CPAN, subroutines
- **Intermediate**: References, file handling, functional programming
- **Advanced**: OOP, closures, tie variables, context sensitivity, error handling

**Key Takeaways:**
1. Perl's flexibility (TMTOWTDI) is strength and weakness
2. Regular expressions are fundamental and powerful
3. References enable complex data structures
4. CPAN provides solutions for almost any problem
5. Error handling with try-catch is essential
6. Context sensitivity affects function behavior
7. Modern Perl (Moose, Try::Tiny) improves code quality

**For Interviews:**
- Explain concepts with code examples
- Show understanding of WHY, not just HOW
- Discuss trade-offs and best practices
- Reference CPAN modules where appropriate
- Demonstrate error handling patterns
# Perl Practical Applications & Examples

## Table of Contents
1. [Real-World Use Cases](#real-world-use-cases)
2. [System Administration Scripts](#system-administration-scripts)
3. [Log File Analysis](#log-file-analysis)
4. [Data Processing & ETL](#data-processing--etl)
5. [Web Scraping](#web-scraping)
6. [Text Processing & Parsing](#text-processing--parsing)
7. [Network Programming](#network-programming)
8. [Database Integration](#database-integration)
9. [Performance Optimization](#performance-optimization)
10. [Real-World Projects](#real-world-projects)
11. [Common Pitfalls](#common-pitfalls)
12. [Case Studies](#case-studies)

---

## Real-World Use Cases

### Perl In Production

```
Enterprise Deployment:
├─ System administration: 40%
├─ Web applications: 30%
├─ Data processing: 20%
├─ Log analysis: 10%
└─ Other: Legacy systems, bioinformatics

Scale:
├─ Large financial institutions
├─ Fortune 500 companies
├─ Government agencies
├─ Academic research
└─ Startups and small businesses

Why Still Used:
├─ Powerful text processing
├─ CPAN ecosystem
├─ Backward compatibility
├─ Developer productivity
└─ Existing codebase investment
```

---

## System Administration Scripts

### Use Case: Server Log Monitoring & Reporting

**Scenario:** Monitor system logs and alert on errors

```perl
#!/usr/bin/perl
use strict;
use warnings;
use Time::Local;
use File::Tail;

my $log_file = "/var/log/syslog";
my $error_count = 0;
my @errors = ();

# Monitor log file in real-time
my $tail = File::Tail->new(
    name => $log_file,
    maxinterval => 1
);

while (my $line = $tail->read) {
    chomp($line);
    
    # Check for ERROR patterns
    if ($line =~ /\bERROR\b/i || $line =~ /\bCRITICAL\b/i) {
        $error_count++;
        push @errors, {
            timestamp => time(),
            message => $line
        };
        
        # Alert on critical errors
        if ($line =~ /CRITICAL/) {
            send_alert("CRITICAL", $line);
        }
        
        # Cleanup old errors
        if (scalar @errors > 1000) {
            shift @errors;
        }
    }
}

sub send_alert {
    my ($level, $message) = @_;
    system("echo '$message' | mail -s '$level Alert' admin\@example.com");
}
```

### Use Case: Backup Script

```perl
#!/usr/bin/perl
use strict;
use warnings;
use File::Find;
use File::Copy;
use Time::Local;

my $source_dir = "/var/www";
my $backup_dir = "/backups";
my $today = get_date_string();
my $backup_target = "$backup_dir/backup_$today.tar.gz";

print "Starting backup of $source_dir\n";

# Find all files modified in last 24 hours
my @files_to_backup = ();
find({
    wanted => sub {
        return if -d $_;
        
        # Check if modified in last 24 hours
        if (-M $_ < 1) {
            push @files_to_backup, $_;
        }
    },
    no_chdir => 1
}, $source_dir);

# Create tar archive
my $file_list = join(" ", @files_to_backup);
system("tar czf $backup_target $file_list");

if ($? == 0) {
    print "Backup successful: $backup_target\n";
    
    # Log backup
    open(my $log, '>>', "/var/log/backups.log")
        or die "Cannot write log: $!\n";
    print $log "[$today] Backed up " . scalar(@files_to_backup) 
              . " files\n";
    close($log);
    
    # Cleanup old backups (keep 7 days)
    cleanup_old_backups($backup_dir, 7);
} else {
    die "Backup failed with error: $?\n";
}

sub get_date_string {
    my ($sec, $min, $hour, $mday, $mon, $year) = localtime;
    return sprintf("%04d-%02d-%02d", 
                   $year + 1900, $mon + 1, $mday);
}

sub cleanup_old_backups {
    my ($dir, $days) = @_;
    my $cutoff = time() - ($days * 86400);
    
    opendir(my $dh, $dir) or die "Cannot open $dir: $!\n";
    while (my $file = readdir($dh)) {
        next unless $file =~ /^backup_.*\.tar\.gz$/;
        my $path = "$dir/$file";
        my $mtime = (stat($path))[9];
        
        if ($mtime < $cutoff) {
            unlink($path) or warn "Cannot delete $path: $!\n";
            print "Deleted old backup: $file\n";
        }
    }
    closedir($dh);
}
```

---

## Log File Analysis

### Use Case: Apache Access Log Analysis

```perl
#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $log_file = "/var/log/apache2/access.log";
my %ips = ();
my %status_codes = ();
my %paths = ();
my $total_lines = 0;

# Parse Apache access log
# Format: IP - - [DATE] "METHOD PATH HTTP" STATUS SIZE "REFERER" "AGENT"
open(my $fh, '<', $log_file) 
    or die "Cannot open $log_file: $!\n";

while (my $line = <$fh>) {
    chomp($line);
    $total_lines++;
    
    # Extract components using regex
    if ($line =~ /^(\S+)\s+-\s+-\s+\[([^\]]+)\]\s+"(\w+)\s+(\S+)\s+HTTP\/\S+"\s+(\d{3})\s+(\d+)/) {
        my ($ip, $date, $method, $path, $status, $size) = 
            ($1, $2, $3, $4, $5, $6);
        
        # Count by IP
        $ips{$ip}++;
        
        # Count by status code
        $status_codes{$status}++;
        
        # Count by path
        $paths{$path}++;
    }
}
close($fh);

# Generate report
print "=" x 60 . "\n";
print "Apache Access Log Analysis\n";
print "=" x 60 . "\n";
print "Total Requests: $total_lines\n\n";

# Top 10 IPs
print "Top 10 IP Addresses:\n";
my @top_ips = sort { $ips{$b} <=> $ips{$a} } keys %ips;
for (my $i = 0; $i < 10 && $i < @top_ips; $i++) {
    printf "  %-15s %6d requests\n", $top_ips[$i], $ips{$top_ips[$i]};
}

print "\nStatus Code Distribution:\n";
foreach my $status (sort keys %status_codes) {
    printf "  %s: %d\n", $status, $status_codes{$status};
}

print "\nTop 10 Requested Paths:\n";
my @top_paths = sort { $paths{$b} <=> $paths{$a} } keys %paths;
for (my $i = 0; $i < 10 && $i < @top_paths; $i++) {
    printf "  %-30s %6d hits\n", $top_paths[$i], $paths{$top_paths[$i]};
}
```

### Use Case: Error Log Aggregation

```perl
#!/usr/bin/perl
use strict;
use warnings;
use File::Glob ':glob';
use Digest::MD5 'md5_hex';

my $log_dir = "/var/log/applications";
my %error_patterns = ();
my %error_counts = ();

# Process all log files
foreach my $log_file (glob("$log_dir/*.log")) {
    process_log_file($log_file);
}

# Find most common errors
print "Most Common Error Patterns:\n";
my @sorted = sort { $error_counts{$b} <=> $error_counts{$a} } 
             keys %error_counts;

for (my $i = 0; $i < 10 && $i < @sorted; $i++) {
    my $pattern = $sorted[$i];
    printf "%3d occurrences: %s\n", 
           $error_counts{$pattern}, 
           $error_patterns{$pattern};
}

sub process_log_file {
    my ($file) = @_;
    open(my $fh, '<', $file) or do {
        warn "Cannot open $file: $!\n";
        return;
    };
    
    while (my $line = <$fh>) {
        chomp($line);
        
        # Extract error message
        if ($line =~ /\[ERROR\]\s+(.+)/) {
            my $error = $1;
            
            # Normalize error (remove unique parts like timestamps, IDs)
            my $pattern = normalize_error($error);
            
            if (!exists $error_patterns{$pattern}) {
                $error_patterns{$pattern} = $error;
            }
            $error_counts{$pattern}++;
        }
    }
    close($fh);
}

sub normalize_error {
    my ($error) = @_;
    
    # Remove numbers that vary
    my $normalized = $error;
    $normalized =~ s/\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b/IP/g;
    $normalized =~ s/\d{10,}/NUM/g;
    $normalized =~ s/[a-f0-9]{32,}/HASH/g;
    
    return substr($normalized, 0, 100);  # Limit length
}
```

---

## Data Processing & ETL

### Use Case: CSV to JSON Conversion

```perl
#!/usr/bin/perl
use strict;
use warnings;
use Text::CSV;
use JSON;

my $csv_file = shift @ARGV or die "Usage: perl script.pl input.csv\n";
my $csv = Text::CSV->new({ auto_diag => 1 });

open(my $fh, '<:encoding(utf8)', $csv_file)
    or die "Cannot open $csv_file: $!\n";

# Read header row
my $header = $csv->getline($fh);
my @columns = @$header;

# Convert rows to JSON
my @records = ();
while (my $row = $csv->getline($fh)) {
    my %record = ();
    for (my $i = 0; $i < @columns; $i++) {
        $record{$columns[$i]} = $row->[$i];
    }
    push @records, \%record;
}
close($fh);

# Output as JSON
my $json = JSON->new->pretty(1);
print $json->encode(\@records);
```

### Use Case: Data Validation & Cleaning

```perl
#!/usr/bin/perl
use strict;
use warnings;
use Data::Validate::Email qw(is_email);
use Data::Validate::IP qw(is_ipv4);

my %validation_rules = (
    email => sub { return is_email($_[0]); },
    phone => sub { return $_[0] =~ /^\d{3}-\d{3}-\d{4}$/; },
    zipcode => sub { return $_[0] =~ /^\d{5}(-\d{4})?$/; },
    ip => sub { return is_ipv4($_[0]); },
    age => sub { return $_[0] =~ /^\d+$/ && $_[0] >= 0 && $_[0] <= 150; }
);

sub validate_record {
    my ($record, $schema) = @_;
    my @errors = ();
    
    foreach my $field (keys %$schema) {
        my $type = $schema->{$field};
        my $value = $record->{$field};
        
        unless ($validation_rules{$type}->($value)) {
            push @errors, "Invalid $field: $value";
        }
    }
    
    return @errors ? 0 : 1;
}

sub clean_record {
    my ($record) = @_;
    
    # Trim whitespace
    foreach my $key (keys %$record) {
        $record->{$key} =~ s/^\s+|\s+$//g if defined $record->{$key};
    }
    
    # Convert to lowercase
    if (exists $record->{email}) {
        $record->{email} = lc($record->{email});
    }
    
    return $record;
}

# Usage
my $data = {
    email => "  JOHN@EXAMPLE.COM  ",
    phone => "555-123-4567",
    age => "30"
};

my $cleaned = clean_record($data);
my $schema = {
    email => 'email',
    phone => 'phone',
    age => 'age'
};

if (validate_record($cleaned, $schema)) {
    print "Record is valid\n";
} else {
    print "Record is invalid\n";
}
```

---

## Web Scraping

### Use Case: Website Content Extraction

```perl
#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;
use HTML::Parser;

my $url = "https://example.com/news";

# Create user agent
my $ua = LWP::UserAgent->new;
$ua->agent('Mozilla/5.0');
$ua->timeout(10);

# Fetch page
my $response = $ua->get($url);
die "Failed to fetch $url: ", $response->status_line 
    unless $response->is_success;

my $content = $response->content;

# Parse HTML and extract headlines
my @headlines = ();
my $in_headline = 0;

my $parser = HTML::Parser->new(
    start_h => [\&handle_start, "tagname, attr"],
    end_h => [\&handle_end, "tagname"],
    text_h => [\&handle_text, "dtext"]
);

sub handle_start {
    my ($tag, $attr) = @_;
    if ($tag eq 'h2' && $attr->{class} && $attr->{class} eq 'headline') {
        $in_headline = 1;
    }
}

sub handle_end {
    my ($tag) = @_;
    if ($tag eq 'h2') {
        $in_headline = 0;
    }
}

sub handle_text {
    my ($text) = @_;
    if ($in_headline && $text =~ /\S/) {
        push @headlines, $text;
    }
}

$parser->parse($content);

# Print results
print "Found " . scalar(@headlines) . " headlines:\n";
foreach my $headline (@headlines) {
    print "  - $headline\n";
}
```

---

## Text Processing & Parsing

### Use Case: Configuration File Parser

```perl
#!/usr/bin/perl
use strict;
use warnings;

my $config_file = shift @ARGV or die "Usage: perl script.pl config.ini\n";
my %config = ();
my $current_section = '';

open(my $fh, '<', $config_file) 
    or die "Cannot open $config_file: $!\n";

while (my $line = <$fh>) {
    chomp($line);
    
    # Skip comments and empty lines
    next if $line =~ /^\s*#/ || $line =~ /^\s*$/;
    
    # Section header [section_name]
    if ($line =~ /^\s*\[(\w+)\]\s*$/) {
        $current_section = $1;
        $config{$current_section} = {} unless exists $config{$current_section};
        next;
    }
    
    # Key=value pair
    if ($line =~ /^\s*(\w+)\s*=\s*(.+?)\s*$/) {
        my ($key, $value) = ($1, $2);
        
        if ($current_section) {
            # Remove quotes if present
            $value =~ s/^["']|["']$//g;
            
            # Handle arrays
            if ($value =~ /,/) {
                my @values = split(/\s*,\s*/, $value);
                $config{$current_section}{$key} = \@values;
            } else {
                $config{$current_section}{$key} = $value;
            }
        }
    }
}
close($fh);

# Usage
if (exists $config{database}{host}) {
    print "Database host: ", $config{database}{host}, "\n";
}

# Print entire config
foreach my $section (keys %config) {
    print "[$section]\n";
    foreach my $key (keys %{$config{$section}}) {
        my $value = $config{$section}{$key};
        if (ref($value) eq 'ARRAY') {
            print "  $key = ", join(", ", @$value), "\n";
        } else {
            print "  $key = $value\n";
        }
    }
    print "\n";
}
```

---

## Network Programming

### Use Case: Simple HTTP Server

```perl
#!/usr/bin/perl
use strict;
use warnings;
use IO::Socket::INET;
use Encode;

my $port = 8080;
my $server = IO::Socket::INET->new(
    Proto => 'tcp',
    LocalAddr => 'localhost',
    LocalPort => $port,
    Listen => 5,
    Reuse => 1
) or die "Cannot create socket: $!\n";

print "Server listening on port $port\n";
print "Visit http://localhost:$port/ in your browser\n";

while (my $client = $server->accept()) {
    $client->autoflush(1);
    
    # Read request
    my @request = ();
    while (my $line = <$client>) {
        chomp($line);
        last if $line eq '';
        push @request, $line;
    }
    
    my $request_line = $request[0];
    my ($method, $path, $protocol) = split(/ /, $request_line);
    
    # Build response
    my $response;
    if ($path eq '/') {
        $response = generate_html("Welcome to Perl HTTP Server");
    } elsif ($path eq '/api/time') {
        $response = generate_json({ time => time() });
    } else {
        $response = generate_error(404, "Not Found");
    }
    
    # Send response
    print $client $response;
    close($client);
}

sub generate_html {
    my ($body) = @_;
    my $html = <<"EOF";
HTTP/1.1 200 OK
Content-Type: text/html

<html>
<head><title>Perl Server</title></head>
<body>
<h1>$body</h1>
</body>
</html>
EOF
    return $html;
}

sub generate_json {
    my ($data) = @_;
    my $json = '{"time":' . $data->{time} . '}';
    return "HTTP/1.1 200 OK\r\n" .
           "Content-Type: application/json\r\n" .
           "Content-Length: " . length($json) . "\r\n\r\n" .
           $json;
}

sub generate_error {
    my ($code, $msg) = @_;
    return "HTTP/1.1 $code $msg\r\n" .
           "Content-Type: text/plain\r\n\r\n" .
           "Error: $code $msg\n";
}
```

---

## Database Integration

### Use Case: Database Operations with DBI

```perl
#!/usr/bin/perl
use strict;
use warnings;
use DBI;

# Connect to database
my $dbh = DBI->connect(
    "DBI:mysql:database=mydb;host=localhost",
    "user", "password",
    { RaiseError => 1, AutoCommit => 1 }
) or die "Cannot connect: $DBI::errstr\n";

# Insert data
my $insert_sth = $dbh->prepare(
    'INSERT INTO users (name, email, age) VALUES (?, ?, ?)'
);

my @users = (
    ['Alice', 'alice@example.com', 30],
    ['Bob', 'bob@example.com', 25],
    ['Charlie', 'charlie@example.com', 35]
);

foreach my $user (@users) {
    $insert_sth->execute(@$user);
    print "Inserted: $user->[0]\n";
}

# Query data
my $select_sth = $dbh->prepare(
    'SELECT id, name, email, age FROM users WHERE age > ?'
);
$select_sth->execute(25);

print "\nUsers older than 25:\n";
while (my $row = $select_sth->fetchrow_hashref) {
    printf "  %d. %s (%s), age %d\n",
           $row->{id}, $row->{name}, $row->{email}, $row->{age};
}

# Update data
my $update_sth = $dbh->prepare(
    'UPDATE users SET age = ? WHERE name = ?'
);
$update_sth->execute(31, 'Alice');
print "\nUpdated Alice's age\n";

# Delete data
my $delete_sth = $dbh->prepare(
    'DELETE FROM users WHERE age < ?'
);
$delete_sth->execute(30);
print "Deleted users younger than 30\n";

# Transaction example
eval {
    $dbh->begin_work;
    
    $insert_sth->execute('David', 'david@example.com', 40);
    $insert_sth->execute('Emma', 'emma@example.com', 28);
    
    $dbh->commit;
    print "Transaction committed\n";
};
if ($@) {
    $dbh->rollback;
    die "Transaction failed: $@\n";
}

# Disconnect
$dbh->disconnect;
```

---

## Performance Optimization

### Case Study: Optimizing Large File Processing

```perl
#!/usr/bin/perl
use strict;
use warnings;

# INEFFICIENT: Loading entire file into memory
sub inefficient_process {
    my ($file) = @_;
    open(my $fh, '<', $file) or die "Cannot open: $!\n";
    my @lines = <$fh>;  # Load all lines
    close($fh);
    
    my $count = 0;
    foreach my $line (@lines) {
        chomp($line);
        $count++ if $line =~ /ERROR/;
    }
    return $count;
}

# EFFICIENT: Line-by-line processing
sub efficient_process {
    my ($file) = @_;
    open(my $fh, '<', $file) or die "Cannot open: $!\n";
    
    my $count = 0;
    while (my $line = <$fh>) {
        $count++ if $line =~ /ERROR/;
    }
    close($fh);
    return $count;
}

# MOST EFFICIENT: Pre-compiled regex
sub optimized_process {
    my ($file) = @_;
    open(my $fh, '<', $file) or die "Cannot open: $!\n";
    
    my $error_regex = qr/ERROR/;
    my $count = 0;
    while (my $line = <$fh>) {
        $count++ if $line =~ $error_regex;
    }
    close($fh);
    return $count;
}

# Performance comparison
my $large_file = "/var/log/largelog.txt";

use Time::HiRes 'time';

my $start = time();
my $result1 = inefficient_process($large_file);
my $time1 = time() - $start;

$start = time();
my $result2 = efficient_process($large_file);
my $time2 = time() - $start;

$start = time();
my $result3 = optimized_process($large_file);
my $time3 = time() - $start;

printf "Inefficient: %.3f seconds (loaded all)\n", $time1;
printf "Efficient: %.3f seconds (line by line)\n", $time2;
printf "Optimized: %.3f seconds (pre-compiled regex)\n", $time3;
```

---

## Real-World Projects

### Project: System Monitoring Dashboard

```perl
#!/usr/bin/perl
use strict;
use warnings;
use JSON;
use Sys::Statistics::Linux;

my $lxs = Sys::Statistics::Linux->new(
    cputime => 1,
    memstats => 1,
    netstats => 1,
    diskstats => 1,
    diskusage => 1
);

$lxs->init;

# Collect initial stats
sleep 1;
$lxs->init;

# Get current stats
my $stats = $lxs->get;

# Build JSON response
my $data = {
    timestamp => time(),
    cpu => {
        user => $stats->{cputime}->{user},
        system => $stats->{cputime}->{system},
        load_average => $stats->{cpustats}->{cpu}[0]{load}
    },
    memory => {
        total => $stats->{memstats}->{memtotal},
        used => $stats->{memstats}->{memused},
        free => $stats->{memstats}->{memfree},
        percent => sprintf("%.1f", 
            ($stats->{memstats}->{memused} / 
             $stats->{memstats}->{memtotal}) * 100)
    },
    disk => {
        root => {
            total => $stats->{diskusage}->{root}->{total},
            used => $stats->{diskusage}->{root}->{used},
            percent => $stats->{diskusage}->{root}->{percent}
        }
    }
};

print JSON->new->pretty(1)->encode($data);
```

---

## Common Pitfalls

### Pitfall 1: Uninitialized Variables

```perl
# WRONG: Undefined variable causes warning
my $count;
$count++;  # Warning: Use of uninitialized value

# CORRECT: Initialize variable
my $count = 0;
$count++;

# Or handle carefully
my $value = defined $value ? $value + 1 : 1;
```

### Pitfall 2: File Handle Not Closed

```perl
# WRONG: File not closed, resources leaked
open(my $fh, '<', 'file.txt');
my @lines = <$fh>;
# Missing: close($fh);

# CORRECT: Always close
open(my $fh, '<', 'file.txt') or die "Cannot open: $!\n";
my @lines = <$fh>;
close($fh);

# BEST: Use lexical filehandle (auto-closes at scope end)
open(my $fh, '<', 'file.txt') or die "Cannot open: $!\n";
while (my $line = <$fh>) {
    # Process
}  # Auto-closed here
```

### Pitfall 3: Regex with Interpolation

```perl
# WRONG: Regex compiled each time
foreach my $pattern (@patterns) {
    if ($text =~ /$pattern/) {  # Recompiled each iteration
        # Process
    }
}

# CORRECT: Compile once
my @compiled = map { qr/$_/ } @patterns;
foreach my $regex (@compiled) {
    if ($text =~ $regex) {
        # Process
    }
}
```

---

## Case Studies

### Case Study 1: Log Parser for Application Monitoring

**Scenario:** Parse 10GB daily logs, extract errors, send alerts

```perl
#!/usr/bin/perl
use strict;
use warnings;
use File::Tail;
use Net::SMTP;

my $log_file = "/var/log/application.log";
my %errors = ();
my $error_threshold = 100;

# Real-time log monitoring
my $tail = File::Tail->new(
    name => $log_file,
    maxinterval => 5
);

print "Monitoring $log_file...\n";

while (my $line = $tail->read) {
    chomp($line);
    
    if ($line =~ /\[(ERROR|CRITICAL)\]\s+(.+)/) {
        my ($level, $message) = ($1, $2);
        my $pattern = normalize($message);
        
        $errors{$pattern}++;
        
        # Alert on threshold
        if ($errors{$pattern} == $error_threshold) {
            send_alert($level, $pattern, $errors{$pattern});
        }
    }
}

sub normalize {
    my ($msg) = @_;
    $msg =~ s/\d+/NUM/g;
    return substr($msg, 0, 80);
}

sub send_alert {
    my ($level, $pattern, $count) = @_;
    
    my $subject = "[$level Alert] Error threshold exceeded";
    my $body = "Error pattern: $pattern\nCount: $count\n";
    
    # In real system, use proper email service
    print "ALERT: $subject - $body";
}
```

### Case Study 2: Data Migration Tool

```perl
#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use File::Slurp 'read_file';

my $source_file = $ARGV[0] or die "Usage: perl script.pl source.csv\n";

# Connect to destination database
my $dbh = DBI->connect(
    "DBI:mysql:database=target_db;host=localhost",
    "user", "password",
    { RaiseError => 1 }
) or die "Cannot connect: $DBI::errstr\n";

# Prepare statement
my $sth = $dbh->prepare(
    'INSERT INTO customers (id, name, email, created_at) VALUES (?, ?, ?, ?)'
);

# Read and process CSV
open(my $fh, '<', $source_file) or die "Cannot open: $!\n";
my $header = <$fh>;  # Skip header
my $count = 0;
my $errors = 0;

while (my $line = <$fh>) {
    chomp($line);
    my ($id, $name, $email) = split(/,/, $line);
    
    eval {
        $sth->execute($id, $name, $email, time());
        $count++;
    };
    if ($@) {
        warn "Error inserting record: $@\n";
        $errors++;
    }
    
    # Commit every 1000 records
    if ($count % 1000 == 0) {
        $dbh->commit;
        print "Inserted $count records...\n";
    }
}
close($fh);
$dbh->commit;

print "Migration complete: $count records inserted, $errors errors\n";
$dbh->disconnect;
```

---

## Summary

### Key Perl Strengths

1. **Text Processing** - Regex, string manipulation, parsing
2. **System Administration** - Scripts, automation, monitoring
3. **Rapid Development** - Less boilerplate, flexible syntax
4. **CPAN Ecosystem** - 250,000+ modules for any task
5. **Cross-Platform** - Works on Windows, Linux, Mac
6. **Legacy Maintenance** - Large installed base, still widely used

### Key Takeaways

- Use `strict` and `warnings` in all scripts
- Initialize variables properly
- Always close file handles
- Use lexical variables (my) instead of package variables
- Pre-compile regexes in loops for performance
- Handle errors with eval blocks
- Leverage CPAN modules for common tasks
- Write tests for complex logic

---

## References

- Perl Official Website (perl.org)
- CPAN Module Repository
- PerlMonks Community
- "Modern Perl" by Chromatic
- "Programming Perl" (Camel Book)
- Perl Cookbook
