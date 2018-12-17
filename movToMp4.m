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
                 rejecter:(RCTPromiseRejectBlock)reject
                )
{
    NSURL *urlFile = [NSURL fileURLWithPath:filename];
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:urlFile options:nil];

    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];

    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];

    NSString * resultPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.mp4", outputPath];

    exportSession.outputURL = [NSURL fileURLWithPath:resultPath];

    //set the output file format if you want to make it in other file format (ex .3gp)
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse = YES;

    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        switch ([exportSession status])
        {
            case AVAssetExportSessionStatusFailed: {
                NSError* error = exportSession.error;
                NSString *codeWithDomain = [NSString stringWithFormat:@"E%@%zd", error.domain.uppercaseString, error.code];
                reject(codeWithDomain, error.localizedDescription, error);
                break;
            }
            case AVAssetExportSessionStatusCancelled:
                NSLog(@"Export canceled");
                break;
            case AVAssetExportSessionStatusCompleted:
            {
                //Video conversion finished
                //NSLog(@"Successful!");
                resolve(resultPath);
            }
                break;
            default:
                break;
        }
    }];


}

@end
