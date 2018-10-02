export const signin = user => (
  fetch('REDACTED URL', {
    method: "POST",
    cache: "no-cache",
    credentials: "same-origin",
    headers: {
        "Content-Type": "application/json; charset=utf-8"
    },
    body: JSON.stringify({
      "username":user.email,
      "password":user.password,
      "client_id":"REDACTED",
      "grant_type":"password",
      "deviceId":"REDACTED",
      "deviceName":"Computer"
    }),
  }).then(response => response.json())
);

// FROM https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch
//
// function postData(url = ``, data = {}) {
//   // Default options are marked with *
//     return fetch(url, {
//         method: "POST", // *GET, POST, PUT, DELETE, etc.
//         mode: "cors", // no-cors, cors, *same-origin
//         cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
//         credentials: "same-origin", // include, same-origin, *omit
//         headers: {
//             "Content-Type": "application/json; charset=utf-8",
//             // "Content-Type": "application/x-www-form-urlencoded",
//         },
//         redirect: "follow", // manual, *follow, error
//         referrer: "no-referrer", // no-referrer, *client
//         body: JSON.stringify(data), // body data type must match "Content-Type" header
//     })
//     .then(response => response.json()); // parses response to JSON
// }
//
// var url = 'https://example.com/profile';
// var data = {username: 'example'};
//
// fetch(url, {
//   method: 'POST', // or 'PUT'
//   body: JSON.stringify(data), // data can be `string` or {object}!
//   headers:{
//     'Content-Type': 'application/json'
//   }
// }).then(res => res.json())
// .then(response => console.log('Success:', JSON.stringify(response)))
// .catch(error => console.error('Error:', error));
