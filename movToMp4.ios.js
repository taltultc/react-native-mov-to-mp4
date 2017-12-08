/**
 * @providesModule movToMp4
 * @flow
 */
import React, { Component, PropTypes } from 'react';
import {
    DeviceEventEmitter, // android
    NativeAppEventEmitter, // ios
    NativeModules,
    Platform,
    StyleSheet,
    requireNativeComponent,
    View,
} from 'react-native';

//var NativemovToMp4 = require('NativeModules').movToMp4;
var NativemovToMp4 = NativeModules.movToMp4;
/**
 * High-level docs for the movToMp4 iOS API can be written here.
 */

var movToMp4 = {
  convertMovToMp4: function(filename, dest, cb) {
    NativemovToMp4.convertMovToMp4(filename, dest, cb);
  }
};

module.exports = movToMp4;
