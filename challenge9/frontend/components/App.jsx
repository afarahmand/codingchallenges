import React from 'react';

import { TimelineElement } from './models/timeline_element';
import TimelineContainer from './timeline_container';
import EventShow from './event_show';

class App extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      events: props.events,
      filter: {
        label: '',
        score: '',
        timestamp: '',
        videoSource: ''
      },
      selectedElements: {
        previous: null,
        current: null
      },
      selectedEvent: {
        timelineId: 0,
        event: props.events[0]
      },
      timelineElements: null
    };

    this.selectHandler = this.selectHandler.bind(this);
  }

  componentDidMount(){
    let timelineElements = {};
    let dots = document.getElementsByClassName('vis-dot');
    let lines = document.getElementsByClassName('vis-line');
    let boxes = document.getElementsByClassName('vis-box');

    let i = 0, box, idx;
    while (i < boxes.length) {
      box = this.getBoxByContent(i.toString());

      idx = 0;
      while (boxes[idx] !== box) { idx++; }

      timelineElements[i] = new TimelineElement(
        dots[idx], lines[idx], boxes[idx]
      );

      i++;
    }


    timelineElements[0].select();

    this.setState({
      selectedElements: {
        current: timelineElements[0]
      },
      timelineElements: timelineElements
    });
  }

  componentDidUpdate(prevProps, prevState) {
    window.state = this.state;

    let selectedElement = this.state.timelineElements[
      this.state.selectedEvent.timelineId
    ];

    console.log("selectedElement: ", selectedElement);
    selectedElement.select();
  }

  getBoxByContent(content){
    let items = document.getElementsByClassName('vis-item-content');

    let i = 0;
    while (i < items.length) {
      if (items[i].innerHTML === content) {
        return items[i].parentNode;
      }
      i++;
    }

    return items[0].parentNode;
  }

  selectHandler(e) {
    // ensures that an item is selected and not just a random click elsewhere
    if (e.items.length !== 0) {
      let lastSelectedElement = this.state.timelineElements[
        this.state.selectedEvent.timelineId
      ];
      let selectedElement = this.state.timelineElements[e.items[0]];

      // lastSelectedElement.unselect();
      // selectedElement.select();

      this.setState({
        selectedElements: {
          previous: lastSelectedElement,
          current: selectedElement
        },
        selectedEvent: {
          timelineId: e.items[0],
          event: this.props.events[e.items[0]]
        }
      });
    }
  }

  setFilter(e) {
  }

  render () {
    return (
      <div>
        <TimelineContainer
          events={ this.props.events }
          selectedElements={ this.state.selectedElements }
          selectHandler={ this.selectHandler }
        />
      <EventShow event={ this.state.selectedEvent }/>
      </div>
    );
  }
}

export default App;
