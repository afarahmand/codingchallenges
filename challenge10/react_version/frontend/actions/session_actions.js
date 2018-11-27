import * as SessionApiUtil from '../utils/session_api_utils';

export const RECEIVE_CURRENT_USER = "RECEIVE_CURRENT_USER";
// export const RECEIVE_SESSION_ERRORS = "RECEIVE_SESSION_ERRORS";

const receiveCurrentUser = user => ({
  type: RECEIVE_CURRENT_USER,
  user
});

// export const receiveSessionErrors = errors => ({
//   type: RECEIVE_SESSION_ERRORS,
//   errors
// });

export const signin = user => dispatch => (
  SessionApiUtil.signin(user).then(
    (currentUser) => dispatch(receiveCurrentUser(currentUser.data))
    // .catch(
    // (err) => dispatch(receiveSessionErrors(err))
    // )
  )
);
