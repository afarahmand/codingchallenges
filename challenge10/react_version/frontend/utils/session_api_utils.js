const axios = require('axios');

export const signin = userId => (
  axios.get(`REDACTED${userId}`)
);

// 'u2kjfladadwddj9'
