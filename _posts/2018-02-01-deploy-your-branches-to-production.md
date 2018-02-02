---
layout: post
title: Deploy Your Branches to Production
tags:
  - git
  - branch
  - deploy
  - "git-flow"
  - production
  - "software development"
---

Most projects I've been on at Pivotal Labs have similar branching
and production deploy strategies.
But I miss the one that we used on
the _Words with Friends_ server team.
Your relationship between production and your master branch
is probably backwards.

Teams here at Pivotal Labs NY will commonly use [git flow][git-flow] or similar,
where you have one branch for continued feature development
and a lagging branch for that which has been deployed to production.
Hot-fixes go into production
and then get merged into feature development. It's regimented and well-understood.
Lots of existing writing makes it easy to introduce to new team members.
But it can be a pain to manage all off these branches.
Teams usually add in [git-flow aliases][] to help them.
And there's a lot of ceremony around deploying something to production,
something I want each [developer pair][] to do (roughly) daily.

Or, dispensing with that ceremony,
teams will just say,
"the master branch should be theoretically deployable at any time."
This works well on lower-risk products.
[We already TDD everything][tdd].
Product is reviewing and accepting each of our [thinly-sliced user stories][thinly-sliced].
Just work on a feature branch,
merge it into master,
and if CI is happy and the user story is accepted,
add a marking tag onto that master branch and deploy it.
This is easy and low-weight.
If something goes wrong during the deploy,
find the previous tag and deploy that instead.

On the _Words with Friends_ server team,
we inverted the relationship between production and the master branch.
The master branch was always what _had_ been deployed.
We would deploy a feature branch and then merge it into the master branch.
When you had code ready to go out,
you would rebase it on top of master,
on top of exactly what was already in production.
Your test suite would run,
the branch would be reviewed,
then you would roll it out to the servers
and merge it in to master.

This had several benefits.
It helped us keep pull requests small.
That helped us deploy several times per day.
You renamed variables?
Into production you go!
That meant that we never built up a large difference between production
and what we were basing our work off of.
We couldn't accidentally go for weeks without deploying,
à la my current project.
It also meant that we could easily rollback a deploy.
No searching for the previously deployed tag.
If your error logs spiked,
just deploy master.
It also encouraged us to make our deploy process seamless.
By merging and deploying often,
we had to tune our deploy process.
We also had to build in support for feature flags and experiments
so that we could break up otherwise long-running branches.

There are some downsides.
Deploying that often means
that someone has to keep an eye on that process
and on the metrics and instrumentation.
You also run the risk of someone inadvertently pushing to master,
forcing a quick revert.
It also meant that you are coupling your pull request review queue
and your deploy queue.
But, as a lead engineer,
you should already be providing feedback
to more junior engineers early and often.
That's the _lead_ part of your title!

I don't mean to claim that I invented this system.
It was largely in place
by the time I joined
as a wide-eyed young dev who needed to learn things quickly.
But it's a system that's worked better than anything else I've worked with.
I'd like to bring it to my future teams.

[git-flow]: http://nvie.com/posts/a-successful-git-branching-model/
[tdd]: http://engineering.pivotal.io/categories/tdd/
[thinly-sliced]: https://www.pivotaltracker.com/blog/choosing-best-slice-for-your-story/
