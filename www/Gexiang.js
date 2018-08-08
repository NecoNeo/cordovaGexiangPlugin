var exec = require('cordova/exec');

function Gexiang() {}

Gexiang.prototype.startSDKWithAppId = function() {
    exec(function() {}, function() {}, 'CDVGexiang', 'startSDKWithAppId', []);
};

Gexiang.prototype.getGiUid = function(callback) {
    exec(function(result) {
        if (typeof callback === 'function') {
            callback(result);
        }
    }, function() {}, 'CDVGexiang', 'getGiUid', []);
};

// debug use
Gexiang.prototype.openURL = function() {
    exec(function() {}, function() {}, 'CDVGexiang', 'openURL', []);
};

// debug
Gexiang.prototype.debug = function(param) {
    exec(function(result) {
        console.log(result);
    }, function(err) {
        console.warn(err);
    }, 'CDVGexiang', 'debug', [param]);
};

module.exports = new Gexiang();
