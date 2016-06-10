//
//  ViewController.m
//  NGVideocompressor
//
//  Created by Nitin Gohel on 09/06/16.
//  Copyright © 2016 Nitin Gohel. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage.h"
#import "VisionCameraViewController.h"





@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CustomCameraDelegate>
{

   
}

@end

@implementation ViewController

#pragma mark - view lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    }
- (IBAction)btnOne:(UIButton *)sender {
    
    tag = sender.tag;
    VisionCameraViewController* viewController = [[VisionCameraViewController alloc]initWithDelegate:self];
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:viewController];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:^{}];
}

- (IBAction)Capture:(UIButton *)sender {
    
    
    
}
- (IBAction)play:(UIButton *)sender {
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"youVideo.mp4"];
    NSURL *vedioURL = [NSURL fileURLWithPath:path];
    
    MPMoviePlayerViewController *videoPlayerView = [[MPMoviePlayerViewController alloc] initWithContentURL:vedioURL];
    [self presentMoviePlayerViewControllerAnimated:videoPlayerView];
    [videoPlayerView.moviePlayer play];
}


-(UIImage*)getThumber:(NSURL*)url
{

    
    
   // filepath is your video file path
    
    
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generateImg = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    NSError *error = NULL;
    CMTime time = CMTimeMake(1, 1);
    CGImageRef refImg = [generateImg copyCGImageAtTime:time actualTime:NULL error:&error];
    NSLog(@"error==%@, Refimage==%@", error, refImg);
    
    UIImage *FrameImage= [[UIImage alloc] initWithCGImage:refImg];
    return FrameImage;
    


}
- (void)customCameraDidEndCapturingVideo:(NSURL *)path error:(NSError *)error{
    if(path == nil){
        NSLog(@"\n%s Error: %@",__FUNCTION__,error.localizedDescription);
        return;
    }
    else
    {
        UIButton *button = (UIButton *)[self.view viewWithTag:tag];
        
        [button setBackgroundImage:[self getThumber:path] forState:UIControlStateNormal];
    
    NSLog(@"pathIs %@",path);
    }
}

