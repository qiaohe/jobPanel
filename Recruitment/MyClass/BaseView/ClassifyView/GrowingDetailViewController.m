//
//  GrowingDetailViewController.m
//  Recruitment
//
//  Created by M J on 13-10-14.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "GrowingDetailViewController.h"
#import "MyGrowing.h"
#import <QuartzCore/QuartzCore.h>

@interface GrowingDetailViewController ()

@property (strong, nonatomic) UIImageView           *addResumeBackImage;

@end

@implementation GrowingDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setSubviewFrame];
    }
    return self;
}

- (id)initWithGrowDetail:(MyGrowing*)grow
{
    self = [super init];
    if (self) {
        _growDetail = grow;
        [self setSubviewFrame];
    }
    return self;
}

- (id)initWithData:(NSMutableDictionary*)data
{
    self = [super init];
    if (self) {
        _dataSource = [NSMutableArray array];
        NSMutableArray *array = [NSMutableArray arrayWithArray:[data allValues]];
        for (NSArray *object in array) {
            [_dataSource addObjectsFromArray:object];
        }
        NSLog(@" count = %u",[_dataSource count]);
        [self setSubviewFrame];
    }
    return self;
}

- (void)pressDoneButton:(UIButton*)sender
{
    if (!_growDetail) {
        _growDetail = [[MyGrowing alloc]init];
        [_dataSource addObject:_growDetail];
    }
    _growDetail.date = _dateLabel.text;
    _growDetail.title = _titleText.text;
    _growDetail.detail = _detailText.text;
    _growDetail.image = [_userPicture imageForState:UIControlStateNormal];
    
    [self popViewControllerTransitionType:TransitionMoveIn completionHandler:^{
        [self.delegate reloadWithData:_dataSource];
    }];
}

- (void)pressAddToResume:(UIButton*)sender
{
    [[Model shareModel]showPromptText:@"添加成功" model:YES];
}

