import React from 'react';
import ReactDOM from 'react-dom';

import Root from './components/root';

import { fetchEvents } from './utils/event_api_util';

import './stylesheets/reset.css';
import './stylesheets/main.css';

document.addEventListener("DOMContentLoaded", () => {
  const root = document.getElementById('root');
  ReactDOM.render(<Root events={ fetchEvents().mockResponse.events } />, root);
});

module.hot.accept();
