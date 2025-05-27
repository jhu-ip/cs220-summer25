---
id: hw1
layout: default
title: Homework 1
---

<div class='admonition caution'>
<div class='title'>Caution</div>
<div class='content'>
<ul>
<li>You are expected to work individually.</li>
<li><strong>Due: Wednesday, June 9th at 11pm EST (Baltimore time).</strong></li>
<li><em>This assignment is worth 60 points.</em></li>
</ul>
</div>
</div>

## Learning Objectives
<div class='admonition success'>
<div class='title'>Objectives</div>
<div class='content'>
<ul>
<li>arithmetic operators</li>
<li>control structures</li>
<li>input collection and validation</li>
<li>version control using git</li>
</ul>
</div>
</div>


## Overview
In this assignment, you will create a C program that simulates a vending machine. The machine can sell cola for 75 cents, a candy bar for $1.25, and popcorn for 50 cents. At the start, the machine holds five of each item.

The program will begin by showing the user a welcome message, instructions and a menu, showing the items available (including how many are left in stock) and their prices. The program will then read the purchase choice represented as an integer corresponding to the desired menu entry and the amount of money inserted into the machine (formatted as dollars and cents).

If the choice is valid, it is in stock, and sufficient money was entered, the program will output that the item is dispensed and display the change returned to the user. At this point, the program should also display the remaining count for each item as well as the total money the machine earned so far. As long as the input is valid, the program should continue to run until the user chooses to quit. If the choice is not valid, the item is sold out, or insufficient money was inserted, the program should output an appropriate error according to the specifications below. Your output must match the sample runs below exactly with respect to these messages, spacing, etc.

The program should read user data from standard input and output the results to standard output. If there is an error in the format of the user input, then you will identify the error type and print an appropriate message and end the program. See the details and Example Runs section below.

### Program Requirements

- The input expression will contain non-zero length menu item-dollar amount pairs. 
  - An integer will indicate the menu item.
  - A decimal value (Assume user puts two decimal places or less) will represent the money inserted (the input will not contain the dollar sign.)

- Monetary results printed out by the program should be preceded by the dollar sign and contain exactly two decimal places (even if they hold zero values.)

- A successful run will return with value `0`.

- Your program must validate the user's input and catch any errors.
  - If the user inputs an expression which is not well-formed (for example missing inputs, the amount of money entered is negative, etc.), your program will report the error message `malformed expression` followed by a new line and end immediately with a return value of `1`. 
  - If the user inputs an expression with an invalid item (not on the menu, out of stock, etc.), your program will report the error message `invalid item` followed by a new line and end immediately with a return value of `2`.  Note that this error message includes the case where the entered item number is negative.
  - If the user inputs an expression with not enough money (but not negative), your program will report the error message `Not enough money` followed by a new line and end immediately with a return value of `3`. Since the input should be evaluated sequentially, the program should exit with the first error found regardless of the number of errors in the full expression.
  - The program should catch the first error in the sequence and exit the program. At most one of "malformed expression" or "invalid unit" will apply to a given input, since the program is immediately terminated once one or the other is detected.<br><br>

- Note that your program will continue collecting (parts of) the expression entered by the user as long as it is well-formed. A proper expression may contain one or more of any kind of whitespace (spaces, tabs, newlines) between selected items and the inserted money. As such, the user will press **ctrl-d** to indicate the end of the input.  

