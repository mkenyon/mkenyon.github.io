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
<style>
  .post-content a:link {
    text-decoration: underline;
  }
  .post-content a:visited {
    text-decoration: underline;
  }
  .post-content a:hover {
    text-decoration: none;
  }
  .post-content a:active {
    text-decoration: none;
  }
</style>

I discovered recently that
the manner in which I have used React's PropTypes
has made it harder to refactor our model objects.

I had been using `PropTypes.instanceOf(ModelObject)`
throughout the React application.
My goal was to not need to edit every single React component
when I added a field to the model.
However, for all of the same reasons that we should be building towards interfaces rather than concrete objects,
I've been moving to `PropTypes.shape({relevantKey1, relevantKey2})` and extracting the shape object into an interface.

In our app,
we have 4 different kinds of Points of Interest (POI)
that we want to put onto an embedded Google Map
and display more info about each of them.
Each POI has 30 shared fields that live in a superclass.
They have ~20 independent fields each.
We fetch each kind of POI with its own AJAX request
and pass each of them into a React component that owns
the Google Map and its related bits.

```jsx
<MapCreator
  parks={this.props.parks}
  raceTracks={this.props.raceTracks}
  busStops={this.props.busStops}
  offices={this.props.offices}
/>
```

The `MapCreator` component then converts each POI into a Google Map pin

```jsx
class MapCreator extends React.PureComonent {
  render() {
    const parkPins = this.props.parks.map(
      park => <ParkPin park={park} />
    )
    const raceTrackPins = this.props.raceTracks.map(
      raceTrack => <RaceTrackPin raceTrack={raceTrack} />
    )
    const busStopPins = this.props.busStops.map(
      busStop => <BusStopPin busStop={busStop} />
    )
    const officePins = this.props.offices.map(
      office => <OfficePin office={office} />
    )

    return (
      <GoogleMap
        pins={[].concat(
          parkPins,
          raceTrackPins,
          busStopPins,
          officePins,
        )}
      />
    )
  }
}

MapCreator.propTypes = {
  parks: PropTypes.arrayOf(PropTypes.instanceOf(Park)),
  raceTracks: PropTypes.arrayOf(PropTypes.instanceOf(RaceTrack)),
  busStops: PropTypes.arrayOf(PropTypes.instanceOf(BusStop)),
  offices: PropTypes.arrayOf(PropTypes.instanceOf(Office)),
}
```

This caused a problem whenever we had to add in additional types of POIs.
By violating the Open/Closed principle, it took so much time to
modify so many of our files to add in the additional functionality.

What if MapCreator did not need to know about the different kinds of POIs?
What if it only needed to know how to display Pins?
For one, I really wanted to keep all Google Map specific code
in and under the `MapCreator`.
I don't need it polluting the rest of my business logic,
so that I retain the ability to swap out that library for another.

We can change the propTypes to focus less on the specific class names
and more on what is required.

```jsx
MapCreator.propTypes = {
  parks: PropTypes.arrayOf(PropTypes.shape({
    latitiude: PropTypes.number.isRequired,
    longitude: PropTypes.number.isRequired,
    icon: PropTypes.string.isRequired,
  })),
  raceTracks: PropTypes.arrayOf(PropTypes.instanceOf(RaceTrack)),
  busStops: PropTypes.arrayOf(PropTypes.instanceOf(BusStop)),
  offices: PropTypes.arrayOf(PropTypes.instanceOf(Office)),
}
```

And then we can extract that shape object to eliminate the duplication.

```jsx
const AppPropTypes = {
  Pinnable: {
    latitiude: PropTypes.number.isRequired,
    longitude: PropTypes.number.isRequired,
    icon: PropTypes.string.isRequired,
  }
}

MapCreator.propTypes = {
  parks: PropTypes.arrayOf(PropTypes.shape(AppPropTypes.Pinnable))),
  raceTracks: PropTypes.arrayOf(PropTypes.shape(AppPropTypes.Pinnable)),
  busStops: PropTypes.arrayOf(PropTypes.shape(AppPropTypes.Pinnable)),
  offices: PropTypes.arrayOf(PropTypes.shape(AppPropTypes.Pinnable)),
}
```

Then we don't need to distinguish between the different kinds of POIs
in the code base, either.

```jsx
import AppPropTypes from './appPropTypes.js'

class MapCreator extends React.PureComonent {
  render() {
    const pins = this.props.pins.map(
      pin => <Pin pin={pin} />
    );

    <GoogleMap pins={pins} />
  }
}

MapCreator.propTypes = {
  pins: PropTypes.arrayOf(PropTypes.shape(AppPropTypes.Pinnable))),
}
```

By focusing on how my pins are going to be used,
rather than on their class names,
I've made `MapCreator` more resilient to change.

I've programmed towards interface when writing server-side code,
but I keep relearning lessons about my craft when writing in JavaScript.
