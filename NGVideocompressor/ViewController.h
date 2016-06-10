//
//  ViewController.h
//  NGVideocompressor
//
//  Created by Nitin Gohel on 09/06/16.
//  Copyright © 2016 Nitin Gohel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface ViewController : UIViewController
{

    GPUImageMovie *_movieFile;
    GPUImageOutput<GPUImageInput> *_sketchFilter;
    GPUImageMovieWriter *_movieWriter;

}
@property (strong , nonatomic)UIView * previewView;
@property (nonatomic,retain)    GPUImageMovie *movieFile;
@property (nonatomic,retain)    GPUImageOutput<GPUImageInput> *sketchFilter;
@property (nonatomic,retain)    GPUImageMovieWriter *movieWriter;
@property (nonatomic,retain)    GPUImagePixellateFilter *filter;
@property (assign) CGFloat maxDuration;
@end

