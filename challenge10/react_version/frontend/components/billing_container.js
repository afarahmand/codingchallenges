import { connect } from 'react-redux';
import Billing from './billing';
import { fetchOrganization } from '../actions/organization_actions';

const mapStateToProps = state => ({
  currentUser: state.session.currentUser,
  organization: state.entities.organization
});

const mapDispatchToProps = dispatch => ({
  fetchOrganization: orgId => dispatch(fetchOrganization(orgId))
});

export default connect(mapStateToProps, mapDispatchToProps)(Billing);
