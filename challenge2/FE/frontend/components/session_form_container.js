import { connect } from 'react-redux';
import sessionForm from './session_form';
import {
  receiveSessionErrors,
  signin
} from '../actions/session_actions';

const mapStateToProps = state => ({
  currentUser: state.session.currentUser
});

const mapDispatchToProps = dispatch => ({
  clearSessionErrors: () => dispatch(receiveSessionErrors([])),
  processForm: user => dispatch(signin(user))
});

export default connect(mapStateToProps, mapDispatchToProps)(sessionForm);
