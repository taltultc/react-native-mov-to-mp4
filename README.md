# react-native-mov-to-mp4

Convert `.mov` file to `.mp4` file format

## Installation

#### 1. Add react-native-mov-to-mp4 to your dependencies

#### For react-native >= 0.40:

```ruby
yarn add react-native-mov-to-mp4@0.2
```

(or)

For npm use

```ruby
$ npm install --save react-native-mov-to-mp4@0.2
```

#### For react-native < 0.40:

```ruby
yarn add react-native-mov-to-mp4@0.1
```

(or)

For npm use

```ruby
$ npm install react-native-mov-to-mp4@0.1 --save
```

#### 2. Link native dependencies

#### For react-native >= 0.60, autolinking will take care of the link step. Don't forget to run `pod install` in the `ios/` directory.

#### For react native < 0.60, run:

```ruby
react-native link react-native-mov-to-mp4
```

#### 3. Import the converter module into your component

```javascript
import MovToMp4 from "react-native-mov-to-mp4";
```

## API Reference

---

`convertMovToMp4`

convert a .mov file to .mp4 file format.

| Type | Required | Platform |
| ---- | -------- | -------- |
| void | No       | iOS      |

**convertMovToMp4(videoFilePath, newFilenameMp4, callback)**

Example:

```javascript
var filename = Date.now().toString();
MovToMp4.convertMovToMp4(data.path, filename + ".mp4", function(results) {
  //here you can upload the video...
  console.log(results);
});
```

---

## Example

this example use react-native-camera

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
            var filename = Date.now().toString();
            MovToMp4.convertMovToMp4(data.path, filename + ".mp4", function (results) {
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
