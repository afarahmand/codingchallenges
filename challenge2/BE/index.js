// 1 - Grab 3 zip codes via 3 given Redis keys at the provided ip address
// 2 - Convert zip codes into latitude (lat) and longitude (lon) using
//   zipcodes npm package
// 3 - Grab daily highTemperature and lowTemperature for each lat/lon
//   via DarkSky API
// 4 - Compute average temperature for each location, then composite
//   avg of all locations
// 5 - Output composite avg using console.log
// 6 - POST in json format to given url

const getAverageTemperature = dsApiResponse => {
  let respDaily = JSON.parse(dsApiResponse).daily.data[0];
  return ((respDaily.temperatureHigh+respDaily.temperatureLow)/2);
};

const dsSecretKey = "REDACTED";
const redis = require('redis');
const request = require('request');
const zipcodes = require('zipcodes');

// 1 - Grab zip codes via Redis at g
// By default redis.createClient() will use 127.0.0.1 and port 6379
const redisClient = redis.createClient(6379, 'REDACTED ip address');

redisClient.on('connect', function() {
  // Auth must be the first thing done after connection (else errors/warnings)
  redisClient.auth('REDACTED key');
  console.log('Redis client successfully connected!!!');

  // Get the values for all 3 keys at once
  redisClient.mget(['zipcode1', 'zipcode2', 'zipcode3'], function(err, zcArr){

    let latLons = [];
    let zcObj = {};  // a temp variable; stores output of zipcode module

    for (let zipCode of zcArr) {
      zcObj = zipcodes.lookup(zipCode);
      latLons.push([zcObj.latitude, zcObj.longitude]);
    }

    let urls = [];   // stores 3 urls, one for each location
    // param str that reduces the amount of data accessed via the DarkSky API
    const base = "https://api.darksky.net/forecast/";
    const paramString = "exclude=currently,minutely,hourly,alerts,flags";

    for (let latLon of latLons) {
      urls.push(
        `${base}${dsSecretKey}/${latLon[0]},${latLon[1]}?${paramString}`
      );
    }

    let sumOfAvgs = 0;
    request.get(urls[0]).on('data', function(apiResponse0){
      sumOfAvgs+=getAverageTemperature(apiResponse0);

      request.get(urls[1]).on('data', function(apiResponse1){
        sumOfAvgs+=getAverageTemperature(apiResponse1);

        request.get(urls[2]).on('data', function(apiResponse2){
          sumOfAvgs+=getAverageTemperature(apiResponse2);

          // 3 - Compute composite AVG
          let compositeAvg = sumOfAvgs/3;
          compositeAvg = Math.round(compositeAvg*1000)/1000;

          // 4 - Output to console
          console.log("The composite average of the average daily",
          "temperature of each of the 3 zip codes is",
          `${compositeAvg} degrees.`);

          // 5 - POST in json format

          const url1 = 'REDACTED url';
          const accessToken = "Bearer REDACTED access token";

          request.post({
            url: url1,
            json: true,
            headers: {
              'Authorization': accessToken,
              'Content-type': 'application/json'
            },
            body: {
              averageTemperature: compositeAvg
            }
          }, function(err4, dbPost) {
            if (err4) {
              console.log("Error posting to endpoint.");
            } else {
              console.log("Successfully posted!!!");
            }
          });
        });
      });
    });
  });
});