- (void)setSubviewFrame
{
    [self setBackGroundImage:imageNameAndType(@"resume_backimage", @"png")];
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraButton setBackgroundColor:color(clearColor)];
    [cameraButton setFrame:CGRectMake(self.view.frame.size.width - 40 * 2 - 5, returnButton.frame.origin.y, returnButton.frame.size.width, returnButton.frame.size.height)];
    [cameraButton setImage:imageNameAndType(@"resume_camera_normal", @"png") forState:UIControlStateNormal];
    [cameraButton setImage:imageNameAndType(@"resume_camera_press", @"png") forState:UIControlStateNormal];
    [cameraButton setImage:imageNameAndType(@"resume_camera_press", @"png") forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(pressCameraButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraButton];
    
    UIButton *voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [voiceButton setBackgroundColor:color(clearColor)];
    [voiceButton setFrame:CGRectMake(self.view.frame.size.width - 40 * 1 - 5, returnButton.frame.origin.y, returnButton.frame.size.width, returnButton.frame.size.height)];
    [voiceButton setImage:imageNameAndType(@"resume_voice_normal", @"png") forState:UIControlStateNormal];
    [voiceButton setImage:imageNameAndType(@"resume_voice_press", @"png") forState:UIControlStateNormal];
    [voiceButton setImage:imageNameAndType(@"resume_voice_press", @"png") forState:UIControlStateNormal];
    [voiceButton addTarget:self action:@selector(pressVoiceButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:voiceButton];
    /*
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(pressVoiceButton:)];
    // you can control how many seconds before the gesture is recognized
    gesture.minimumPressDuration =  0;
    [voiceButton addGestureRecognizer:gesture];*/
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeButton setBackgroundColor:color(clearColor)];
    [homeButton setTag:102];
    [homeButton setImage:imageNameAndType(@"returnhome_normal", @"png") forState:UIControlStateNormal];
    [homeButton setImage:imageNameAndType(@"returnhome_press", @"png") forState:UIControlStateHighlighted];
    [self setPopToMainViewButton:homeButton];
    [self setBottomBarItems:@[homeButton]];
    [self setBottomBarBackGroundImage:imageNameAndType(@"bottombar", @"png")];
    
    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, controlYLength(self.topBar), self.view.frame.size.width - 40, 30)];
    NSString *dateText = _growDetail?_growDetail.date:[Utils stringWithDate:[NSDate date] withFormat:@"yyyy年MM月dd日 / HH:mm"];
    [_dateLabel setText:dateText];
    [_dateLabel setBackgroundColor:color(clearColor)];
    [_dateLabel setFont:[UIFont systemFontOfSize:13]];
    [self.contentView addSubview:_dateLabel];
    
    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, controlYLength(_dateLabel), self.view.frame.size.width, 5)];
    [line1 setBackgroundColor:color(clearColor)];
    [line1 setImage:imageNameAndType(@"resume_line", @"png")];
    [self.contentView addSubview:line1];
    
    _userPicture = [UIButton buttonWithType:UIButtonTypeCustom];
    [_userPicture setFrame:CGRectMake(_dateLabel.frame.origin.x, controlYLength(line1) + 15, _dateLabel.frame.size.width, line1.frame.size.width * 3/5)];
    [_userPicture setBackgroundColor:color(clearColor)];
    [_userPicture addTarget:self action:@selector(pressUserPicture:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *userImage = _growDetail?_growDetail.image:imageNameAndType(@"resume_item", @"png");
    [_userPicture setImage:userImage forState:UIControlStateNormal];
    [_userPicture setImage:userImage forState:UIControlStateHighlighted];
    [self.contentView addSubview:_userPicture];
    
    _addResumeBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(_userPicture.frame.origin.x, controlYLength(_userPicture) - 35/2, _userPicture.frame.size.width, 35)];
    _addResumeBackImage.layer.anchorPoint = CGPointMake(0.5f, 1.0f);
    [_addResumeBackImage setBackgroundColor:color(clearColor)];
    [_addResumeBackImage setUserInteractionEnabled:YES];
    [_addResumeBackImage setImage:imageNameAndType(@"resume_add_backimage", @"png")];
    [self.contentView addSubview:_addResumeBackImage];
    
    UIImageView *addLeftImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, _addResumeBackImage.frame.size.height, _addResumeBackImage.frame.size.height)];
    [addLeftImage setFrame:CGRectMake(5, 0, _addResumeBackImage.frame.size.height, _addResumeBackImage.frame.size.height)];
    [addLeftImage setBackgroundColor:color(clearColor)];
    [addLeftImage setBounds:CGRectMake(0, 0, addLeftImage.frame.size.width * 0.5, addLeftImage.frame.size.height * 0.5)];
    [addLeftImage setImage:imageNameAndType(@"resume_location", @"png")];
    [_addResumeBackImage addSubview:addLeftImage];
    
    UILabel *locationlabel = [[UILabel alloc]initWithFrame:CGRectMake(controlXLength(addLeftImage) + 5, 0, (_addResumeBackImage.frame.size.width - controlXLength(addLeftImage) - 5 - 5)*2/3, _addResumeBackImage.frame.size.height)];
    [locationlabel setBackgroundColor:color(clearColor)];
    [locationlabel setText:@"上海市"];
    [locationlabel setTag:201];
    [locationlabel setFont:[UIFont systemFontOfSize:12]];
    [locationlabel setTextColor:color(whiteColor)];
    [_addResumeBackImage addSubview:locationlabel];
    
    UIButton *addToResume = [UIButton buttonWithType:UIButtonTypeCustom];
    [addToResume setBackgroundColor:color(clearColor)];
    [addToResume setTitle:@"添加到简历" forState:UIControlStateNormal];
    [addToResume.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [addToResume setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 0)];
    [addToResume setTag:202];
    [addToResume setFrame:CGRectMake(_addResumeBackImage.frame.size.width - locationlabel.frame.size.width/2 - 10, 0, locationlabel.frame.size.width/2, _addResumeBackImage.frame.size.height)];
    [addToResume addTarget:self action:@selector(pressAddToResume:) forControlEvents:UIControlEventTouchUpInside];
    [addToResume setBackgroundImage:imageNameAndType(@"resume_add_normal", @"png") forState:UIControlStateNormal];
    [addToResume setBackgroundImage:imageNameAndType(@"resume_add_press", @"png") forState:UIControlStateHighlighted];
    [_addResumeBackImage addSubview:addToResume];
    
    CGAffineTransform currentTransform = _addResumeBackImage.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, 1.0, 0.1);
    [_addResumeBackImage setTransform:newTransform];
    [_addResumeBackImage setHidden:YES];
        
    UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(line1.frame.origin.x, controlYLength(_userPicture) + 15, line1.frame.size.width, line1.frame.size.height)];
    [line2 setBackgroundColor:color(clearColor)];
    [line2 setImage:imageNameAndType(@"resume_line", @"png")];
    [self.contentView addSubview:line2];
    
    UIImageView *titleTextBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(_dateLabel.frame.origin.x + 5, controlYLength(line2) + 10, self.view.frame.size.width/2, 35)];
    [titleTextBackImage setBackgroundColor:color(clearColor)];
    [titleTextBackImage setImage:stretchImage(@"resume_field_backimage", @"png")];
    [self.contentView addSubview:titleTextBackImage];
    
    _titleText = [[UITextField alloc]initWithFrame:CGRectMake(titleTextBackImage.frame.origin.x + 10, titleTextBackImage.frame.origin.y, titleTextBackImage.frame.size.width - 10, titleTextBackImage.frame.size.height)];
    [_titleText setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_titleText setPlaceholder:@"标题"];
    [_titleText setText:_growDetail?_growDetail.title:nil];
    [_titleText setDelegate:self];
    [_titleText setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:_titleText];
    
    UIImageView *detailTextBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(titleTextBackImage.frame.origin.x, controlYLength(titleTextBackImage) + 15, self.view.frame.size.width - titleTextBackImage.frame.origin.x * 2, _titleText.frame.size.height * 2)];
    [detailTextBackImage setBackgroundColor:color(clearColor)];
    [detailTextBackImage setImage:stretchImage(@"resume_textbackground", @"png")];
    [self.contentView addSubview:detailTextBackImage];
    
    _detailText = [[UITextView alloc]initWithFrame:CGRectMake(detailTextBackImage.frame.origin.x, detailTextBackImage.frame.origin.y, detailTextBackImage.frame.size.width, detailTextBackImage.frame.size.height)];
    [_detailText setBackgroundColor:color(clearColor)];
    [_detailText setFont:[UIFont systemFontOfSize:14]];
    [_detailText setDelegate:self];
    [_detailText setText:_growDetail?_growDetail.detail:nil];
    [self.contentView addSubview:_detailText];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setBackgroundColor:color(clearColor)];
    [doneButton setFrame:CGRectMake(self.view.frame.size.width/4, controlYLength(_detailText) + 25, self.view.frame.size.width/2, 40)];
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton setBackgroundImage:imageNameAndType(@"resume_done_normal", @"png") forState:UIControlStateNormal];
    [doneButton setBackgroundImage:imageNameAndType(@"resume_done_press", @"png") forState:UIControlStateHighlighted];
    [doneButton addTarget:self action:@selector(pressDoneButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:doneButton];
}

