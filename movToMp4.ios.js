/**
 * @providesModule movToMp4
 * @flow
 */
'use strict';

var NativemovToMp4 = require('NativeModules').movToMp4;

/**
 * High-level docs for the movToMp4 iOS API can be written here.
 */

var movToMp4 = {
  convertMovToMp4: function(filename, dest, cb) {
    NativemovToMp4.convertMovToMp4(filename, dest, cb);
  }
};

module.exports = movToMp4;
