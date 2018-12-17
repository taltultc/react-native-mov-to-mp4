/**
 * @providesModule movToMp4
 * @flow
 */
import {
    NativeModules,
} from 'react-native';

//var NativemovToMp4 = require('NativeModules').movToMp4;
var NativemovToMp4 = NativeModules.movToMp4;
/**
 * High-level docs for the movToMp4 iOS API can be written here.
 */

var movToMp4 = {
  convertMovToMp4: NativemovToMp4.convertMovToMp4,
};

module.exports = movToMp4;
