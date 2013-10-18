//
//  RegisterViewController.m
//  Recruitment
//
//  Created by M J on 13-10-12.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "RegisterViewController.h"
#import "HomeViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface RegisterViewController ()

@property (strong, nonatomic) UIView            *detailView;

@end

@implementation RegisterViewController

@synthesize userPicture;
@synthesize currentSubview;

@synthesize userName;
@synthesize phoneNum;
@synthesize email;
@synthesize password;

@synthesize currentPosition;
@synthesize currentCompany;
@synthesize goalCompany;

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
    if (self = [super init]) {
        [self setViewFrame];
    }
    return self;
}

- (void)pressNextButton:(UIButton*)sender
{
    if (currentSubview.tag == 101) {
        UIView *subview = [self createRegisterDetailView];
        sender.enabled = NO;
        subview.frame = CGRectMake(currentSubview.frame.size.width, currentSubview.frame.origin.y, subview.frame.size.width, subview.frame.size.height);
        [_detailView addSubview:subview];
        [UIView animateWithDuration:0.35f
                         animations:^{
                             currentSubview.frame = CGRectMake(-currentSubview.frame.size.width, currentSubview.frame.origin.y, currentSubview.frame.size.width, currentSubview.frame.size.height);
                             subview.frame = CGRectMake(0, currentSubview.frame.origin.y, subview.frame.size.width, subview.frame.size.height);
                         }completion:^(BOOL finished){
                             [currentSubview removeFromSuperview];
                             self.currentSubview = subview;
                             sender.enabled = YES;
                         }];
    }else if (currentSubview.tag == 102){
        HomeViewController *homeView = [[HomeViewController alloc]init];
        
        [self.navigationController pushViewController:homeView animated:YES];
    }
}

- (void)pressUserPicture:(UIButton*)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [imagePicker setAllowsEditing:NO];
        //imagePicker.allowsImageEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [userPicture setImage:image forState:UIControlStateNormal];
    [userPicture setImage:image forState:UIControlStateHighlighted];
    [userPicture setImage:image forState:UIControlStateSelected];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - view init
