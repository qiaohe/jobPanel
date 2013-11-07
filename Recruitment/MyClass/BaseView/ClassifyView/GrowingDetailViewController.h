//
//  GrowingDetailViewController.h
//  Recruitment
//
//  Created by M J on 13-10-14.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "F3BarGauge.h"
#import "ImagePickerViewController.h"

#define         DOCUMENTS_FOLDER_AUDIO          [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"AudioDirectory"]

@class MyGrowing;

@protocol GrowingDetailDelegate <NSObject>

@optional
- (void)reloadWithData:(NSArray*)data;

@end

@interface GrowingDetailViewController : BaseUIViewController<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate,ImagePickerViewControllerDelegate>{
    AVAudioPlayer *audioPlayer;
    AVAudioRecorder *audioRecorder;
    int recordEncoding;
    enum
    {
        ENC_AAC = 1,
        ENC_ALAC = 2,
        ENC_IMA4 = 3,
        ENC_ILBC = 4,
        ENC_ULAW = 5,
        ENC_PCM = 6,
    } encodingTypes;
    
    float Pitch;
    NSTimer *timerForPitch;
    
    ImagePickerViewController *imagePicker;
}

@property (assign, nonatomic) id <GrowingDetailDelegate>    delegate;
@property (strong, nonatomic) UILabel                       *dateLabel;
@property (strong, nonatomic) UIButton                      *userPicture;
@property (strong, nonatomic) UITextField                   *titleText;
@property (strong, nonatomic) UITextView                    *detailText;
@property (strong, nonatomic) MyGrowing                     *growDetail;
@property (strong, nonatomic) NSMutableArray                *dataSource;
@property (nonatomic, strong) CAShapeLayer                  *shapeLayer;
@property (nonatomic, strong) CADisplayLink                 *displayLink;

- (id)initWithGrowDetail:(MyGrowing*)grow;
- (id)initWithData:(NSMutableDictionary*)data;

@end