- (void)pressUserPicture:(UIButton*)sender
{
    BOOL hidden = _addResumeBackImage.hidden?NO:YES;
    if (hidden) {
        [UIView animateWithDuration:0.15
                         animations:^{
                             CGAffineTransform currentTransform = _addResumeBackImage.transform;
                             CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, 1.0, 0.1);
                             [_addResumeBackImage setTransform:newTransform];
                         }completion:^(BOOL finished){
                             _addResumeBackImage.hidden = hidden;
                         }];
    }else{
        _addResumeBackImage.hidden = hidden;
        [UIView animateWithDuration:0.15
                         animations:^{
                             CGAffineTransform currentTransform = _addResumeBackImage.transform;
                             CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, 1.0, 10);
                             [_addResumeBackImage setTransform:newTransform];
                         }completion:^(BOOL finished){
                             
                         }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_userPicture setImage:image forState:UIControlStateNormal];
    [_userPicture setImage:image forState:UIControlStateHighlighted];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)pressCameraButton:(UIButton*)sender
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册中选择", nil];
    alertView.tag = 301;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 301) {
        switch (buttonIndex) {
            case 1:{
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
                if ([UIImagePickerController isSourceTypeAvailable:
                     UIImagePickerControllerSourceTypeCamera]) {
                    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    imagePicker.delegate = self;
                    [imagePicker setAllowsEditing:NO];
                    //imagePicker.allowsImageEditing = NO;
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }

                break;
            }
            case 2:{
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
                if ([UIImagePickerController isSourceTypeAvailable:
                     UIImagePickerControllerSourceTypePhotoLibrary]) {
                    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    imagePicker.delegate = self;
                    [imagePicker setAllowsEditing:NO];
                    //imagePicker.allowsImageEditing = NO;
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }

                break;
            }
            default:
                break;
        }
    }else if (alertView.tag == 302){
        switch (buttonIndex) {
            case 1:{
                [[Model shareModel] showPromptText:@"录音中..." model:YES];
                break;
            }case 2:{
                [[Model shareModel] showPromptText:@"播放录音" model:YES];
                break;
            }
            default:
                break;
        }
    }
}

