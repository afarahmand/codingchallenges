import React from 'react';
import ReactDOM from 'react-dom';

import Root from './components/root';
import configureStore from './store/store';

import { signin } from './utils/session_api_utils';
import { fetchOrganization } from './utils/organization_api_utils';

document.addEventListener("DOMContentLoaded", () => {
  const currentUserId = 'u2kjfladadwddj9';
  signin(currentUserId)
  .then(user => {
    const currentUser = user.data.user;

    let preloadedState = {
      entities: {
        organization: null
      },
      session: {
        currentUser: currentUser
      }
    };
    let store = configureStore(preloadedState);
    window.getState = store.getState;

    console.log("React is working!!!");
    const root = document.getElementById('root');
    ReactDOM.render(<Root store={ store } />, root);
  });
});
//
// module.hot.accept();
