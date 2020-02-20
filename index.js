import { Platform } from "react-native";

import MovToMp4Ios from "./movToMp4.ios.js";
import MovToMp4Android from "./movToMp4.android.js";

const MovToMp4 = Platform.OS === "ios"
  ? MovToMp4Ios
  : MovToMp4Android;

export default MovToMp4;