- (void)pressVoiceButton:(UILongPressGestureRecognizer *)gesture
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"录音",@"播放录音", nil];
    [alertView setTag:302];
    [alertView show];
    /*
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Touch down");
        
        [self startRecording];
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        NSLog(@"Long press Ended");
        
        [self stopRecording];
    }*/
}

- (void)startRecording
{
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] initWithCapacity:10];
    if(recordEncoding == ENC_PCM)
    {
        [recordSettings setObject:[NSNumber numberWithInt: kAudioFormatLinearPCM] forKey: AVFormatIDKey];
        [recordSettings setObject:[NSNumber numberWithFloat:44100.0] forKey: AVSampleRateKey];
        [recordSettings setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
        [recordSettings setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        [recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
        [recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    }
    else
    {
        NSNumber *formatObject;
        
        switch (recordEncoding) {
            case (ENC_AAC):
                formatObject = [NSNumber numberWithInt: kAudioFormatMPEG4AAC];
                break;
            case (ENC_ALAC):
                formatObject = [NSNumber numberWithInt: kAudioFormatAppleLossless];
                break;
            case (ENC_IMA4):
                formatObject = [NSNumber numberWithInt: kAudioFormatAppleIMA4];
                break;
            case (ENC_ILBC):
                formatObject = [NSNumber numberWithInt: kAudioFormatiLBC];
                break;
            case (ENC_ULAW):
                formatObject = [NSNumber numberWithInt: kAudioFormatULaw];
                break;
            default:
                formatObject = [NSNumber numberWithInt: kAudioFormatAppleIMA4];
        }
        
        [recordSettings setObject:formatObject forKey: AVFormatIDKey];
        [recordSettings setObject:[NSNumber numberWithFloat:44100.0] forKey: AVSampleRateKey];
        [recordSettings setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
        [recordSettings setObject:[NSNumber numberWithInt:12800] forKey:AVEncoderBitRateKey];
        [recordSettings setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        [recordSettings setObject:[NSNumber numberWithInt: AVAudioQualityHigh] forKey: AVEncoderAudioQualityKey];
    }
    
    NSString *soundFilePath = nil;
    
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDirectory = false;
        if (![fileManager fileExistsAtPath:DOCUMENTS_FOLDER_AUDIO isDirectory:&isDirectory]) {
            NSError *error = nil;
            BOOL createDone = [fileManager createDirectoryAtPath:DOCUMENTS_FOLDER_AUDIO withIntermediateDirectories:YES attributes:nil error:&error];
            if (!createDone) {
                NSLog(@"error = %@",error);
                [[Model shareModel] showPromptText:@"创建本地音频库失败" model:YES];
                return;
            }
        }
        soundFilePath = [DOCUMENTS_FOLDER_AUDIO stringByAppendingPathComponent:@"recordFile"];
    }
    
    NSLog(@"path = %@",soundFilePath);
    
    NSURL *url = [NSURL fileURLWithPath:soundFilePath];
    
    NSError *error = nil;
    audioRecorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSettings error:&error];
    audioRecorder.meteringEnabled = YES;
    if ([audioRecorder prepareToRecord] == YES){
        audioRecorder.meteringEnabled = YES;
        [audioRecorder record];
        timerForPitch =[NSTimer scheduledTimerWithTimeInterval:0.01 target: self selector: @selector(levelTimerCallback:) userInfo:nil repeats:YES];
    }else {
        int errorCode = CFSwapInt32HostToBig ([error code]);
        NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode);
        
    }
}

- (void) stopRecording
{
    NSLog(@"stopRecording");
    [audioRecorder stop];
    [timerForPitch invalidate];
    timerForPitch = nil;
}

- (void)levelTimerCallback:(id)userInfo
{
    
}

- (void)pressReturnButton:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark - keyboard show or dismiss
- (void)keyBoardWillShow:(NSNotification *)notification
{
    [super keyBoardWillShow:notification];
    UIView *keyBoard = [self findKeyboard];
    if (!keyBoard) {
        //CGPoint beginCentre = [[[notification userInfo] valueForKey:UIKeyboardFrameBeginUserInfoKey] CGPointValue];
        //CGPoint endCentre = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGPointValue];
        //CGRect keyboardBounds = [[[notification userInfo] valueForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
        CGRect keyboardFrames = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        //UIViewAnimationCurve animationCurve = [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
        NSTimeInterval animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        [self keyBoardShow:keyboardFrames animationDuration:animationDuration];
    }
}

- (void)keyBoardWillHide:(NSNotification *)notification
{
    [super keyBoardWillHide:notification];
    UIView *keyBoard = [self findKeyboard];
    if (keyBoard) {
        CGRect keyboardFrames = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        NSTimeInterval animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        [self keyBoardHide:keyboardFrames animationDuration:animationDuration];
    }
}


- (void)keyBoardChangeFrame:(NSNotification *)notification
{
    [super keyBoardWillHide:notification];
    UIView *keyBoard = [self findKeyboard];
    if (keyBoard) {
        //CGPoint beginCentre = [[[notification userInfo] valueForKey:UIKeyboardFrameBeginUserInfoKey] CGPointValue];
        //CGPoint endCentre = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGPointValue];
        //CGRect keyboardBounds = [[[notification userInfo] valueForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
        CGRect keyboardFrames = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        //UIViewAnimationCurve animationCurve = [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
        
        [self keyBoardShow:keyboardFrames animationDuration:0.35f];
    }
}

- (void)keyBoardShow:(CGRect)frame animationDuration:(NSTimeInterval)duration
{
    UIView *responder = nil;
    if ([_titleText isFirstResponder]) {
        responder = _titleText;
    }else if ([_detailText isFirstResponder]) {
        responder = _detailText;
    }
    if (responder) {
        if (controlYLength(responder) - self.contentView.contentOffset.y > self.view.frame.size.height - frame.size.height) {
            CGFloat changeY = controlYLength(responder) - self.contentView.contentOffset.y - (self.view.frame.size.height - frame.size.height);
            changeY = changeY >= 0?changeY:0;
            [UIView animateWithDuration:duration
                             animations:^{
                                 self.contentView.frame = CGRectMake(self.view.frame.origin.x, 0 - changeY, self.view.frame.size.width, self.view.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 
                             }];
        }
    }
}

- (void)keyBoardHide:(CGRect)frame animationDuration:(NSTimeInterval)duration
{
    UIView *responder = nil;
    if ([_titleText isFirstResponder]) {
        responder = _titleText;
    }else if ([_detailText isFirstResponder]) {
        responder = _detailText;
    }
    if (responder) {
        if (responder.frame.origin.y + 40 - self.contentView.contentOffset.y < frame.origin.y) {
            [UIView animateWithDuration:duration
                             animations:^{
                                 self.contentView.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 
                             }];
        }
    }
}


- (BOOL)clearKeyBoard
{
    BOOL canResignFirstResponder = NO;
    if ([_titleText isFirstResponder]) {
        [_titleText resignFirstResponder];
        canResignFirstResponder  = YES;
    }else if ([_detailText isFirstResponder]) {
        [_detailText resignFirstResponder];
        canResignFirstResponder  = YES;
    }
    return canResignFirstResponder;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
