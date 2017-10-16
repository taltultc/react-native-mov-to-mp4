#import "movToMp4.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVMediaFormat.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation movToMp4

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(convertMovToMp4: (NSString*)filename
                  toPath:(NSString*)outputPath
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    // Your implementation here


    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];






    NSURL *ouputURL2 = [NSURL fileURLWithPath:[docDir stringByAppendingPathComponent:outputPath]];
    //NSLog(@"fsdf %@", ouputURL2);
    NSString *newFile = [ouputURL2 absoluteString];
    NSURL *urlFile = [NSURL fileURLWithPath:filename];
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:urlFile options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession
                                  exportPresetsCompatibleWithAsset:avAsset];
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset presetName:AVAssetExportPresetHighestQuality];
    //AVAssetExportPresetMediumQuality
    NSString* domain = @"MovToMp4";
    NSString* documentsDirectory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    exportSession.outputURL = ouputURL2;
    //set the output file format if you want to make it in other file format (ex .3gp)
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse = YES;

    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        switch ([exportSession status])
        {
            case AVAssetExportSessionStatusFailed:
            {
                NSError *error = [NSError errorWithDomain:domain code: -90 userInfo:nil];
                reject(@"Failed", @"Export session failed", error);
                break;
            }
            case AVAssetExportSessionStatusCancelled:
            {
                NSError *error = [NSError errorWithDomain:domain code: -91 userInfo:nil];
                reject(@"Cancelled", @"Export canceled", error);
                break;
            }
            case AVAssetExportSessionStatusCompleted:
            {
                //Video conversion finished
                //NSLog(@"Successful!");
                resolve(@[newFile]);
            }
                break;
            default:
            {
                NSError *error = [NSError errorWithDomain:domain code: -91 userInfo:nil];
                reject(@"Unknown", @"Unknown status", error);
                break;
            }
        }
    }];


    //[self convertVideoToMP4AndFixMooV:filename toPath:docDir];
}

-(void) convertVideoToMP4AndFixMooV: (NSString*)filename toPath:(NSString*)outputPath
{

    NSURL *url = [NSURL fileURLWithPath:filename];
    AVAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];


    AVAssetExportSession *exportSession = [AVAssetExportSession
                                           exportSessionWithAsset:avAsset
                                           presetName:AVAssetExportPresetPassthrough];


    exportSession.outputURL = [NSURL fileURLWithPath:outputPath];
    exportSession.outputFileType = AVFileTypeAppleM4V;


    // This should move the moov atom before the mdat atom,
    // hence allow playback before the entire file is downloaded
    exportSession.shouldOptimizeForNetworkUse = YES;


    [exportSession exportAsynchronouslyWithCompletionHandler:
     ^{

         if (AVAssetExportSessionStatusCompleted == exportSession.status) {}
         else if (AVAssetExportSessionStatusFailed == exportSession.status) {
             NSLog(@"AVAssetExportSessionStatusFailed");
         }
         else
         {
             NSLog(@"Export Session Status: %d", exportSession.status);
         }
     }];
}



@end
