import { merge } from 'lodash';
import {
  RECEIVE_ORGANIZATION,
} from '../actions/organization_actions';

const organizationsReducer = (oldState = {}, action) => {
  Object.freeze(oldState);
  let newState;

  switch(action.type) {

    case RECEIVE_ORGANIZATION:
      newState = merge({}, oldState);
      newState = action.organization;
      return newState;

    default:
      return oldState;
  }
};

export default organizationsReducer;
