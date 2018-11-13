import React from 'react';

import VideoSourceFilter from './video_source_filter';
import {
  getAllLabels,
  getAllVideoStreamNames
} from '../../utils/timeline_util';

const TimelineController = ({ events }) => {
  // Get list of labels and video stream names
  const labels = getAllLabels(events);
  const vsNames = getAllVideoStreamNames(events);

  return (
    <section id="timeline-controller">
      <ul>
        <VideoSourceFilter labels={labels}/>

      </ul>
    </section>
  );
};

export default TimelineController;
