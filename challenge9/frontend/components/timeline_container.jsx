import React from 'react';
import Timeline from 'react-visjs-timeline';
import TimelineController from './timeline_control/timeline_controller';

import {
  getGroupsObject,
  getItemsObject,
  getOptionsObject
} from '../utils/timeline_util';

const TimelineContainer = ({ events, selectedElements, selectHandler }) => {
  console.log("selectedElements: ", selectedElements);
  if ((selectedElements.previous !== undefined) &&
      (selectedElements.previous !== null)) {
    selectedElements.previous.unselect();
  }
  if (selectedElements.current !== null) {
    selectedElements.current.select();
  }

  return (
    <section id="timeline">
      <header><h1>Event Timeline</h1></header>
      <Timeline
        groups={getGroupsObject(events)}
        items={getItemsObject(events)}
        options={getOptionsObject()}
        selectHandler={selectHandler}
      />
      <TimelineController
        events={events}
      />
    </section>
  );
};

export default TimelineContainer;
