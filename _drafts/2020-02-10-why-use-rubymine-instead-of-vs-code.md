---
layout: post
title:  "Why use RubyMine instead of Visual Studio Code"
date:   2020-02-10 13:14:02 -0500
categories: ruby rubymine vscode code ide
---

My current job allows people to largely pick their own IDE 
for our Ruby on Rails and our TypeScript work.
Most developers in my area choose Visual Studio Code.
And there's good reason to.
VS Code is free. No need to ask IT for a licence. [It's immensely configurable.][extensions]
The ease of writing extensions helped Atom and VS Code win out over Sublime.
But that configuration is also its weakness.
Most devs at Clio use VS Code as a text editor instead of an _integrated development environment_.
I'm a big believer in the notion that _you like what you like_.
But I'm also a big believer in using the best tool for the job.

Navigating your code base
=========================

We are working on an eleven-year-old product and codebase.
One of the most important parts of (object-oriented) software engineering craft is 
knowing how to how send messages between your tiny, single-purpose objects.
It's hard to solve that problem if you cannot move around the codebase freely.

In Visual Studio Code, you _can_ set up [Solargraph][] and configure it properly.
Two out of fifteen recent Code pairing sessions have Solargraph actually working.
The other thirteen would be better off using RubyMine.

What does this class actually do?
---------------------------------

When pair programming or helping someone debug their work,
I'll end up asking my pair to jump to a class definition
or a method definition.

![Screen capture of a bad Visual Studio Code Find & Replace experience](/assets/img/2020-02-10-why-use-rubymine/global-find-and-replace.gif)

Whereas with RubyMine, 
you can just <span class="kbd">Cmd</span>-click on a method or class,
to jump right to its definition,
with easy filtering if there are multiple definitions.

![Screen capture of a great RubyMind Jump to Definition experience](/assets/img/2020-02-10-why-use-rubymine/jump-to-definition.gif)

Where is this method being called from? Who is using it?
--------------------------------------------------------

The reverse lookup is also important when understanding your codebase.
You need to know which parts of the code are calling this method
before you change its signature
or to see if you can delete it entirely.
(When the codebase is eleven-years-old, sometimes the answer is "this should have been deleted four years ago".)

Just press <span class="kbd">Opt</span>&ndash;<span class="kbd">F7</span>
and RubyMine will search for direct usages, symbol or hash keys, strings, and test definitions.

![RubyMine's powerful Find Usages](/assets/img/2020-02-10-why-use-rubymine/find-usages.png)

What does this library method do?
---------------------------------

In practice, exploring your gems doesn't _feel_ any different to a RubyMine user, 
but it has been a delightful surprise for anyone new.

Here's an example. We were writing a query on the replica database that needed
to scan a massive table. I wanted to guarantee that we were not locking the entire table.
I _thought_ that `#find_each` would do the trick, but couldn't quite remember for sure,
so I just <span class="kbd">Cmd</span>-clicked it. RubyMine dutifully opened up
`ActiveRecord::Batches#find_each` so that I could see the code myself.

Resolve Conflicts
-----------------

This _might_ be my favourite feature of RubyMine. 
I have not been able to find a parallel tool.

Whether you are merging, rebasing, cherry-picking, or unstashing changes, conflicts can arise.
RubyMine gives you a code-aware means of resolving the conflicts. 
Press <span class="kbd">Shift></span> <span class="kbd">Shift></span> and type `Resolve conflicts`
to activate it.

You get a three-panel window that shows your local changes on the left, the server changes on the right,
and the original base version in the middle. 
Click the *Magic Wand* button to automatically apply any non-conflicting changes.
Then pick which version of the conflicts that should be applied, 
editing them as needed,
and save the results.

Don't forget to run your tests!

Jump to the test
----------------



Find this translation key
-------------------------



Refactoring
===========

Easy extractions
----------------

Code-aware renaming
-------------------

Renaming a controller will automatically rename your file, your views, your tests.

Better Testing Experience
=========================

Integrated testing
------------------

Built-in visual debugger
------------------------

It's even better for TypeScript!
--------------------------------


What I don't use RubyMine for?
==============================

1. Managing the actual project.

    None of the `.idea/` files get committed. 
    I still use command-line `bundler`. 
    Even on my own personal projects, 
    I don't want to be _locked into_ using RubyMine.
    Everybody needs to be able to commit code using whichever tool they want.

2. Git stuff

    Other than the _Resolve Conflicts_ feature,
    every other `git` operation happens on the command-line. 
    For me, `git` is such a fundamental tool across every project I use.
    I am far more comfortable just giving commands to the actual tool.

    That said, I will sometimes pull open [GitX][] for visual diffs if the situation calls for it.

[extensions]: https://marketplace.visualstudio.com/vscode
[GitX]: https://rowanj.github.io/gitx/
[Solargraph]: https://marketplace.visualstudio.com/items?itemName=castwide.solargraph

You’ll find this post in your `_posts` directory. Go ahead and edit it and re-build the site to see your changes. You can rebuild the site in many different ways, but the most common way is to run `jekyll serve`, which launches a web server and auto-regenerates your site when a file is updated.

To add new posts, simply add a file in the `_posts` directory that follows the convention `YYYY-MM-DD-name-of-post.ext` and includes the necessary front matter. Take a look at the source for this post to get an idea about how it works.

Jekyll also offers powerful support for code snippets:

{% highlight ruby %}
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=> prints 'Hi, Tom' to STDOUT.
{% endhighlight %}

Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk].

[jekyll-docs]: https://jekyllrb.com/docs/home
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/