//- (void)convertVideoToLowQuailtyWithInputURL:(NSURL*)inputURL
//                                   outputURL:(NSURL*)outputURL
//{
//    //setup video writer
//    AVAsset *videoAsset = [[AVURLAsset alloc] initWithURL:inputURL options:nil];
//    
//    AVAssetTrack *videoTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
//    
////    CGSize videoSize = videoTrack.naturalSize;
////    
////    NSDictionary *videoWriterCompressionSettings =  [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1250000], AVVideoAverageBitRateKey, nil];
//    
//    NSDictionary *settings = @{AVVideoCodecKey:AVVideoCodecH264,
//                               AVVideoWidthKey:@(400),
//                               AVVideoHeightKey:@(400),
//                               AVVideoCompressionPropertiesKey:
//                                   @{AVVideoAverageBitRateKey:@(950000),
//                                     AVVideoProfileLevelKey:AVVideoProfileLevelH264Main31, /* Or whatever profile & level you wish to use */
//                                     AVVideoMaxKeyFrameIntervalKey:@(1)}};
//    
//    AVAssetWriterInput* videoWriterInput = [AVAssetWriterInput
//                                            assetWriterInputWithMediaType:AVMediaTypeVideo
//                                            outputSettings:settings];
//    
//    videoWriterInput.expectsMediaDataInRealTime = YES;
//    
//    videoWriterInput.transform = videoTrack.preferredTransform;
//    
//    AVAssetWriter *videoWriter = [[AVAssetWriter alloc] initWithURL:outputURL fileType:AVFileTypeQuickTimeMovie error:nil];
//    
//    [videoWriter addInput:videoWriterInput];
//    
//    //setup video reader
//    NSDictionary *videoReaderSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
//    
//    AVAssetReaderTrackOutput *videoReaderOutput = [[AVAssetReaderTrackOutput alloc] initWithTrack:videoTrack outputSettings:videoReaderSettings];
//    
//    AVAssetReader *videoReader = [[AVAssetReader alloc] initWithAsset:videoAsset error:nil];
//    
//    [videoReader addOutput:videoReaderOutput];
//    
//    //setup audio writer
//    AVAssetWriterInput* audioWriterInput = [AVAssetWriterInput
//                                            assetWriterInputWithMediaType:AVMediaTypeAudio
//                                            outputSettings:nil];
//    
//    audioWriterInput.expectsMediaDataInRealTime = NO;
//    
//    [videoWriter addInput:audioWriterInput];
//    
//    //setup audio reader
//    AVAssetTrack* audioTrack = [[videoAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
//    
//    AVAssetReaderOutput *audioReaderOutput = [AVAssetReaderTrackOutput assetReaderTrackOutputWithTrack:audioTrack outputSettings:nil];
//    
//    AVAssetReader *audioReader = [AVAssetReader assetReaderWithAsset:videoAsset error:nil];
//    
//    [audioReader addOutput:audioReaderOutput];
//    
//    [videoWriter startWriting];
//    
//    //start writing from video reader
//    [videoReader startReading];
//    
//    [videoWriter startSessionAtSourceTime:kCMTimeZero];
//    
//    dispatch_queue_t processingQueue = dispatch_queue_create("processingQueue1", NULL);
//    
//    [videoWriterInput requestMediaDataWhenReadyOnQueue:processingQueue usingBlock:
//     ^{
//         
//         while ([videoWriterInput isReadyForMoreMediaData]) {
//             
//             CMSampleBufferRef sampleBuffer;
//             
//             if ([videoReader status] == AVAssetReaderStatusReading &&
//                 (sampleBuffer = [videoReaderOutput copyNextSampleBuffer])) {
//                 
//                 [videoWriterInput appendSampleBuffer:sampleBuffer];
//                 CFRelease(sampleBuffer);
//             }
//             
//             else {
//                 
//                 [videoWriterInput markAsFinished];
//                 
//                 if ([videoReader status] == AVAssetReaderStatusCompleted) {
//                     
//                     //start writing from audio reader
//                     [audioReader startReading];
//                     
//                     [videoWriter startSessionAtSourceTime:kCMTimeZero];
//                     
//                     dispatch_queue_t processingQueue = dispatch_queue_create("processingQueue2", NULL);
//                     
//                     [audioWriterInput requestMediaDataWhenReadyOnQueue:processingQueue usingBlock:^{
//                         
//                         while (audioWriterInput.readyForMoreMediaData) {
//                             
//                             CMSampleBufferRef sampleBuffer;
//                             
//                             if ([audioReader status] == AVAssetReaderStatusReading &&
//                                 (sampleBuffer = [audioReaderOutput copyNextSampleBuffer])) {
//                                 
//                                 [audioWriterInput appendSampleBuffer:sampleBuffer];
//                                 CFRelease(sampleBuffer);
//                             }
//                             
//                             else {
//                                 
//                                 [audioWriterInput markAsFinished];
//                                 
//                                 if ([audioReader status] == AVAssetReaderStatusCompleted) {
//                                     
//                                     [videoWriter finishWritingWithCompletionHandler:^(){
//                                         
//                                         NSData *videoData = [NSData dataWithContentsOfURL:outputURL];
//                                         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//                                         NSString *documentsDirectory = [paths objectAtIndex:0];
//                                       
//                                        
//                                         
//                                         
//                                         NSString *path_output = [documentsDirectory stringByAppendingPathComponent:@"youVideo_output.mp4"];
//                                         
//                                          [videoData writeToFile:path_output atomically:NO];
//                                         
//                                         NSError *error = nil;
//                                         NSDictionary *attribs = [[NSFileManager defaultManager] attributesOfItemAtPath:path_output error:&error];
//                                         if (attribs) {
//                                             NSString *string = [NSByteCountFormatter stringFromByteCount:[attribs fileSize] countStyle:NSByteCountFormatterCountStyleFile];
//                                             NSLog(@"%@", string);
//                                             
//                                             
////                                             sleep(5);
////                                             
////                                             [self play:nil];
//                                         }
//                                         
//                                        // [self sendMovieFileAtURL:outputURL];
//                                     }];
//                                     
//                                 }
//                             }
//                         }
//                         
//                     }
//                      ];
//                 }
//             }
//         }
//     }
//     ];
//}
@end
