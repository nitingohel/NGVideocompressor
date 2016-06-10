//
//  VisionCameraViewController.h
//  NGVideocompressor
//
//  Created by Nitin Gohel on 10/06/16.
//  Copyright © 2016 Nitin Gohel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>

@protocol CustomCameraDelegate <NSObject>
- (void)customCameraDidEndCapturingVideo:(NSURL*)path error:(NSError*)error;
- (NSURL*)customCameraOutputPath;
- (BOOL)customCameraShouldMergeVideos;
@end


@interface VisionCameraViewController : UIViewController
@property (assign) CGFloat maxDuration;
- (instancetype)initWithDelegate:(id<CustomCameraDelegate>)delegate;
@property (assign) id <CustomCameraDelegate> delegate;
@end
