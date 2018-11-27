import * as OrganizationApiUtil from '../utils/organization_api_utils';

export const RECEIVE_ORGANIZATION = "RECEIVE_ORGANIZATION";

const receiveOrganization = organization => ({
  type: RECEIVE_ORGANIZATION,
  organization: organization
});

export const fetchOrganization = organizationId => dispatch => (
  OrganizationApiUtil.fetchOrganization(organizationId)
  .then(
    (dbOrganization) => {
      dbOrganization.data.id = organizationId;
      return dispatch(receiveOrganization(dbOrganization.data));
    }
  )
);
