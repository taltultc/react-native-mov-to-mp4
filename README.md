# react-native-mov-to-mp4

Convert mov file to mp4 for cross-platform playback compatibility.

## Installation

**react-native >= 0.40:**

```
npm install react-native-mov-to-mp4 --save
```

also for iOS:

```
cd ios && pod install && cd ..
```

**react-native < 0.40:**

```
npm install react-native-mov-to-mp4@0.1 --save
```

link react-native-mov-to-mp4:


```ruby
react-native link react-native-mov-to-mp4
```

```javascript
import MovToMp4 from 'react-native-mov-to-mp4';

const filename = Date.now().toString();
MovToMp4.convertMovToMp4(data.path, filename + ".mp4")
  .then(function (results) {
    //here you can upload the video...
    console.log(results);
  });
          
```

**Parameters:**

```
convertMovToMp4(videoFilePath,newFilenameMp4,callback)
```

## Example

this example use [react-native-camera](https://github.com/react-native-community/react-native-camera)

```javascript
render() {
    return (
      <View style={styles.container}>
        <Camera
            ref={(cam) => {
            this.camera = cam;
          }}
            captureTarget={Camera.constants.CaptureTarget.disk}
            captureMode={Camera.constants.CaptureMode.video}
            style={styles.preview}
            aspect={Camera.constants.Aspect.fill}>
          <Text style={styles.capture} onPress={this.takeVideo.bind(this)}>[CAPTURE]</Text>
        </Camera>
      </View>
    );
  }
  takeVideo() {
    if(this.isRec){
      this.isRec = false;
      this.camera.stopCapture();
    }else {
      this.isRec = true;
      this.camera.capture()
          .then((data) => {
            const filename = Date.now().toString();
            MovToMp4.convertMovToMp4(data.path, filename + ".mp4")
              .then(function (results) {
              //here you can upload the video...
              console.log(results);
            });
          })
          .catch(err => console.error(err));
    }
  }
```

## License

MIT
