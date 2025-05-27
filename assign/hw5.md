---
id: hw5
layout: default
title: Homework 5
---

<div class='admonition caution'>
<div class='title'>Caution</div>
<div class='content'>
<ul>
<li>You are expected to work individually.</li>
<li><strong>Due: Monday <strong>July 14th</strong> at 11pm ET (Baltimore time).</strong></li>
<li><em>This assignment is worth 60 points.</em></li>
</ul>
</div>
</div>

## Learning Objectives
<div class='admonition success'>
<div class='title'>Objectives</div>
<div class='content'>
<p>To practice with:</p>
<ul>
<li>Input and output using iostreams (<code>cin</code> and <code>cout</code>)</li>
<li>File input and output using <code>ifstream</code> and <code>ofstream</code></li>
<li>C++ <code>string</code></li>
<li>Data representation using STL collections such as <code>vector</code> and <code>map</code></li>
<li>Access and manipulation of STL collections using iterators</li>
</ul>
</div>
</div>

## Overview

The goal for this assignment is to become familiar with basic I/O in
C++, and to use built-in classes and algorithms from the STL to solve a
problem that would be difficult to code from scratch.

## Phone Database

Your will write a program to keep track of an in-memory database of contact names
and phone numbers.  The database should be structured as follows:

* Each contact consists of a last name and a first name
* Each contact can have up to 5 phone numbers, with types "HOME",
  "CELL", "WORK", "FAX", and "VOIP"; only one phone number of
  each type is allowed for a single contact

Last names and first names are nonempty sequences of non-whitespace characters.

Phone numbers are sequences of digit (0–9) and hyphen ("-") characters,
and must start and end with a digit.

## Input and Output

The program will read data from `cin` and write data to `cout`.

There are three kinds of output from the program.

<div class='admonition caution'>
<div class='title'>Caution</div>
<div class='content'>
<p>Each kind of output must be printed as a complete line of output to <code>cout</code>, terminated by a newline/<code>endl</code>, in exactly the forms specified below.</p>
</div>
</div>

*Info messages* are messages that are helpful for the user, but which
aren't part of the "official" results of the program.  They have the
form

```
Info: message text
```

where `message text` can be any text.  You can use info messages for prompts
and other information for the user.

*Result messages* indicate the result of a command, and have the form

```
Result: message text
```

