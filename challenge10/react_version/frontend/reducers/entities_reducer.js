import { combineReducers } from 'redux';
import organizationsReducer from './organizations_reducer';

const entitiesReducer = combineReducers({
  organization: organizationsReducer
});

export default entitiesReducer;
