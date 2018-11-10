import React from 'react';

import PredictionIndexItem from './prediction_index_item';

const EventShow = props => {
  const event = props.event.event;
  const timelineId = props.event.timelineId.toString();

  const date = new Date(event.timestamp*1000).toString().slice(0,24);
  const imageStyle = {
    width: '100%',
    height: '100%'
  };

  return (
    <section id="event-show">
      <header>
        <h2>Event {timelineId} - {event.videoStream}</h2>
        <time>{date}</time>
      </header>

      <section id="image-container">
        <img style={imageStyle} src={event.imageSource}></img>
          {
            event.predictions.map((prediction, idx) => (
              <PredictionIndexItem key={idx} prediction={prediction}/>
            ))
          }
      </section>
    </section>
  );
};

export default EventShow;