where `message text` is the exact text required for a particular command result
(as described in the [Commands](#commands) section below.)

*Error messages* are messages indicating that an error has occurred. They have
the form

```
Error: message text
```

where `message text` is the exact text required for the error message (again,
as described in the [Commands](#commands) section.)  Note that error messages
should be printed to `cout`, not `cerr`.

## Commands

The program should support the following commands.  The user will
enter each command as a single line of text.  There can be arbitrary
horizontal whitespace (e.g., space and tab characters) preceding or
following each token.

Here is a summary of the commands and their forms:

Command | Purpose                                   | Form
------- | ----------------------------------------- | ----------------------------------------
`C`     | Create a contact                          | `C lastname firstname`
`D`     | Delete a contact                          | `D lastname firstname`
`L`     | List contact names                        | `L`
`P`     | List phone numbers for a contact          | `P lastname firstname`
`N`     | Add or replace phone number for a contact | `N lastname firstname type phone_number`
`X`     | Delete phone number for a contact         | `X lastname firstname type`
`S`     | Save the database to a file               | `S filename`
`R`     | Restore the database from a file          | `R filename`
`Q`     | Quit the program                          | `Q`

For all commands with `lastname` and `firstname` values specifying
a contact name, searches are *case-insensitive*.  As an example, if a contact
with last name `Granger` and first name `Hermione` exists in the database,
then a `P` command specifying `granger` and `HERMIONE` as the last name
and first name should match the existing contact, and print the phone
numbers for that contact.

Note however that whenever a contact's last and first names are printed
by the `L` command, the exact capitalization used in the original `C` command
when creating the contact should be used.  One way to think about this is
that the contacts are stored in the database using an exact representation
of upper and lower case for each letter in the last and first names,
but *comparisons* between contact names should be done in a case-insensitive
manner.

### `C` command

The `C` command creates a contact.

If successful, a result message with the text `Contact created` should be printed.

If unsuccessful because a contact with the same last name and first name
already exists, an error message with the text `Contact already exists`
should be printed.

### `D` command

The `D` command deletes a contact.

If successful, a result messasge with the text `Contact deleted` should be printed.

If unsuccessful because no contact with the given last name and first name exists,
an error message with the text `Contact not found` should be printed.

### `L` command

The `L` command lists the last and first names of each contact.  The contacts
should printed in lexicographical order by last name, with comparison of
first names breaking ties in the case where two contacts have the same last
name.  All comparisons are case-insensitive.  Each contact name should be
printed as a separate result message, with message text of the form `lastname,firstname`.

### `P` command

The `P` command prints the phone numbers for a specific contact.  The phone
numbers are printed in alphabetical order by type, so (for example) the
`CELL` phone number should come before the `HOME` phone number. 
Each existing phone number should be printed as a separate result message, with
message text of the form `type,phone_number`. (If no phone number is
specified for a specific type, that type should not be printed.)

If the contact is not found, an error message with the message text
`Contact not found` should be printed.

Note that it is not an error if the contact exists, but there are no
phone numbers for the contact. In this case there are no required
result messages to output, but you could print an info message.

### `N` command

The `N` command adds or modifies a phone number for a contact.

If the command successfully adds a new phone number (i.e., there was
no prior phone number of the specified type for the contact), a result
message with the text `Phone number added` should be printed.

If the command successfully replaces a phone number (i.e., a phone
number of the specified type already existed for the contact),
a result message with the text `Phone number replaced` should
be printed.

If the contact is not found, an error message with the message text
`Contact not found` should be printed.

If the phone number type is not valid, meaning that it is not one of
`CELL`, `HOME`, `WORK`, `FAX`, or `VOIP`, an error message with the
message text `Invalid phone number type` should be printed.

If the phone number is not valid, an error message with the message
text `Not a valid phone number` should be printed.

(The possible error conditions should be checked and handled in the
order specified above. Only one error message should be printed.)

### `X` command

The `X` command deletes a phone number for a contact.

If successful, a result message with the text `Phone number deleted`
should be printed.

If the contact is not found, an error message with the message text
`Contact not found` should be printed.

If the contact has no phone number of the specified type, an error message
with the message text `No phone number of that type` should be printed.
Note that the `X` command does *not* need to validate that the phone
number type is valid, as the `N` command does.  So, if the phone number
type is invalid, the correct response is an error message with the
text `No phone number of that type`.

(The possible error conditions should be checked and handled in the
order specified above. Only one error message should be printed.)

### `S` command

The `S` command saves all of the data currently in the phone database to
a named file.

If the output file can't be opened, an error message with
the message text `Could not open output file` should be printed.

Note that there is no specification for how data should be written.
It is up to you to determine a format that will allow the `R` command
to successfully read back the saved data.

### `R` command

The `R` command loads data from a file written using a previous `S` command
into the database, replacing whatever data is currently present.

If the input file can't be opened, an error message with
the message text `Could not open input file` should be printed.

If the input file can be opened, but the data in it is not valid,
an error message with the message text `Invalid database file` should be printed.
Note that if the input data is corrupted, the database contents in memory
are allowed to be indeterminate.  (In other words, it is acceptable for
the `R` command to partially load data into memory.)

### `Q` command

The `Q` command causes the program to terminate.

## Example Session

Here is an example session of the program:

```
Info: Welcome to the Phone Database!
Info: Please enter a command
C Weasley Ron
Result: Contact created
Info: Please enter a command
C Granger Hermione
Result: Contact created
Info: Please enter a command
C Malfoy Draco
Result: Contact created
Info: Please enter a command
L
Result: Granger,Hermione
Result: Malfoy,Draco
Result: Weasley,Ron
Info: There are 3 contact(s)
Info: Please enter a command
N Granger Hermione CELL 401-555-1234
Result: Phone number added
Info: Please enter a command
N Weasley Ron WORK 61-491-570-156
Result: Phone number added
Info: Please enter a command
N Granger Hermione VOIP 301-555-8765
Result: Phone number added
Info: Please enter a command
P Granger Hermione
Result: CELL,401-555-1234
Result: VOIP,301-555-8765
Info: Found 2 phone number(s) for this contact
Info: Please enter a command
P Weasley Ron
Result: WORK,61-491-570-156
Info: Found 1 phone number(s) for this contact
Info: Please enter a command
P Malfoy Draco 
Info: There are no phone numbers for this contact
Info: Please enter a command
D Malfoy Draco
Result: Contact deleted
Info: Please enter a command
L
Result: Granger,Hermione
Result: Weasley,Ron
Info: There are 2 contact(s)
Info: Please enter a command
X Granger Hermione VOIP 
Result: Phone number deleted
Info: Please enter a command
P Granger Hermione
Result: CELL,401-555-1234
Info: Found 1 phone number(s) for this contact
Info: Please enter a command
P Longbottom Neville
Error: Contact not found
Info: Please enter a command
Q
Info: Thank you for using the Phone Database!
```

## Hints

<!--
TODO: hints for completing the program

TODO: to allow the contacts to be stored using their original
capitalization, but to make search and identity comparisions
case-insensitive, the main map will need to use a comparator
that is case-insensitive.  Will need to explain how to use a
custom comparator function with an STL map (along the lines of
what the reference solution does with the `NameComparisonFunc`
function pointer type and the `compare_name` function.)
-->

The first thing you will need to think about is how to use STL containers
to represent the data in the phone database.  The `map` container type
should be very useful.  For example, if `Name` represents a contact
name (last name and first name), and `PhoneNumberCollection` represents a
collection of phone numbers for a contact, then the variable declaration

```cpp
map<Name, PhoneNumberCollection> phone_db;
```

could be a good representation for the entire phone database.

Note that in order to allow searches to be case-insensitive, you will
need to have a way of ordering the keys in this map that ignores case
distinctions.  I.e., we want the contacts `Granger,Hermione` and `granger,HERMIONE`
to be considered the same when searching, and we want `granger,HERMIONE`
to be considered "less than" `Longbottom,Neville`, even though the
character code for `g` is greater than the character code for `L`.
To allow this, we will need the map to use an appropriate ordering function
for the map keys (in this case, the keys belong to the `Name` data type.)
The default ordering function for keys in `map`s is
[`std::less`](https://en.cppreference.com/w/cpp/utility/functional/less),
which in turn is based on ordering values according to the `<` (less than) operator.
So, one way to ensure that contact names are ordered correctly is to override the `<`
operator.  This would look something like this:

```cpp
bool operator<(const Name &left, const Name &right) {
  // return true if left<right, false otherwise,
  // ignoring case
}
```

As long as this function exists, is defined correctly, and its declaration
preceeds any use of the `Name` type as the key type in a `map` instance,
then the contact names should be ordered correctly.

Note that the `Name` and `PhoneNumberCollection` data types don't necessarily
need to be `struct` or `class` types that you define.  They could also
be `typedef`s for STL data types.  For example:

```cpp
// Note: probably not a great way to represent phone numbers for
// a contact
typedef vector<string> PhoneNumberCollection;
```

This `typedef` would make `PhoneNumberCollection` an alias for `vector<string>`.
Even though `vector<string>` is not a great way to represent the collection of
phone numbers for a contact, it's likely that you can use STL data types
to achieve a better representation.

When writing the database to a file in the `S` command, you will need to think
about how to write the data so that it can be easily read back in by the `R`
command.  One useful technique to use when writing a collection of data
is to first write the number of items in the collection, and then write each
individual item.  That way, the code that reads the data will know exactly
how many items should be read back in.

## Testing

A good way to test the program is to prepare an input file with commands
to send to the program, and an expected output file containing the
result and error messages expected to be produced.  (The expected output
file shouldn't contain the info messages, since producing them is optional,
and their content isn't specified.)

Example input and expected output files called `input1.txt` and
`expected_output1.txt` are provided with the starter files.  Here is how
you can use them to test your program:

```
make phone_db
(./phone_db < input1.txt) | egrep -v "^Info:" > actual1.txt
diff expected_output1.txt actual1.txt
echo $?
```

If the `diff` command produces no output, and the `echo $?` command results in
the output `0`, then your program's output matched the expected output.

If the files that `diff` is comparing are different, then it will display the differences in the lines of each file, using `<` to indicate a line from the first file argument and a `>` to indicate a line from the second file argument. It will also give you indications of line numbers for the differences, such as `5c5,6` to mean line number 5 between columns 5 and 6. Here is a brief example:
```
5c5,6
< // PART 7 TO DO: Make sure to include any additional necessary header files
---
> // PART ? TO DO: Make sure to include any additional necessary header files
```

## Shared Test Repository

To allow you to share your tests with the entire class, and to benefit from
tests written by other students, we have set up a shared test repository:
<https://github.com/jhu-ip/cs220-summer24-hw5-tests>

The basic idea is that you can clone this repository and then

* use `git add` and `git push` to contribute your own tests
* use `git pull` to gain access to tests written by others

See the `README.md` for details.

## Files, Submitting

### Provided files

Start with the template Makefile, source files, and header file in the public repo:
`cs220-summer22-public/homework/hw5/`.

- The Makefile is very minimal, building an executable called `phone_db`
  from a source file called `phone_db.cpp`. This might be sufficient, but if
  you would like to use additional source and/or header files,
  you will need to modify the Makefile accordingly

- The initial `phone_db.cpp` is *very* minimal, consisting of just a `main` function

### Gitlog

You must include with your submission a copy of the output of `git log`
showing at least five commits to the repository. Save the `git log` output
into a file called `gitlog.txt` (e.g. by doing `git log > gitlog.txt)`.

### README

Please submit a file called `README` (not `README.txt` or `README.md`,
etc -- just `README`) including information about what design choices you
made and anything the graders should know about your submission. In your
`README` you should:

- Write your name and JHED ID at the top of the file.
- Briefly justify the structure of your program; why you defined the functions you did, etc.
- If applicable: Highlight anything you did that was particularly clever.
- If applicable: Tell the graders if you couldn’t do everything. Where
  did you stop? What did you get stuck on? What are the parts you already
  know do not work according to the requirements?

## Compiling

Your code should compile with no errors or warnings with the typical
command: `g++ <source> -Wall -Wextra -std=c++-11 -pedantic`.
(These are the options included in the provided `Makefile`.)

## Submission

Create a `.zip` file named `hw5.zip` containing:

- All `.cpp` files
- All `.h` files (if any)
- README
- Makefile
- gitlog.txt

Copy `hw5.zip` file to your local machine (using `scp` or `pscp`),
and submit it as **Homework 5** on Gradescope. When you submit, gradescope
conducts a series of automatic tests. These do basic checks, e.g. to
check that you submitted the right files. If you see error messages (in
red), address them and resubmit. You may re-submit any number of times
prior to the deadline; only your latest submission will be graded. Review
the course syllabus for late submission policies (grace period and late
days), and remember that **if your final submitted code does not compile,
you will likely earn a zero score for the assignment.**

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

<!--
#### Preparation:

-   Readings: C++ text Chapters 1-6, Appendix A
-   Compilation: g++ -std=c++98 -pedantic -Wall -Wextra -O
-   Submission: You are expected to use several files to organize your
    solution. Create a makefile for compilation, and zip all the program
    files you are submitting (all \*.h, \*.cpp and your makefile) into
    one submission on Blackboard. Bring a printout of your \*.cpp files
    only (not \*.h files) to class to facilitate grading.
-   Grading: 45 points total = 20 functionality + 20 implementation + 5
    style/submission/efficiency. -5 points if there are any warnings
    using the required compilation options. 0 points if the files don\'t
    all compile together (ie, any file has errors, no executable
    created). Continue to use good incremental coding development and
    ruthless testing!!

#### Part A: PhoneList Management \[45 points\]

For this assignment you will use the C++ STL to maintain a collection of
phone numbers, such as may be found in your cell phone. Your collection
will consist of multiple contacts. Each contact has a name and a list of
phone number pairs. Each phone number pair consists of the type of
number (for example, \"CELL\", \"HOME\", \"WORK\", \"FAX\", etc.) and
the actual phone number. In addition to the full contacts list, the
program will also maintain a collection of favorites.

The basic operation of your program will allow the user to
add/edit/delete an entire contact, add/edit/delete a phone number pair
for a contact, add/delete contacts from the favorites collection, and
rearrange the position of a contact in the favorites list. You should
also have options to display all the contacts in alphabetical order,
display all the numbers for a particular contact, and display the names
of all the favorites, in the order in which you have put them (and
rearranged them) in the favorites list.

All data should be input from the keyboard. All output should go to the
screen. Make your program interactive and very user friendly; the exact
user interface is up to you. Consider using layers of menus instead of
one huge menu with options for everything. This is your opportunity to
let your design star shine! (Can you use the STL to store common menu
operations?) Name your file with main pg5a.cpp so that we can clearly
identify it when grading.

#### Implementation Requirements

Violations will result in point deductions.

-   Use C++ streams and operatorions for I/O (not printf or scanf).
-   Use the STL for most of the data storage and processing (string,
    vector, list).
-   Define structs and typedefs to organize the various data types
    (phone number, contact). Add functions for basic operations, such as
    reading and writing.
-   Do not replicate data in the favorites collection. Instead make the
    items in favorites be some type of reference to the actual contact
    data.
-   Use the most appropriate data types and algorithms for the best
    efficiency possible.
-   Use const to protect data as much as possible.
-   You can only use specific \"using\" statements, not \"using
    namespace std\".
-->
