//
//  InformationDetailViewController.m
//  Recruitment
//
//  Created by M J on 13-10-16.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "InformationDetailViewController.h"

@interface InformationDetailViewController ()

@end

@implementation InformationDetailViewController

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
    [self setBackGroundImage:imageNameAndType(@"information_backimage", @"png")];
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setTitle:@"公司详情"];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    UIImageView *item1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, controlYLength(self.topBar), self.contentView.frame.size.width, 500)];
    [item1 setBackgroundColor:color(clearColor)];
    [item1 setImage:imageNameAndType(@"detail_item1", @"png")];
    [self.contentView addSubview:item1];
    
    UIImageView *item2 = [[UIImageView alloc]initWithFrame:CGRectMake(item1.frame.origin.x + 10, controlYLength(item1) + 10, item1.frame.size.width - 20, 110)];
    [item2 setBackgroundColor:color(clearColor)];
    [item2 setImage:imageNameAndType(@"detail_item2", @"png")];
    [self.contentView addSubview:item2];
    
    UIImageView *appraiseBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, controlYLength(item2) + 15, self.contentView.frame.size.width - 20, 45)];
    [appraiseBackImage setBackgroundColor:color(clearColor)];
    [appraiseBackImage setImage:imageNameAndType(@"information_textimage", @"png")];
    [self.contentView addSubview:appraiseBackImage];
    
    _appraiseText = [[UITextView alloc]initWithFrame:appraiseBackImage.frame];
    [_appraiseText setBackgroundColor:color(clearColor)];
    [_appraiseText setText:@"我来评价..."];
    [self.contentView addSubview:_appraiseText];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setBackgroundColor:color(clearColor)];
    [doneButton setFrame:CGRectMake(self.view.frame.size.width/4, controlYLength(_appraiseText) + 10, self.view.frame.size.width/2, 40)];
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton setBackgroundImage:imageNameAndType(@"resume_done_normal", @"png") forState:UIControlStateNormal];
    [doneButton setBackgroundImage:imageNameAndType(@"resume_done_press", @"png") forState:UIControlStateHighlighted];
    [self.contentView addSubview:doneButton];
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeButton setBackgroundColor:color(clearColor)];
    [homeButton setTag:102];
    [homeButton setImage:imageNameAndType(@"returnhome_normal", @"png") forState:UIControlStateNormal];
    [homeButton setImage:imageNameAndType(@"returnhome_press", @"png") forState:UIControlStateHighlighted];
    [self setPopToMainViewButton:homeButton];
    [self setBottomBarItems:@[homeButton]];
    [self setBottomBarBackGroundImage:imageNameAndType(@"bottombar", @"png")];
}

- (BOOL)clearKeyBoard
{
    BOOL canResignFirstResponder = NO;
    if ([_appraiseText isFirstResponder]) {
        [_appraiseText resignFirstResponder];
        canResignFirstResponder = YES;
    }
    return canResignFirstResponder;
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
    if ([_appraiseText isFirstResponder]) {
        responder = _appraiseText;
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
    if ([_appraiseText isFirstResponder]) {
        responder = _appraiseText;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
