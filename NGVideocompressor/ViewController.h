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


    NSUInteger tag;
}
@property (strong , nonatomic)UIView * previewView;


@end

