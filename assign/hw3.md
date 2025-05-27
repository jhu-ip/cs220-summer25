---
id: hw3
layout: default
title: Homework 3
---

<div class='admonition caution'>
<div class='title'>Caution</div>
<div class='content'>
<ul>
<li>You are expected to work individually.</li>
<li><strong>Due: Monday, June 16th at 11pm EDT (Baltimore time).</strong></li>
<li><em>This assignment is worth 60 points.</em></li>
</ul>
</div>
</div>

## Learning Objectives
<div class='admonition success'>
<div class='title'>Objectives</div>
<div class='content'>
<ul>
<li>array, c-string</li>
<li>writing functions</li>
<li>recursion</li>
<li>command-line arguments</li>
<li>file I/O</li>
<li>makefile</li>
<li>development tools <code>gdb</code> and <code>git</code></li>
</ul>
</div>
</div>

## Overview - Maze generator and solver

In this assignment, you are going to implement a simple maze solver. We have also provided a maze generator. As such, your main program `hw3` has two usages:

```
Generate maze usage: ./hw3 <maze file> <width> <height> [threshold = 0.5] [seed = 0]
Solve maze usage: ./hw3 <maze file>
```

The first command line will generate a maze with size `<width> x <height>` saved as a text file in `<maze file>`. `[threshold]` and `[seed]` are optional parameters for maze generation, which will be described in the program specification section. The second usage will solve the maze provided by `<maze file>`. Here are some sample runs to illustrate the idea. (User input is in **bold**.)

