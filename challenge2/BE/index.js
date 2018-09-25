// 1 - Grab zip codes via Redis
// 2 - Grab weather info via DarkSky API
// 3 - Compute AVG
// 4 - Output to console
// 5 - POST in json format

const dsSecretKey = "redacted secret key";
const redis = require('redis');
const request = require('request');
const zipcodes = require('zipcodes');

// 1 - Grab zip codes via Redis
// By default redis.createClient() will use 127.0.0.1 and port 6379
const redisClient = redis.createClient(6379, '<redacted IP address');

redisClient.on('connect', function() {
  redisClient.auth('redacted');
  console.log('Redis client connected');
  let zipCodesArr = [];

  redisClient.get('zipcode1', function(err1, dbZC1){
    zipCodesArr.push(dbZC1);
    redisClient.get('zipcode2', function (err2, dbZC2) {
      zipCodesArr.push(dbZC2);
      redisClient.get('zipcode3', function (err3, dbZC3) {
        zipCodesArr.push(dbZC3);

        // Convert zipcodes to long/lat
        let latLon = [];
        let zcObj = {};

        for (let zipCode of zipCodesArr) {
          zcObj = zipcodes.lookup(zipCode);
          console.log([zcObj.latitude, zcObj.longitude]);
          latLon.push([zcObj.latitude, zcObj.longitude]);
        }

        // 2 - Grab weather info via DarkSky API

        const excluded = "exclude=currently,minutely,hourly,alerts,flags";

        const url1 = `https://api.darksky.net/forecast/${dsSecretKey}/${latLon[0][0]},${latLon[0][1]}?${excluded}`;
        const url2 = `https://api.darksky.net/forecast/${dsSecretKey}/${latLon[1][0]},${latLon[1][1]}?${excluded}`;
        const url3 = `https://api.darksky.net/forecast/${dsSecretKey}/${latLon[2][0]},${latLon[2][1]}?${excluded}`;
        let runningAvg = 0;

        request.get(url1).on('data', function(res1){
          let respDaily = JSON.parse(res1).daily.data[0];
          let avgTemp = (respDaily.temperatureHigh+respDaily.temperatureLow)/2;
          runningAvg+=avgTemp;

          request.get(url2).on('data', function(res2){
            respDaily = JSON.parse(res2).daily.data[0];
            avgTemp = (respDaily.temperatureHigh+respDaily.temperatureLow)/2;
            runningAvg+=avgTemp;

            request.get(url3).on('data', function(res3){
              respDaily = JSON.parse(res3).daily.data[0];
              avgTemp = (respDaily.temperatureHigh+respDaily.temperatureLow)/2;
              runningAvg+=avgTemp;

              // 3 - Compute AVG
              runningAvg/=3;
              runningAvg = Math.round(runningAvg*1000)/1000;

              // 4 - Output to console
              console.log(`The composite average of the average daily temperature of the 3 zip codes is ${runningAvg}`);

              // 5 - POST in json format
            });
          });
        });
      });
    });
  });
});
