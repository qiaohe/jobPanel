//
//  GrowingDetailViewController.m
//  Recruitment
//
//  Created by M J on 13-10-14.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "GrowingDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface GrowingDetailViewController ()


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
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeButton setBackgroundColor:color(clearColor)];
    [homeButton setTag:102];
    [homeButton setImage:imageNameAndType(@"returnhome_normal", @"png") forState:UIControlStateNormal];
    [homeButton setImage:imageNameAndType(@"returnhome_press", @"png") forState:UIControlStateHighlighted];
    [self setPopToMainViewButton:homeButton];
    [self setBottomBarItems:@[homeButton]];
    [self setBottomBarBackGroundImage:imageNameAndType(@"bottombar", @"png")];
    
    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, controlYLength(self.topBar), self.view.frame.size.width - 40, 30)];
    [_dateLabel setText:[Utils stringWithDate:[NSDate date] withFormat:@"MM月dd日 / HH:mm"]];
    [_dateLabel setBackgroundColor:color(clearColor)];
    [_dateLabel setFont:[UIFont systemFontOfSize:13]];
    [self.contentView addSubview:_dateLabel];
    
    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, controlYLength(_dateLabel), self.view.frame.size.width, 5)];
    [line1 setBackgroundColor:color(clearColor)];
    [line1 setImage:imageNameAndType(@"resume_line", @"png")];
    [self.contentView addSubview:line1];
    
    _userPicture = [[UIImageView alloc]initWithFrame:[self frameWithRect:CGRectMake(_dateLabel.frame.origin.x, controlYLength(line1) + 15, _dateLabel.frame.size.width, line1.frame.size.width * 3/5) adaptWidthOrHeight:adaptWidth]];
    [_userPicture setBackgroundColor:color(clearColor)];
    [_userPicture setImage:imageNameAndType(@"resume_item", @"png")];
    [self.contentView addSubview:_userPicture];
    
    UIImageView *addResumeBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(_userPicture.frame.origin.x, controlYLength(_userPicture) - 35, _userPicture.frame.size.width, 35)];
    [addResumeBackImage setBackgroundColor:color(clearColor)];
    [addResumeBackImage setUserInteractionEnabled:YES];
    [addResumeBackImage setImage:imageNameAndType(@"resume_add_backimage", @"png")];
    [self.contentView addSubview:addResumeBackImage];
    
    UIImageView *addLeftImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, addResumeBackImage.frame.size.height, addResumeBackImage.frame.size.height)];
    [addLeftImage setFrame:CGRectMake(5, 0, addResumeBackImage.frame.size.height, addResumeBackImage.frame.size.height)];
    [addLeftImage setBackgroundColor:color(clearColor)];
    [addResumeBackImage addSubview:addLeftImage];
    
    UILabel *locationlabel = [[UILabel alloc]initWithFrame:CGRectMake(controlXLength(addLeftImage) + 5, 0, (addResumeBackImage.frame.size.width - controlXLength(addLeftImage) - 5 - 5)*2/3, addResumeBackImage.frame.size.height)];
    [locationlabel setBackgroundColor:color(clearColor)];
    [locationlabel setText:@"上海市"];
    [locationlabel setFont:[UIFont systemFontOfSize:12]];
    [locationlabel setTextColor:color(whiteColor)];
    [addResumeBackImage addSubview:locationlabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:color(clearColor)];
    [button setTitle:@"添加到简历" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 0)];
    [button setFrame:CGRectMake(addResumeBackImage.frame.size.width - locationlabel.frame.size.width/2 - 10, 0, locationlabel.frame.size.width/2, addResumeBackImage.frame.size.height)];
    [button setBackgroundImage:imageNameAndType(@"resume_add_normal", @"png") forState:UIControlStateNormal];
    [button setBackgroundImage:imageNameAndType(@"resume_add_press", @"png") forState:UIControlStateHighlighted];
    [addResumeBackImage addSubview:button];
        
    UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(line1.frame.origin.x, controlYLength(_userPicture) + 15, line1.frame.size.width, line1.frame.size.height)];
    [line2 setBackgroundColor:color(clearColor)];
    [line2 setImage:imageNameAndType(@"resume_line", @"png")];
    [self.contentView addSubview:line2];
    
    UIImageView *titleTextBackImage = [[UIImageView alloc]initWithFrame:[self frameWithRect:CGRectMake(_dateLabel.frame.origin.x + 5, controlYLength(line2) + 10, self.view.frame.size.width/2, 35) adaptWidthOrHeight:adaptWidth]];
    [titleTextBackImage setBackgroundColor:color(clearColor)];
    [titleTextBackImage setImage:stretchImage(@"resume_textbackground", @"png")];
    [self.contentView addSubview:titleTextBackImage];
    
    _titleText = [[UITextField alloc]initWithFrame:CGRectMake(titleTextBackImage.frame.origin.x + 10, titleTextBackImage.frame.origin.y, titleTextBackImage.frame.size.width - 10, titleTextBackImage.frame.size.height)];
    [_titleText setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_titleText setPlaceholder:@"标题"];
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
    [self.contentView addSubview:_detailText];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setBackgroundColor:color(clearColor)];
    [doneButton setFrame:CGRectMake(self.view.frame.size.width/4, controlYLength(_detailText) + 25, self.view.frame.size.width/2, 40)];
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton setBackgroundImage:imageNameAndType(@"resume_done_normal", @"png") forState:UIControlStateNormal];
    [doneButton setBackgroundImage:imageNameAndType(@"resume_done_press", @"png") forState:UIControlStateHighlighted];
    [self.contentView addSubview:doneButton];
}

- (void)pressCameraButton:(UIButton*)sender
{
    
}

- (void)pressVoiceButton:(UIButton*)sender
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
        if (responder.frame.origin.y + 40 - self.contentView.contentOffset.y > self.view.frame.size.height - frame.size.height) {
            CGFloat changeY = responder.frame.origin.y + 40 - self.contentView.contentOffset.y - (self.view.frame.size.height - frame.size.height);
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