<div class="highlighter-rouge"><pre>
$ <b>./hw3</b>
Generate maze usage: ./hw3 &lt;maze file&gt; &lt;width&gt; &lt;height&gt; [threshold = 0.5] [seed = 0]
Solve maze usage: ./hw3 &lt;maze file&gt;
$ <b>./hw3 test0.txt 10 10</b>
Maze: 10, 10
##########
##  # # ##
# ##### ##
#   #    #
##&lt; ### ##
## # ### #
##  ## ###
#  ##   @#
#   ### ##
##########
$ <b>./hw3 test0.txt</b>
Maze: 10, 10
##########
##  # # ##
# ##### ##
#   #    #
##&lt; ### ##
## # ### #
##  ## ###
#  ##   @#
#   ### ##
##########
Info: No solution found for the input maze
$ <b>./hw3 test1.txt 10 10 0.8</b>
Maze: 10, 10
##########
##       #
#  ##    #
#   #    #
##&lt;  #   #
#  #     #
##  ## # #
#   #   @#
#   ###  #
##########
$ <b>./hw3 test1.txt</b>
Maze: 10, 10
##########
##       #
#  ##    #
#   #    #
##&lt;  #   #
#  #     #
##  ## # #
#   #   @#
#   ###  #
##########
Solution path (&#42;):
##########
##       #
#  ##    #
#   #    #
##&lt;**#   #
#  #***  #
##  ##*# #
#   # **@#
#   ###  #
##########
</pre></div>

## Program Specification

### Getting started

Get started by creating a `homework/hw3` directory in your clone of your personal git repository, and copying the `hw3` starter code from the course public repository. Note that you will need to do a `git pull` in the public repository to make sure that your clone is up to date, otherwise it might not have the starter code yet.

The following commands should work to get you started (assuming that you renamed your personal repository clone as `~/my220repo`):

```
cd ~/cs220-summer22-public
git pull
cd ~/my220repo
mkdir -p homework/hw3
cd homework/hw3
cp ~/cs220-summer22-public/homework/hw3/* .
```

### Starter codes and Makefile

The main goal of this assignment is for you to practice breaking a program down into functions and modularizing your code. In the starter code, you will find the following files:

1. `hw3.c` is the main driver function; it checks and parses the command line arguments, and calls functions to complete the main logic.
2. `print_functions.[c|h]` is a module for all print-related functions.
3. `maze.[c|h]` is the maze module which provides all maze-related functionalities.

We also provide you with some maze files for testing your program. To start the project, you **must** create a `Makefile` that compiles each source file into an object file and then links them together into a target called `hw3`. [Note, your output program must be called `hw3`. Otherwise, it may fail all the testing.]

Read the comments in the code carefully to get a sense of what each function is supposed to do. Details are provided in the `*.h` files, not the `*.c` files. Your task is to implement all the functions where indicated. You will also need to add two function declarations to one of the header files. You are free to create your own additional helper functions as well.

<div class='admonition tip'>
<div class='title'>Maze size limit</div>
<div class='content'>
<p>You can assume that the mazes this program operates on are no more than 200x200 characters in size, including the outer walls. This upper bound is encoded into the provided starter files.</p>
</div>
</div>

### Command line arguments
Your program should accept two usages: one for generating a maze and one for solving the maze. If the program is launched with an incorrect number of arguments supported by these usages, your program should display this correct usage message:
```
Generate maze usage: ./hw3 <maze file> <width> <height> [threshold = 0.5] [seed = 0]
Solve maze usage: ./hw3 <maze file>
```
In addition, your program should terminate with a return code of `2` when called incorrectly. Finish the condition checking in `hw3.c` and implement the message printing in the `printError` function in `print_functions.c`.

### Maze generator
```
Generate maze usage: ./hw3 <maze file> <width> <height> [threshold = 0.5] [seed = 0]
```
To generate a maze, your program accepts at least 3 arguments: the output maze filename `<maze file>`, the maze width `<width>`, and the maze height `<height>`. It can accept two more optional arguments `[threshold]` and `[seed]`. When they are not provided, `[threshold]` and `[seed]` should have default values of `0.5` and `0` respectively. Your program should check that `<width>` and `<height>` are positive integers. If they are invalid input, your program should terminate and return an error code `-3`. You don't need to perform any input validation for `[threshold]` and `[seed]`. Finish the command line argument parsing logic in `hw3.c` for that.

<div class='admonition tip'>
<div class='title'>Converting a string to an integer or floating point value</div>
<div class='content'>
<p>You can use functions defined in <code>&lt;stdlib.h&gt;</code> to convert c-string to integer or floating value. e.g. <code>atoi</code>, <code>atof</code>.</p>
</div>
</div>

#### Maze representation
A maze is represented by a 2D array of characters, in which `#` represents a wall, and it always has boundary walls. For example, a maze of size `5 x 5` with no interior walls should look like this:

<div class="highlighter-rouge"><pre>
#####
#   #
#   #
#   #
#####
</pre></div>

#### Maze generation - `genMaze`

Your program will generate a maze of size `<width> x <height>` according to our provided code. You *must not change the given code* in this function. For example, if you generate a maze of size `5 x 5` with the default parameters, it should generate a maze that looks exactly like this based on our code:

<div class="highlighter-rouge"><pre>
#####
##  #
#&lt;@##
# # #
#####
</pre></div>

<div class='admonition info'>
<div class='title'>Unsolvable maze</div>
<div class='content'>
<p>Our maze generation algorithm could produce an unsolvable maze. That is okay and you don't need to worry about it. You also don't need a special case to handle if the start position and end position are the same.</p>
</div>
</div>

#### Write a maze to a file - `writeMaze`
After generating the maze, your program should save it to a file using the argument `<maze file>` as the filename. The maze will be saved as a text file with the first line storing its size (width then height). For example, the above maze should be saved as a text file like this:

```
5 5
#####
##  #
#<@##
# # #
#####
```

When writing the maze to the text file, you should check if you write to the file successfully. If you cannot open the file for writing, your program should terminate and return `-4`.  If there is any write error, your program should terminate and return `-5`.

You will need to call this `writeMaze` function in `hw3.c`, declare it in `maze.h` and implement it in `maze.c`.

#### Print maze on screen - `printMaze`
In addition, after the maze generation, you should display the generated maze on the screen like this:

```
Maze: 5, 5
#####
##  #
#<@##
# # #
#####
```

The first line before the maze prints the maze's size (width, height).

<div class='admonition caution'>
<div class='title'>Caution</div>
<div class='content'>
<p>Pay attention to the order of the maze dimensions throughout this project: first width (number of columns), then height (number of rows).</p>
</div>
</div>

### Maze solver
```
Solve maze usage: ./hw3 <maze file>
```

The second usage of your program will find a soluton path for a given maze (`<maze file>`).

#### Read a maze from a file - `readMaze`
First, your program should read the maze from `<maze file>`. If you cannot open the file for reading, your program should terminate and return `-1`. If you encounter any read error, it should also terminate and return `-2`. After reading the maze, you should display it on the screen. It should look exactly the same as the printout shown when generating the maze.

<div class='admonition tip'>
<div class='title'>Tip</div>
<div class='content'>
<p>You can again assume that no maze will be more than 200x200 characters in size.</p>
</div>
</div>

You will need to call this `readMaze` function in `hw3.c`, declare it in `maze.h` and implement it in `maze.c`.

#### Solution path - `solveMaze` and `solvePath`
Your program is looking for a solution path connecting the start position `@` to the target position `<` without hitting or going through any wall `#`. In this homework, a path can only move in four directions: left, right, up, and down (not diagonally). Our functions are organized with a second maze representation (`char* sol`) to keep track of the solution path. This array mirrors the original maze array in many ways. The solution path can be found and established in the `sol` array using the below recursive search algorithm:

1. For each position in the solution maze (`sol`), mark them all as *unvisited*.
2. Given a position and a current path (`sol`), do the following:
   - If the position is the end target (in `maze`), the current path is a solution path. Return true.
   - Else if it is a wall (in `maze`), or it is already *visited* (in `sol`), the current path is not a solution path. Return false.
   - Mark the current position as *visited* in `sol`.
   - Try to extend the path in each direction, *exactly in the order of left, right, up, down*, and for each one, recursively perform Step 2 to check if a solution path can be found by moving to the neighbor in that direction. If a solution path is found from one of the neighbors, mark the position as a part of the solution path (in `sol`), and immediately return true.
   - Otherwise, no solution path can be found. Return false.

<div class='admonition caution'>
<div class='title'>Caution</div>
<div class='content'>
<p>Note that using the exact order (left, right, up, down) for the recursive calls is crucial so that your found solution output matches our expected output.</p>
</div>
</div>

#### Print solution path on screen - `printSolution`
If your program successfully finds a solution path for the maze, it will print the path on screen using `*` for each cell on the path.  Using the above example, your program should print:

```
Solution path (*):
#####
##  #
#<@##
# # #
#####
```

If there is no solution path for the maze, for example, the below maze has no solution path:

```
#####
#<  #
#####
#@  #
#####
```

You program should print the below message and return `1`:
```
Info: No solution found for the input maze
```

## Return code summary
There are different return codes for different errors or infos. Here is the summary:

| Return code | Meaning |
| --- | --- |
| 0 | Sucessfully generated a maze / found a solution path |
| 1 | No solution found for the input maze |
| 2 | Wrong usages - i.e. invalid number of arguments |
| -1 | Cannot open the file to read |
| -2 | File read errors |
| -3 | Invalid parameters |
| -4 | Cannot open the file to write |
| -5 | File write errors |

Except for the mentioned messages above (the usage and the no solution found info), error messages are optional. You only need to make sure the return code is correct. If you want to print some other error messages, you **should** print them to `stderr`. However, the usage and the no solution found info **must** be printed to `stdout`.

## Example runs
Here are some sample runs of maze generation (user input in **bold**):

<div class="highlighter-rouge"><pre>
$ <b>./hw3 sample_5x5.txt 5 5</b>
Maze: 5, 5
#####
##  #
#&lt;@##
# # #
#####
$ <b>./hw3 sample_10x5_0.7.txt 10 5 0.7</b>
Maze: 10, 5
##########
##  #    #
# &lt; ## #@#
#     #  #
##########
$ <b>./hw3 sample_10x5_0.7_500.txt 10 5 0.7 500</b>
Maze: 10, 5
##########
### ## @ #
## #  #  #
# &lt;  ### #
##########
$ <b>./hw3 sample_43x21_0.8_220.txt 43 21 0.8 220</b>
Maze: 43, 21
###########################################
## ##     #  # #      #   #            #  #
#  #   #             #    # # ##  #     # #
#       #     #   ##   # # #             ##
#   #   #    #              ## #   #      #
# #   #  #     #                  #       #
#  ###         ## #    #   #    # ##    ###
#    #             ## #  #        # # #   #
#   #            # #     #   #       #    #
##    #      #   ##                ##     #
#         # ## #      # #           ##    #
##   #     #  # #      #  #            # ##
#                     ##   # ##   #  #    #
# #   ##      #  #  #      #              #
#      ###         #     #  #             #
#   # ## #       #   ##   # #  #   #  ## ##
##        #  #  #   #     @##  #    #  ## #
#     # # #   &lt; #           #  ## #       #
#                ##           #         ###
#         #                      ##   #  ##
###########################################
</pre></div>

And below are sample runs using the provided test files (again, user input in **bold**):

<div class="highlighter-rouge"><pre>
$ <b>./hw3 maze0.txt</b>
Maze: 5, 5
#####
#&lt;  #
### #
#@  #
#####
Solution path (&#42;):
#####
#&lt;**#
###*#
#@**#
#####
$ <b>./hw3 maze0-NoSol.txt</b>
Maze: 5, 5
#####
#&lt;  #
#####
#@  #
#####
Info: No solution found for the input maze
$ <b>./hw3 maze1.txt</b>
Maze: 20, 10
####################
#########         &lt;#
#         ##########
### ### # #        #
#     # # #### #####
# #   # #          #
# # ###   ######## #
# #     ###        #
#   ### #@         #
####################
Solution path (&#42;):
####################
#########*********&lt;#
#        *##########
### ### #*#        #
#     # #*#### #####
# #   # #**********#
# # ###   ########*#
# #     ###       *#
#   ### #@*********#
####################
$ <b>./hw3 maze1-NoSol.txt</b>
Maze: 20, 10
####################
#########         &lt;#
#        ###########
### ### # #        #
#     # # #### #####
# #   # #          #
# # ###   ######## #
# #     ###        #
#   ### #@         #
####################
Info: No solution found for the input maze
$ <b>./hw3 maze2.txt</b>
Maze: 30, 20
##############################
#########         &lt;          #
#        ################### #
### ### # #        #     ##  #
#     # # #### #####   ##### #
# #   # #          #  ### ## #
# # ###   ######## # # #  #  #
# #     ###        # # # ## ##
#   ### #@         # #       #
#   ############## # #       #
#   #              #         #
#   ###   ##  ##  #####  # ###
###   ##           ### # #  ##
###  ##########  ####       ##
#       #######  ####       ##
#      ########  ####       ##
#                ####     ####
#                      #######
#   ####     ###    ##########
##############################
Solution path (&#42;):
##############################
#########         &lt;**********#
#  ***** ###################*#
###*###*# #        #     ## *#
#***  #*# #### #####   #####*#
#*#   #*#**********#  ### ##*#
#*# ###***########*# # #  #**#
#*#     ###       *# # # ##*##
#***### #@*********# #     **#
#***############## # #*******#
#***#              #  *****  #
#  *###   ##  ##  #####  #*###
###** ##           ### # #**##
###**##########  ####*******##
#***    #######  ####*******##
#******########  ####*******##
#******          ####**   ####
#**********************#######
#   ####     ###    ##########
##############################
$ <b>./hw3 maze2-NoSol.txt</b>
Maze: 30, 20
##############################
#########         &lt;          #
#        #####################
### ### # #        #     ##  #
#     # # #### #####   ##### #
# #   # #          #  ### ## #
# # ###   ######## # # #  #  #
# #     ###        # # # ## ##
#   ### #@         # #       #
#   ############## # #       #
#   #              #         #
#   ###   ##  ##  #####  # ###
###   ##           ### # #  ##
###  ##########  ####       ##
#       #######  ####       ##
#      ########  ####       ##
#                ####     ####
#                      #######
#   ####     ###    ##########
##############################
Info: No solution found for the input maze
</pre></div>


## Submission Requirements

### Gitlog
![Git commit trend throughout the project](https://imgs.xkcd.com/comics/git_commit.png)

<div class='admonition tip'>
<div class='title'>Tip</div>
<div class='content'>
<p>You must commit your changes with meaningful messages every so often. But what are meaningful commit messages? They are simply messages that can inform the reader what the commit exactly did to improve the program. If you want further information, you can read <a href="https://chris.beams.io/posts/git-commit/">this</a> 10-minute article that talks about good commit message practice. We strongly recommend preceding each commit for a particular project with its name, as in <code>HW3: wrote readMaze code</code>. This will make it easier for you and the graders to find the commits relevant to the assignment.</p>
</div>
</div>

<div class='admonition caution'>
<div class='title'>Caution</div>
<div class='content'>
<p>Do not use <code>git</code> as your bridge for transferring files between your local machine and the ugrad machine. You should use <code>[p]scp</code> for transferring to avoid unnecessary commits (due to file transfer after minor changes).</p>
</div>
</div>

You must include with your submission a copy of the git log output showing at least five commits to the repository. Save the `git log` output into a file called `gitlog.txt` (e.g. by doing `git log > gitlog.txt)`.

### README

You need to submit a file called `README` (not `README.txt` or `README.md`, etc -- just `README`), including information about additional changes you made (besides the program specification) and anything the graders should know about your submission. In your `README` you should:

- Write your Hopkins ID (6 character code, not JHED login) at the top
- If applicable: Briefly justify the change you made to the structure of your program; why you defined additional functions, etc
- If applicable: Highlight anything you did that was particularly clever
- If applicable: Tell the graders if you couldn’t do everything. Where did you stop? What did you get stuck on? What are parts you already know do not work according to the requirements?

### Makefile
Remember: You need to write your own Makefile. Make sure you have defined the target `hw3` properly to compile your program. We will run `make hw3` to compile your program. Failure to comply with this requirement will result in a **zero** score.

### Your submission to Gradescope
Create a `.zip` file named `hw3.zip` containing `hw3.c`, `maze.[c|h]`, `print_functions.[c|h]`, `Makefile`, `gitlog.txt`, `README`, and other **source** files that you have created (Never submit any executable or object files!).

Copy the `hw3.zip` file to your local machine (using `scp` or `pscp`), and submit it to Gradescope. When you submit, Gradescope conducts a series of automatic tests. These do basic checks, e.g. to check that you submitted the right files. If you see error messages (in red), address them and resubmit. You may resubmit any number of times prior to the deadline; only your latest submission will be graded. Review the course syllabus for late submission policies (grace period and late days), and remember that **if your final submitted code does not compile, you will likely earn a zero score for the assignment.**

<div class='admonition danger'>
<div class='title'>Danger</div>
<div class='content'>
<p>Remember that if your final submitted code does not compile, you will earn a zero score for the assignment.</p>
</div>
</div>

<div class='admonition info'>
<div class='title'>Info</div>
<div class='content'>
<p>Two notes regarding automatic checks for programming assignments:</p>
<ul>
<li>Passing an automatic check is not itself worth points. (There might be a nominal, low point value like 0.01 associated with a check, but that won’t count in the end.) The checks exist to help you and the graders find obvious errors.</li>
<li>The automatic checks cover some of the requirements set out in the assignment, but not all. It is up to you to test your own work and ensure your programs satisfy all stated requirements. Passing all the automatic checks does not mean you have earned all the points.</li>
</ul>
</div>
</div>
