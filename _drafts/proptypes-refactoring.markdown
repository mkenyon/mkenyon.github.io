---
layout: post
title: PropTypes, Refactoring, and the Open-Closed Principle
tags:
  - react
  - js
  - jsx
  - es6
  - proptypes
---

# PropTypes, Refactoring

We discovered recently that 
the manner in which we used our PropTypes 
made it harder to refactor our models.
Even in JavaScript, 
care about more about the shape of your objects
and the messages that they respond to,
rather than the particular name of the object.
Using `PropTypes.instanceOf` instead of `PropTypes.shape` violates this principle.

Setting the stage,
we have 4 different kinds of Points of Interest (POI).
that we want to put onto an embedded Google Map 
and display more info about each of them. 
They have 30 shared fields that live in a superclass.
They have ~20 independent fields each.
We fetch each kind of POI with its own AJAX request
and pass each of them into a React component that owns
the Google Map and its related bits.

```jsx
<MapCreator
  parks={this.state.parks}
  raceTracks={this.state.raceTracks}
  busStops={this.state.busStops}
  shoppingCentres={this.state.shoppingCentres}
/>
```



### Graveyard

Using `PropTypes.instanceOf` makes it 

We have 4 different kinds of Points of Interest
that we want to place on an embedded Google Map.
They have some shared characteristics, but are
slightly different, so we have modelled them using
subclasses.

{% highlight js %}

class POI {
  constructor(values = {}) {
    this.name = values.name
    this.address = values.address
    this.coordinates = values.coordinates
  }
}

class Park extends POI {
  constructor(values = {}) {
    super(values)

    this.sqft = values.sqft
    this.numTrees = values.numTrees
  }
}

class ShoppingCentre extends POI {
  constructor(values = {}) {
    super(values)

    this.sqft = values.sqft
    this.totalMonthlyRent = values.totalMonthlyRent
  }
}

class BusStop extends POI { ... }

class RaceTrack extends POI { ... }

{% endhighlight %}


