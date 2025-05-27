# 601.220 Intermediate Programming, Summer 2025, at JHU

This is the public website Github repository for 601.220 Intermediate Programming,
Summer 2025, at [Johns Hopkins University](https://www.jhu.edu).

The actual website (generated from the contents of this repository) is
<https://jhu-ip.github.io/cs220-summer25/>.

## Editing and updating the course website

**Instructions tested on ubuntu 20.04**

This information is for CS220 staff who will be editing and updating the website.

The website uses [Jekyll](https://jekyllrb.com/), which in turn is the
engine for [Github pages](https://pages.github.com/).

All of the webpages are written in Markdown.

### Installing Jekyll

The best way to install Jekyll is to first install [rbenv](https://github.com/rbenv/rbenv).
I (DH) generally use the [Basic GitHub Checkout](https://github.com/rbenv/rbenv#basic-github-checkout)
approach to installing rbenv. Don't forget to init rbenv with

```bash
rbenv init
```


Once rbenv is installed, install [ruby-build](https://github.com/rbenv/ruby-build#readme),
which will allow you to compile a Ruby runtime from source. To install ruby-build in Ubuntu 20.04 I (JAB) used the option `Clone as rbenv plugin using git` explained inthe `ruby-build` README.

Once ruby-build is installed, install Ruby 3.2.0 using the commands. Ruby version 2.7.0 did not work to install Jekyll.

```
rbenv install 3.2.0
rbenv global 3.2.0
```

At this point the command `ruby --version` should produce output similar to

```
ruby 3.2.0 (2022-12-25 revision a528908271) [x86_64-linux]
```

Now check if rbenv was correctly initilized. You can check this with the command `which gem` which should point to your local `.rbenv`
```
<HOME>/.rbenv/shims/gem
```

At this point you can install Jekyll using the command

```
gem install jekyll
```

### Using Jekyll for a local preview of the website

As you make changes to the website, you can preview the site by running the
command

```
jekyll serve --baseurl ''
```

Enter the url [`http://localhost:4000/`](http://localhost:4000/) in a web browser, and you should be
previewing the website.  As you make changes to the website files, the
web browser will *not* automatically update to reflect those changes, so
you'll need to refresh manually.

### Publishing changes

Once you're ready to publish your changes, `git add` and `git commit` them,
and then `git push`.  Within a few minutes, the site should be rebuilt
remotely to reflect your changes.

### Updating the Course Materials page

To add information to the Course Materials page, edit [material.csv](material.csv),
and then run the command

```
./gen_materials_page.rb > material.md
```

Hopefully, the format of `material.csv` is self-explanatory.  It may be convenient
to open this file in a spreadsheet, and then save it as CSV.

Add and commit your changes to both `material.csv` and `material.md`. (Previewing
the changes first is probably a good idea.)

The file [semester.csv](semester.csv) is a "full semester" schedule of
course material. In general, when adding one week of course material,
it should be possible to just copy it from `semester.csv`.

### Porting web content from previous semester website(s)

In previous semesters, we used [Yarn](https://yarnpkg.com/) and
[Docusaurus](https://docusaurus.io/) to build the course website.
Because the previous websites used
[admonitions](https://docusaurus.io/docs/markdown-features/admonitions),
which are a nonstandard Markdown extension, the Markdown files will
need to be converted to standard syntax.

You can use the [convert\_docusaurus\_markdown.rb](convert_docusaurus_markdown.rb)
script to convert the admonition blocks to HTML.  (This will require that
you have [pandoc](https://pandoc.org/) installed.)

Run this script something like the following:

```
./convert_docusaurus_markdown.rb < ORIG.md > RESULT.md
```

where `ORIG.md` is the file you want to convert, and `RESULT.md`
is the updated file to generate.

Note that you will probably need to fix links to image files and other documents,
since the new website uses a different directory structure.