<div class='admonition tip'>
<div class='title'>Tip</div>
<div class='content'>
<p>
In some situations, the user will need to press <code>ctrl-d</code>` twice in a row.
</p>
</div>
</div>

## Development Requirements

In the homework folder of your private repository (`2023-summer-student-JHED`), you should create a new subfolder named `hw1`. In that `hw1` subfolder, you will create your program in a new C source file named `hw1.c`. At the top of the file, add a comment with your six character alphanumeric **Hopkins ID**. (Please do not include your name or JHED so as to allow for blind grading.)

Throughout your work on this assignment, be sure to frequently add, commit (supplying meaningful messages) and push your changes to your personal git repository.  After you complete your work on the assignment, you will be asked to submit a *gitlog.txt* file, just as in Homework 0. However, we expect your log for this homework to show more activity.

Recall that your code is always expected to compile without errors or warnings, on the ugrad servers. Submissions which do not compile properly may earn zero points, so be sure to submit to Gradescope early and often! And once you get a good start on the assignment, always have some earlier compiling version of your work pushed up to Github.

### Example Runs

Here are several samples runs of the program on ugrad, where $ denotes the command prompt, and user input is shown in **bold**. Note that the first line shown below is the command you are expected to use as you compile your program (and the one that will be used by the graders).  The compilation line should report zero errors and warnings, as demonstrated below:

Example 1

<div class="highlighter-rouge"><pre>
$ <b>gcc -std=c99 -pedantic -Wall -Wextra hw1.c</b>
$ <b>./a.out</b>
Welcome to the Vending Machine!
Enter your choice by # and input cash amount, repeatedly (^d to end).
[0] 5 cola left: cost is $0.75
[1] 5 candybar left: cost is $1.25
[2] 5 popcorn left: cost is $0.50
Money made so far is $0.00
<b>0 1.00</b>
cola is dispensed and $0.25 returned
[0] 4 cola left: cost is $0.75
[1] 5 candybar left: cost is $1.25
[2] 5 popcorn left: cost is $0.50
Money made so far is $0.75
<i>(user types ctrl-d) </i>
Thanks for your patronage!
</pre></div>

Example 2

<div class="highlighter-rouge"><pre>
$ <b>./a.out</b>
Welcome to the Vending Machine!
Enter your choice by # and input cash amount, repeatedly (^d to end).
[0] 5 cola left: cost is $0.75
[1] 5 candybar left: cost is $1.25
[2] 5 popcorn left: cost is $0.50
Money made so far is $0.00
<b>0 2.00 1 3.00</b>
cola is dispensed and $1.25 returned
[0] 4 cola left: cost is $0.75
[1] 5 candybar left: cost is $1.25
[2] 5 popcorn left: cost is $0.50
Money made so far is $0.75
candybar is dispensed and $1.75 returned
[0] 4 cola left: cost is $0.75
[1] 4 candybar left: cost is $1.25
[2] 5 popcorn left: cost is $0.50
Money made so far is $2.00
<i>(user types ctrl-d)</i>
Thanks for your patronage!
</pre></div>

Example 3

<div class="highlighter-rouge"><pre>
$ <b>./a.out</b>
Welcome to the Vending Machine!
Enter your choice by # and input cash amount, repeatedly (^d to end).
[0] 5 cola left: cost is $0.75
[1] 5 candybar left: cost is $1.25
[2] 5 popcorn left: cost is $0.50
Money made so far is $0.00
<b>0 2 1 3 2 10</b>
cola is dispensed and $1.25 returned
[0] 4 cola left: cost is $0.75
[1] 5 candybar left: cost is $1.25
[2] 5 popcorn left: cost is $0.50
Money made so far is $0.75
candybar is dispensed and $1.75 returned
[0] 4 cola left: cost is $0.75
[1] 4 candybar left: cost is $1.25
[2] 5 popcorn left: cost is $0.50
Money made so far is $2.00
popcorn is dispensed and $9.50 returned
[0] 4 cola left: cost is $0.75
[1] 4 candybar left: cost is $1.25
[2] 4 popcorn left: cost is $0.50
Money made so far is $2.50
<i>(user types ctrl-d)</i>
Thanks for your patronage!
</pre></div>

Example 4

<div class="highlighter-rouge"><pre>
$ <b>./a.out</b>
Welcome to the Vending Machine!
Enter your choice by # and input cash amount, repeatedly (^d to end).
[0] 5 cola left: cost is $0.75
[1] 5 candybar left: cost is $1.25
[2] 5 popcorn left: cost is $0.50
Money made so far is $0.00
<b>cola 1</b>
malformed expression
</pre></div>

Example 5

<div class="highlighter-rouge"><pre>
$ <b>./a.out</b>
Welcome to the Vending Machine!
Enter your choice by # and input cash amount, repeatedly (^d to end).
[0] 5 cola left: cost is $0.75
[1] 5 candybar left: cost is $1.25
[2] 5 popcorn left: cost is $0.50
Money made so far is $0.00
<b>3 12 </b>
invalid item
</pre></div>

Example 6

<div class="highlighter-rouge"><pre>
$ <b>./a.out</b>
Welcome to the Vending Machine!
Enter your choice by # and input cash amount, repeatedly (^d to end).
[0] 5 cola left: cost is $0.75
[1] 5 candybar left: cost is $1.25
[2] 5 popcorn left: cost is $0.50
Money made so far is $0.00
<b>2 -12.22</b>
malformed expression
</pre></div>

Example 7 (note that the program exits with the first error parsed)

<div class="highlighter-rouge"><pre>
$ <b>./a.out</b>
Welcome to the Vending Machine!
Enter your choice by # and input cash amount, repeatedly (^d to end).
[0] 5 cola left: cost is $0.75
[1] 5 candybar left: cost is $1.25
[2] 5 popcorn left: cost is $0.50
Money made so far is $0.00
<b>Mark 0.00</b>
malformed expression
</pre></div>

Example 8 (spaces and new lines should be ignored)

<div class="highlighter-rouge"><pre>
$ <b>./a.out</b>
Welcome to the Vending Machine!
Enter your choice by # and input cash amount, repeatedly (^d to end).
[0] 5 cola left: cost is $0.75
[1] 5 candybar left: cost is $1.25
[2] 5 popcorn left: cost is $0.50
Money made so far is $0.00
<b>   2                3</b>
popcorn is dispensed and $2.50 returned
[0] 5 cola left: cost is $0.75
[1] 5 candybar left: cost is $1.25
[2] 4 popcorn left: cost is $0.50
Money made so far is $0.50
<i>(user types ctrl-d)</i>
Thanks for your patronage!
</pre></div>

Example 9

<div class="highlighter-rouge"><pre>
$ <b>./a.out</b>
Welcome to the Vending Machine!
Enter your choice by # and input cash amount, repeatedly (^d to end).
[0] 5 cola left: cost is $0.75
[1] 5 candybar left: cost is $1.25
[2] 5 popcorn left: cost is $0.50
Money made so far is $0.00
<b>2 0.00</b>
Not enough money
</pre></div>

Example 10 (pretending cola starts with 1 stock to show what happens when buying from 0 stock)

<div class="highlighter-rouge"><pre>
$ <b>./a.out</b>
Welcome to the Vending Machine!
Enter your choice by # and input cash amount, repeatedly (^d to end).
[0] 1 cola left: cost is $0.75
[1] 5 candybar left: cost is $1.25
[2] 5 popcorn left: cost is $0.50
Money made so far is $0.00
<b>0 1</b>
cola is dispensed and $0.25 returned
[0] 0 cola left: cost is $0.75
[1] 5 candybar left: cost is $1.25
[2] 5 popcorn left: cost is $0.50
Money made so far is $0.75
<b>0 2</b>
invalid item
</pre></div>

<div class='admonition tip'>
<div class='title'>Tip</div>
<div class='content'>
<p>There may be other ways for the input expressions to be malformed, besides the ways shown above. You must be careful to check for all the various ways it might be malformed.</p>
</div>
</div>

### Submission
Create a *.zip* file named *hw1.zip* which contains only **hw1.c** and **gitlog.txt**. (Do not zip your entire hw1 folder - only these two files.) Copy the *hw1.zip* file to your local machine and submit it as Homework 1 on Gradescope. 

Recall you can create your `gitlog.txt` file by running `git log > gitlog.txt`.

When you submit, Gradescope conducts a series of automatic tests.  These tests do basic checks like making sure that you submitted the right files and that your `.c` file compiles properly.  If you see error messages here (look for red), address them and resubmit.

<div class='admonition danger'>
<div class='title'>No-compile Policy</div>
<div class='content'>
<p>Remember that if your final submitted code does not compile, you will earn a zero score for the assignment.</p>
</div>
</div>

<div class='admonition tip'>
<div class='title'>Tip</div>
<div class='content'>
<p>You may re-submit any number of times prior to the deadline; only your latest submission will be graded.</p>
</div>
</div>

<div class='admonition info'>
<div class='title'>Info</div>
<div class='content'>
<p>Review the course syllabus for late submission policies (grace period and late days). You will want to save your late days for the future assignments as they will be more involved.</p>
</div>
</div>

You should also make sure that your code has good style. You can look at the [coding style guidelines here](https://jhucsf.github.io/spring2021/assign/style.html) from a course you will take later that also applies to this course. In brief, you should make sure that your submission is well formed:

- it is not overcommented or undercommented
- there are no ambiguous variable names 
- proper/consistent bracket placements and indentation
- no global variables

Two notes regarding automatic checks for programming assignments:
*	Passing an automatic check is not itself worth points. (There might be a nominal, low point value like 0.01 associated with a check, but that will not count in the end.) The checks exist to help you and the graders find obvious errors. This will be true for most of the assignments; the actual grades are given manually by the graders, along with comments.
*	The automatic checks cover some of the requirements set out in the assignment, but not all. There will be hidden tests that test edge cases. In general, it is up to you to test your own work and ensure your programs satisfy all stated requirements. Passing all the automatic checks does not necessarily mean you will earn all the points.
