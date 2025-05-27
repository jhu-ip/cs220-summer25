---
id: hw0
layout: default
title: Homework 0
---

<div class='admonition caution'>
<div class='title'>Caution</div>
<div class='content'>
<ul>
<li>You are expected to work individually.</li>
<li><strong>Due: Monday, June 2nd (11pm Baltimore time).</strong></li>
<li><em>This assignment is worth 20 points.</em></li>
</ul>
</div>
</div>

## Learning Objectives
<div class='admonition success'>
<div class='title'>Objectives</div>
<div class='content'>
<ul>
<li>editing a C source file,</li>
<li>compiling and executing a C program.</li>
</ul>
<p>Tools/technologies:</p>
<ul>
<li><code>git</code></li>
<li><code>zip</code> up multiple files</li>
<li>transferring files from ugrad to a local machine using <code>scp</code>/<code>pscp</code></li>
<li>submitting to Gradescope.</li>
</ul>
</div>
</div>

### Part 1
<div class='admonition caution'>
<div class='title'>Caution</div>
<div class='content'>
<p>You should receive an invitation to the jhu-ip organization and your
private repository by <strong>Friday, May 30th</strong>. If you
haven't received it, post privately for all instructors on Piazza.</p>
</div>
</div>

In your private git repository (created for you on Github under jhu-ip
organization), create a new folder named **homework**, then a subfolder
named **hw0**. In that *hw0* subfolder, create three separate C source
files with names given below that output **exactly** the messages shown
below. In each case, the desired output message should be followed by
a newline ("\n") character.

<div class='admonition tip'>
<div class='title'>Tip</div>
<div class='content'>
<p>
The "hello, world" program that was the starting point for <a
href="../exercise/ex03b.html">Exercise 3-B</a> could be a useful
starting point for the source files for this homework.
</p>
</div>
</div>

At the top of each source file, be sure to add two comment lines that indicate your name followed by your JHED ID, e.g.:

```c
//Homer Simpson
//hsimp999
```

The behavior of each program is as follows:

file name | desired output
--------- | --------------
*one.c* | The first prize goes to Jennifer.
*two.c* | The second prize goes to Gongqi.
*three.c* | The third prize goes to Pat.

Compile and execute each of the three programs and ensure that they give
the output exactly as shown. Finally, add all three source files to your
git repository, commit them with an appropriate message, and push.

### Part 2
Create a text file named gitlog.txt which demonstrates your recent git activity by typing the command `git log > gitlog.txt`

<div class='admonition tip'>
<div class='title'>Tip</div>
<div class='content'>
<p>You can optionally view the contents of the newly created file by typing <code>less gitlog.txt</code></p>
</div>
</div>

### Part 3
Create a *.zip* file named *hw0.zip* which contains exactly the following
four files: **three.c, two.c, one.c, gitlog.txt**. Copy the *hw0.zip*
file to your local machine, and submit it via Gradescope.  Specifically:

* Open the invitation email you should have received from team@gradescope.com (subject: “Welcome to Gradescope for 601.220”).
* Follow the instructors to set your password.
* Upon logging in, click 601.220.
* Click Homework 0.
* Click Submit (or Resubmit if you have done this before).
* Drag your zip file onto the Drag & Drop box (or click the box and select the zip file).
* Click Upload. You should see a confirmation that the submission uploaded successfully.

When you submit, Gradescope conducts a series of automatic tests. These
tests do basic things like check that you submitted the right files and
that your `.c` files compile properly. If you see error messages here
(look for red), address them and resubmit.

<div class='admonition tip'>
<div class='title'>Tip</div>
<div class='content'>
<p>You may re-submit any number of times prior to the deadline; only your latest submission will be graded.</p>
</div>
</div>

Two notes regarding automatic checks for programming assignments:

* Passing an automatic check is not itself worth points. (There might be a
  nominal, low point value like 0.01 associated with a check, but that will
  not count in the end.) The checks exist to help you and the graders find
  obvious errors. This will be true for most of the assignments; the actual
  grades are given manually by the graders, along with feedback comments.

* The automatic checks cover some of the requirements set out in the
  assignment, but not all. For this assignment, you will notice that the
  *third.c* program is checked, but not the other two. In general, *it
  is up to you to test your own work* and ensure your programs satisfy
  all stated requirements. Passing all the automatic checks does not
  necessarily mean you will earn all the points.

