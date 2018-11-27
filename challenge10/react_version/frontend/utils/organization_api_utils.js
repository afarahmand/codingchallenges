const axios = require('axios');

export const fetchOrganization = organizationId => (
  axios.get(
    `REDACTED${organizationId}/billing`
  )
);
