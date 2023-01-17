'use strict';

var Transport = require('azure-iot-device-mqtt').Mqtt;
var Client = require('azure-iot-device').ModuleClient;
var Message = require('azure-iot-device').Message;
var sensor = require("node-dht-sensor");

Client.fromEnvironment(Transport, function (err, client) {
  if (err) {
    throw err;
  } else {
    client.on('error', function (err) {
      throw err;
    });

    // connect to the Edge instance
    client.open(function (err) {
      if (err) {
        throw err;
      } else {
        console.log('IoT Hub module client initialized');

        setInterval(() => {
          console.log("Fetching Temperature and Humidity...");
          sensor.read(11, 4, function(err, temperature, humidity) {
            if (!err) {
              console.log(`temp: ${temperature}°C, humidity: ${humidity}%`);
              var message = { temperature: temperature, humidity: humidity };
              var msgText = JSON.stringify(message);
              var outputMsg = new Message(msgText);
              client.sendOutputEvent('tempHumid', outputMsg, printResultFor('Sending received message'));
            }
          });
        }, 10000);
      }
    });
  }
});


// Helper function to print results in the console
function printResultFor(op) {
  return function printResult(err, res) {
    if (err) {
      console.log(op + ' error: ' + err.toString());
    }
    if (res) {
      console.log(op + ' status: ' + res.constructor.name);
    }
  };
}
