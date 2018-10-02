import React from 'react';
import ReactDOM from 'react-dom';
import Root from './components/root';
import configureStore from './store/store';

// import {
//   signin
// } from './utils/session_api_utils';

document.addEventListener("DOMContentLoaded", () => {
  const root = document.getElementById('root');
  let preloadedState = {
    session: {
      currentUser: null
    }
  };
  let store = configureStore(preloadedState);

  // window.signin = signin;

  console.log("React is working!!!");
  ReactDOM.render(<Root store={ store } />, root);
});

module.hot.accept();
