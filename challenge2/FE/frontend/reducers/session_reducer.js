import {
  RECEIVE_CURRENT_USER,
  RECEIVE_SESSION_ERRORS
} from '../actions/session_actions';
import { merge } from 'lodash';

const sessionReducer = (oldState = {currentUser: null, errors: []}, action) => {
  Object.freeze(oldState);
  let newState;

  switch(action.type) {
    case RECEIVE_CURRENT_USER:
      newState = merge({}, oldState);
      newState.currentUser = action.user;
      return newState;
    case RECEIVE_SESSION_ERRORS:
    default:
      return oldState;
  }
};

export default sessionReducer;
