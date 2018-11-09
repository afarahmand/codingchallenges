export const getGroupsObject = events => {
  let groups = [];
  let groupNames = {};

  // Each videoStream is associated with a group
  let count = 0;
  while (count < events.length) {
    if (groupNames[events[count].videoStream] === undefined) {
      groupNames[events[count].videoStream] = true;
      groups.push({
        id: events[count].videoStream,
        content: events[count].videoStream,
      });
    }
    count++;
  }

  return groups;
};

export const getItemsObject = events => {
  let items = [];
  let count = 0;
  let eventVSName;

  while (count < events.length) {
    eventVSName = events[count].videoStream;

    items.push({
      id: count,
      content: count.toString(),
      group: eventVSName,
      start: events[count].timestamp*1000,
      type: 'box'
    });
    count++;
  }

  return items;
};

// Find zoomMin, zoomMax, min, and max
export const getOptionsObject = () => (
  {
    format: {
      minorLabels: {
        millisecond:'SSS',
        second:     's',
        minute:     'HH:mm',
        hour:       'HH:mm',
        weekday:    'ddd D',
        day:        'D',
        week:       'w',
        month:      'MMM',
        year:       'YYYY'
      },
      majorLabels: {
        millisecond:'HH:mm:ss',
        second:     'D MMMM YYYY HH:mm',
        minute:     'ddd D MMMM',
        hour:       'ddd D MMMM YYYY',
        weekday:    'MMMM YYYY',
        day:        'MMMM YYYY',
        week:       'MMMM YYYY',
        month:      'YYYY',
        year:       ''
      }
    },
    min: 1506865000000,
    max: 1506929000000,
    stack: false,
    zoomMax: 64800000,
    zoomMin: 1800000
  }
);

export const getAllVideoStreamNames = events => {
  let vsNames = [];

  // Each videoStream is associated with a group
  let count = 0;
  while (count < events.length) {
    if (!vsNames.includes(events[count].videoStream)) {
      vsNames.push(events[count].videoStream);
    }
    count++;
  }

  return vsNames.sort();
};

export const getAllLabels = events => {
  let labels = [];

  events.forEach(event => {
    event.predictions.forEach(prediction => {
      prediction.scores.forEach(score => {
        if (!labels.includes(score.label)) {
          labels.push(score.label);
        }
      });
    });
  });

  return labels.sort();
};