- (void)setViewFrame
{
    [self setBackGroundImage:imageNameAndType(@"register_back", @"png")];
    
    _detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, appFrame.size.width, appFrame.size.height)];
    [_detailView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_detailView];
    
    self.currentSubview = [self createRegisterView];
    [_detailView addSubview:self.currentSubview];
    
    userPicture = [UIButton buttonWithType:UIButtonTypeCustom];
    [userPicture setFrame:rect(CGRectMake(self.view.frame.size.width/2 - 50, 40, 100, 100), adaptWidth)];
    [userPicture setBackgroundColor:[UIColor clearColor]];
    [userPicture setImage:imageNameAndType(@"register_selectpicture_normal", @"png") forState:UIControlStateNormal];
    [userPicture setImage:imageNameAndType(@"register_selectpicture_press", @"png") forState:UIControlStateHighlighted];
    [userPicture setImage:imageNameAndType(@"register_selectpicture_press", @"png") forState:UIControlStateSelected];
    [userPicture addTarget:self action:@selector(pressUserPicture:) forControlEvents:UIControlEventTouchUpInside];
    userPicture.layer.masksToBounds = YES;
    userPicture.layer.cornerRadius = userPicture.frame.size.width/2;
    [self.view addSubview:userPicture];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setTag:103];
    [nextButton setBackgroundColor:[UIColor clearColor]];
    [nextButton setFrame:CGRectMake(0, appFrame.size.height - 45, appFrame.size.width, 45)];
    [nextButton setBackgroundImage:imageNameAndType(@"register_bottom_line", @"png") forState:UIControlStateNormal];
    [nextButton setBackgroundImage:imageNameAndType(@"register_bottom_line", @"png") forState:UIControlStateHighlighted];
    [nextButton setBackgroundImage:imageNameAndType(@"register_bottom_line", @"png") forState:UIControlStateDisabled];
    [nextButton setImage:imageNameAndType(@"register_next_normal", @"png") forState:UIControlStateNormal];
    [nextButton setImage:imageNameAndType(@"register_next_press", @"png") forState:UIControlStateHighlighted];
    [nextButton setImage:imageNameAndType(@"register_next_press", @"png") forState:UIControlStateDisabled];
    [nextButton addTarget:self action:@selector(pressNextButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
}

- (UIView*)createRegisterView
{
    UIView *subview = [[UIView alloc]initWithFrame:[self frameWithRect:CGRectMake(0, 165, 320, 45 * 4 + 4) adaptWidthOrHeight:adaptWidth]];
    [subview setBackgroundColor:[UIColor clearColor]];
    subview.tag = 101;
    
    userName = [[UITextField alloc]initWithFrame:rect(CGRectMake(0, 0, 320, 45), adaptWidth)];
    [userName setBackgroundColor:[UIColor clearColor]];
    [userName setTag:200];
    [userName setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [userName setBackground:imageNameAndType(@"register_textback", @"png")];
    UIButton *pictureLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [pictureLeft setBackgroundColor:[UIColor clearColor]];
    [pictureLeft setFrame:CGRectMake(0, 0, userName.frame.size.width/4, userName.frame.size.height)];
    [pictureLeft setTitle:@"姓名" forState:UIControlStateNormal];
    [pictureLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [pictureLeft addTarget:self action:@selector(clearKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [pictureLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [userName setLeftView:pictureLeft];
    [userName setLeftViewMode:UITextFieldViewModeAlways];
    [userName setReturnKeyType:UIReturnKeyDone];
    [userName setDelegate:self];
    [subview addSubview:userName];
    
    phoneNum = [[UITextField alloc]initWithFrame:CGRectMake(userName.frame.origin.x, userName.frame.origin.y + userName.frame.size.height + 1, userName.frame.size.width, userName.frame.size.height)];
    [phoneNum setBackgroundColor:[UIColor clearColor]];
    [phoneNum setTag:201];
    [phoneNum setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [phoneNum setBackground:imageNameAndType(@"register_textback", @"png")];
    UIButton *phoneNumLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneNumLeft setBackgroundColor:[UIColor clearColor]];
    [phoneNumLeft setFrame:CGRectMake(0, 0, phoneNum.frame.size.width/4, phoneNum.frame.size.height)];
    [phoneNumLeft setTitle:@"手机号码" forState:UIControlStateNormal];
    [phoneNumLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [phoneNumLeft addTarget:self action:@selector(clearKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [phoneNumLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [phoneNum setLeftView:phoneNumLeft];
    [phoneNum setLeftViewMode:UITextFieldViewModeAlways];
    [phoneNum setReturnKeyType:UIReturnKeyDone];
    [phoneNum setDelegate:self];
    [subview addSubview:phoneNum];
    
    email = [[UITextField alloc]initWithFrame:CGRectMake(phoneNum.frame.origin.x, phoneNum.frame.origin.y + phoneNum.frame.size.height + 1, phoneNum.frame.size.width, phoneNum.frame.size.height)];
    [email setBackgroundColor:[UIColor clearColor]];
    [email setTag:202];
    [email setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [email setBackground:imageNameAndType(@"register_textback", @"png")];
    UIButton *emailLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [emailLeft setBackgroundColor:[UIColor clearColor]];
    [emailLeft setFrame:CGRectMake(0, 0, email.frame.size.width/4, email.frame.size.height)];
    [emailLeft setTitle:@"注册邮箱" forState:UIControlStateNormal];
    [emailLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [emailLeft addTarget:self action:@selector(clearKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [emailLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [email setLeftView:emailLeft];
    [email setLeftViewMode:UITextFieldViewModeAlways];
    [email setReturnKeyType:UIReturnKeyDone];
    [email setDelegate:self];
    [subview addSubview:email];
    
    password = [[UITextField alloc]initWithFrame:CGRectMake(email.frame.origin.x, email.frame.origin.y + email.frame.size.height + 1, email.frame.size.width, email.frame.size.height)];
    [password setBackgroundColor:[UIColor clearColor]];
    [password setTag:203];
    [password setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [password setBackground:imageNameAndType(@"register_textback", @"png")];
    UIButton *passwordLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [passwordLeft setBackgroundColor:[UIColor clearColor]];
    [passwordLeft setFrame:CGRectMake(0, 0, password.frame.size.width/4, password.frame.size.height)];
    [passwordLeft setTitle:@"密码" forState:UIControlStateNormal];
    [passwordLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [passwordLeft addTarget:self action:@selector(clearKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [passwordLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [password setLeftView:passwordLeft];
    [password setLeftViewMode:UITextFieldViewModeAlways];
    [password setReturnKeyType:UIReturnKeyDone];
    [password setDelegate:self];
    [subview addSubview:password];
    
    return subview;
}

- (UIView*)createRegisterDetailView
{
    UIView *subview = [[UIView alloc]initWithFrame:[self frameWithRect:CGRectMake(0, 165, 320, 45 * 4 + 4) adaptWidthOrHeight:adaptWidth]];
    [subview setBackgroundColor:[UIColor clearColor]];
    subview.tag = 102;
    
    currentPosition = [[UITextField alloc]initWithFrame:rect(CGRectMake(0, 0, 320, 45), adaptWidth)];
    [currentPosition setBackgroundColor:[UIColor clearColor]];
    [currentPosition setTag:204];
    [currentPosition setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [currentPosition setBackground:imageNameAndType(@"register_textback", @"png")];
    UIButton *currentPositionLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [currentPositionLeft setBackgroundColor:[UIColor clearColor]];
    [currentPositionLeft setFrame:CGRectMake(0, 0, currentPosition.frame.size.width/4, currentPosition.frame.size.height)];
    [currentPositionLeft setTitle:@"当前职位" forState:UIControlStateNormal];
    [currentPositionLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [currentPositionLeft addTarget:self action:@selector(clearKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [currentPositionLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [currentPosition setLeftView:currentPositionLeft];
    [currentPosition setLeftViewMode:UITextFieldViewModeAlways];
    [currentPosition setReturnKeyType:UIReturnKeyDone];
    [currentPosition setDelegate:self];
    [subview addSubview:currentPosition];
    
    currentCompany = [[UITextField alloc]initWithFrame:CGRectMake(currentPosition.frame.origin.x, currentPosition.frame.origin.y + currentPosition.frame.size.height + 1, currentPosition.frame.size.width, currentPosition.frame.size.height)];
    [currentCompany setBackgroundColor:[UIColor clearColor]];
    [currentCompany setTag:205];
    [currentCompany setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [currentCompany setBackground:imageNameAndType(@"register_textback", @"png")];
    UIButton *currentCompanyLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [currentCompanyLeft setBackgroundColor:[UIColor clearColor]];
    [currentCompanyLeft setFrame:CGRectMake(0, 0, currentCompany.frame.size.width/4, currentCompany.frame.size.height)];
    [currentCompanyLeft setTitle:@"当前公司" forState:UIControlStateNormal];
    [currentCompanyLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [currentCompanyLeft addTarget:self action:@selector(clearKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [currentCompanyLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [currentCompany setLeftView:currentCompanyLeft];
    [currentCompany setLeftViewMode:UITextFieldViewModeAlways];
    [currentCompany setReturnKeyType:UIReturnKeyDone];
    [currentCompany setDelegate:self];
    [subview addSubview:currentCompany];
    
    goalCompany = [[UITextField alloc]initWithFrame:CGRectMake(currentCompany.frame.origin.x, currentCompany.frame.origin.y + currentCompany.frame.size.height + 1, currentCompany.frame.size.width, currentCompany.frame.size.height)];
    [goalCompany setBackgroundColor:[UIColor clearColor]];
    [goalCompany setTag:206];
    [goalCompany setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [goalCompany setBackground:imageNameAndType(@"register_textback", @"png")];
    UIButton *goalCompanyLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [goalCompanyLeft setBackgroundColor:[UIColor clearColor]];
    [goalCompanyLeft setFrame:CGRectMake(0, 0, goalCompany.frame.size.width/4, goalCompany.frame.size.height)];
    [goalCompanyLeft setTitle:@"我的职位期望" forState:UIControlStateNormal];
    [goalCompanyLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [goalCompanyLeft addTarget:self action:@selector(clearKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    goalCompanyLeft.titleLabel.adjustsFontSizeToFitWidth = YES;
    goalCompanyLeft.titleLabel.adjustsLetterSpacingToFitWidth = YES;
    goalCompanyLeft.titleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    goalCompanyLeft.titleLabel.minimumScaleFactor = 0.5;
    [goalCompanyLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [goalCompany setLeftView:goalCompanyLeft];
    [goalCompany setLeftViewMode:UITextFieldViewModeAlways];
    [goalCompany setReturnKeyType:UIReturnKeyDone];
    [goalCompany setDelegate:self];
    [subview addSubview:goalCompany];
    
    return subview;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIView *keyBoard = [self findKeyboard];
    
    if (keyBoard) {
        CGRect frame = keyBoard.frame;
        CGFloat changeY = controlYLength(textField) + currentSubview.frame.origin.y + 1 - (self.view.frame.size.height - frame.size.height);
        changeY = changeY >= 0?changeY:0;
        [UIView animateWithDuration:0.35f
                         animations:^{
                             self.view.frame = CGRectMake(self.view.frame.origin.x, 0 - changeY, self.view.frame.size.width, self.view.frame.size.height);
                         }
                         completion:^(BOOL finished){
                             
                         }];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag >= 200 && textField.tag <203) {
        UIControl *control = (UIControl*)[_detailView viewWithTag:textField.tag + 1];
        if ([control canBecomeFirstResponder]) {
            [control becomeFirstResponder];
        }
    }else if (textField.tag >= 204 && textField.tag < 206){
        UIControl *control = (UIControl*)[_detailView viewWithTag:textField.tag + 1];
        if ([control canBecomeFirstResponder]) {
            [control becomeFirstResponder];
        }
    }else{
        [self clearKeyBoard];
    }
    return YES;
}

- (BOOL)clearKeyBoard
{
    BOOL canResignFirstResponder = NO;
    if ([userName isFirstResponder]) {
        [userName resignFirstResponder];
        canResignFirstResponder = YES;
    }else if ([phoneNum isFirstResponder]) {
        [phoneNum resignFirstResponder];
        canResignFirstResponder = YES;
    }else if ([email isFirstResponder]) {
        [email resignFirstResponder];
        canResignFirstResponder = YES;
    }else if ([password isFirstResponder]) {
        [password resignFirstResponder];
        canResignFirstResponder = YES;
    }else if ([currentPosition isFirstResponder]) {
        [currentPosition resignFirstResponder];
        canResignFirstResponder = YES;
    }else if ([currentCompany isFirstResponder]) {
        [currentCompany resignFirstResponder];
        canResignFirstResponder = YES;
    }else if ([goalCompany isFirstResponder]) {
        [goalCompany resignFirstResponder];
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
    UITextField *responder = nil;
    if ([userName isFirstResponder]) {
        responder = userName;
    }if ([phoneNum isFirstResponder]) {
        responder = phoneNum;
    }if ([email isFirstResponder]) {
        responder = email;
    }if ([password isFirstResponder]) {
        responder = password;
    }if ([currentPosition isFirstResponder]) {
        responder = currentPosition;
    }if ([currentCompany isFirstResponder]) {
        responder = currentCompany;
    }if ([goalCompany isFirstResponder]) {
        responder = goalCompany;
    }
    if (responder) {
        if (controlYLength(responder) + currentSubview.frame.origin.y + 1.0f> self.view.frame.size.height - frame.size.height) {
            CGFloat changeY = controlYLength(responder) + currentSubview.frame.origin.y + 1 - (self.view.frame.size.height - frame.size.height);
            changeY = changeY >= 0?changeY:0;
            [UIView animateWithDuration:duration
                             animations:^{
                                 self.view.frame = CGRectMake(self.view.frame.origin.x, 0 - changeY, self.view.frame.size.width, self.view.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 
                             }];
        }
    }
}

- (void)keyBoardHide:(CGRect)frame animationDuration:(NSTimeInterval)duration
{
    UITextField *responder = nil;
    if ([userName isFirstResponder]) {
        responder = userName;
    }if ([phoneNum isFirstResponder]) {
        responder = phoneNum;
    }if ([email isFirstResponder]) {
        responder = email;
    }if ([password isFirstResponder]) {
        responder = password;
    }if ([currentPosition isFirstResponder]) {
        responder = currentPosition;
    }if ([currentCompany isFirstResponder]) {
        responder = currentCompany;
    }if ([goalCompany isFirstResponder]) {
        responder = goalCompany;
    }
    if (responder) {
        if (responder.frame.origin.y + responder.frame.size.height < frame.origin.y) {
            [UIView animateWithDuration:duration
                             animations:^{
                                 self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 
                             }];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
