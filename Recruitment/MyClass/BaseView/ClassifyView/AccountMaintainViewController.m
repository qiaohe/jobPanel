//
//  AccountMaintainViewController.m
//  Recruitment
//
//  Created by M J on 13-10-31.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "AccountMaintainViewController.h"

@interface AccountMaintainViewController ()

@end

@implementation AccountMaintainViewController

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

- (void)pressDoneButton:(UIButton*)sender
{
    [[Model shareModel] showPromptText:@"保存成功" model:YES];
}

- (void)setSubviewFrame
{
    [self setBackGroundImage:imageNameAndType(@"subview_backimage", @"png")];
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setTitle:@"账号维护"];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    UIButton *nameLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [nameLeft setFrame:CGRectMake(0, 0, (self.contentView.frame.size.width - 20)/4 + 15, 50)];
    [nameLeft setTitle:@"姓名" forState:UIControlStateNormal];
    [nameLeft.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [nameLeft setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [nameLeft setBackgroundColor:color(clearColor)];
    [nameLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [nameLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    _name = [[UITextField alloc]initWithFrame:CGRectMake(10, controlYLength(self.topBar) + 10, self.view.frame.size.width - 20, nameLeft.frame.size.height)];
    [_name setBackgroundColor:color(clearColor)];
    [_name setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_name setLeftView:nameLeft];
    [_name setBackground:stretchImage(@"settingitem", @"png")];
    [_name setLeftViewMode:UITextFieldViewModeAlways];
    [_name setFont:nameLeft.titleLabel.font];
    [self.contentView addSubview:_name];
    
    UIButton *mobileLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [mobileLeft setFrame:CGRectMake(0, 0, nameLeft.frame.size.width, nameLeft.frame.size.height)];
    [mobileLeft setTitle:@"手机号码" forState:UIControlStateNormal];
    [mobileLeft.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [mobileLeft setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [mobileLeft setBackgroundColor:color(clearColor)];
    [mobileLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [mobileLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, nameLeft.titleEdgeInsets.left, 0, 0)];
    _mobile = [[UITextField alloc]initWithFrame:CGRectMake(_name.frame.origin.x, controlYLength(_name) + 5, _name.frame.size.width, _name.frame.size.height)];
    [_mobile setBackgroundColor:color(clearColor)];
    [_mobile setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_mobile setLeftView:mobileLeft];
    [_mobile setBackground:stretchImage(@"settingitem", @"png")];
    [_mobile setLeftViewMode:UITextFieldViewModeAlways];
    [_mobile setFont:nameLeft.titleLabel.font];
    [self.contentView addSubview:_mobile];
    
    UIButton *emailLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [emailLeft setFrame:CGRectMake(0, 0, nameLeft.frame.size.width, nameLeft.frame.size.height)];
    [emailLeft setTitle:@"注册邮箱" forState:UIControlStateNormal];
    [emailLeft.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [emailLeft setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [emailLeft setBackgroundColor:color(clearColor)];
    [emailLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [emailLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, nameLeft.titleEdgeInsets.left, 0, 0)];
    _email = [[UITextField alloc]initWithFrame:CGRectMake(_name.frame.origin.x, controlYLength(_mobile) + 5, _name.frame.size.width, _name.frame.size.height)];
    [_email setBackgroundColor:color(clearColor)];
    [_email setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_email setLeftView:emailLeft];
    [_email setBackground:stretchImage(@"settingitem", @"png")];
    [_email setLeftViewMode:UITextFieldViewModeAlways];
    [_email setFont:nameLeft.titleLabel.font];
    [self.contentView addSubview:_email];
    
    UIButton *passwordLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [passwordLeft setFrame:CGRectMake(0, 0, nameLeft.frame.size.width, nameLeft.frame.size.height)];
    [passwordLeft setTitle:@"密码" forState:UIControlStateNormal];
    [passwordLeft.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [passwordLeft setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [passwordLeft setBackgroundColor:color(clearColor)];
    [passwordLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [passwordLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, nameLeft.titleEdgeInsets.left, 0, 0)];
    _passWord = [[UITextField alloc]initWithFrame:CGRectMake(_name.frame.origin.x, controlYLength(_email) + 5, _name.frame.size.width, _name.frame.size.height)];
    [_passWord setBackgroundColor:color(clearColor)];
    [_passWord setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_passWord setLeftView:passwordLeft];
    [_passWord setBackground:stretchImage(@"settingitem", @"png")];
    [_passWord setLeftViewMode:UITextFieldViewModeAlways];
    [_passWord setFont:nameLeft.titleLabel.font];
    [self.contentView addSubview:_passWord];
    
    UIButton *IdCardNumLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [IdCardNumLeft setFrame:CGRectMake(0, 0, nameLeft.frame.size.width, nameLeft.frame.size.height)];
    [IdCardNumLeft setTitle:@"证件号码" forState:UIControlStateNormal];
    [IdCardNumLeft.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [IdCardNumLeft setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [IdCardNumLeft setBackgroundColor:color(clearColor)];
    [IdCardNumLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [IdCardNumLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, nameLeft.titleEdgeInsets.left, 0, 0)];
    _IdCardNum = [[UITextField alloc]initWithFrame:CGRectMake(_name.frame.origin.x, controlYLength(_passWord) + 5, _name.frame.size.width, _name.frame.size.height)];
    [_IdCardNum setBackgroundColor:color(clearColor)];
    [_IdCardNum setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_IdCardNum setLeftView:IdCardNumLeft];
    [_IdCardNum setBackground:stretchImage(@"settingitem", @"png")];
    [_IdCardNum setLeftViewMode:UITextFieldViewModeAlways];
    [_IdCardNum setFont:nameLeft.titleLabel.font];
    [self.contentView addSubview:_IdCardNum];
    
    [nameLeft           addTarget:self action:@selector(clearKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [mobileLeft         addTarget:self action:@selector(clearKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [emailLeft          addTarget:self action:@selector(clearKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [passwordLeft       addTarget:self action:@selector(clearKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [IdCardNumLeft      addTarget:self action:@selector(clearKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    
    [_name              setDelegate:self];
    [_mobile            setDelegate:self];
    [_email             setDelegate:self];
    [_passWord          setDelegate:self];
    [_IdCardNum         setDelegate:self];
    
    [_name              setTag:100];
    [_mobile            setTag:101];
    [_email             setTag:102];
    [_passWord          setTag:103];
    [_IdCardNum         setTag:104];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setBackgroundImage:imageNameAndType(@"resume_done_normal", @"png") forState:UIControlStateNormal];
    [doneButton setBackgroundImage:imageNameAndType(@"resume_done_press", @"png") forState:UIControlStateHighlighted];
    [doneButton setBackgroundColor:color(clearColor)];
    [doneButton setFrame:CGRectMake(self.contentView.frame.size.width/6, controlYLength(_IdCardNum) + 15, self.contentView.frame.size.width*2/3, 50)];
    [doneButton addTarget:self action:@selector(pressDoneButton:) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.contentView addSubview:doneButton];
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeButton setBackgroundColor:color(clearColor)];
    [homeButton setTag:102];
    [homeButton setImage:imageNameAndType(@"returnhome_normal", @"png")
                forState:UIControlStateNormal];
    [homeButton setImage:imageNameAndType(@"returnhome_press", @"png")
                forState:UIControlStateHighlighted];
    [self setPopToMainViewButton:homeButton];
    [self setBottomBarItems:@[homeButton]];
    [self setBottomBarBackGroundImage:imageNameAndType(@"bottombar", @"png")];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIView *keyBoard = [self findKeyboard];
    
    if (keyBoard) {
        CGRect frame = keyBoard.frame;
        CGFloat changeY = controlYLength(textField) - self.contentView.contentOffset.y - (self.view.frame.size.height - frame.size.height);
        changeY = changeY >= 0?changeY:0;
        [UIView animateWithDuration:0.35f
                         animations:^{
                             self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, 0 - changeY, self.contentView.frame.size.width, self.contentView.frame.size.height);
                         }
                         completion:^(BOOL finished){
                             
                         }];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self clearKeyBoard];
    
    return YES;
}


#pragma mark - keyboard show
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
    if ([_name isFirstResponder]) {
        responder = _name;
    }else if ([_mobile isFirstResponder]) {
        responder = _mobile;
    }else if ([_email isFirstResponder]) {
        responder = _email;
    }else if ([_passWord isFirstResponder]) {
        responder = _passWord;
    }else if ([_currentJob isFirstResponder]) {
        responder = _currentJob;
    }else if ([_currentCompany isFirstResponder]) {
        responder = _currentCompany;
    }else if ([_goalCompany isFirstResponder]) {
        responder = _goalCompany;
    }else if ([_IdCardNum isFirstResponder]) {
        responder = _IdCardNum;
    }
    if (responder) {
        if (controlYLength(responder) - self.contentView.contentOffset.y > self.view.frame.size.height - frame.size.height) {
            CGFloat changeY = controlYLength(responder) - self.contentView.contentOffset.y - (self.view.frame.size.height - frame.size.height);
            changeY = changeY >= 0?changeY:0;
            [UIView animateWithDuration:duration
                             animations:^{
                                 self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, 0 - changeY, self.contentView.frame.size.width, self.contentView.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 
                             }];
        }
    }
}

- (void)keyBoardHide:(CGRect)frame animationDuration:(NSTimeInterval)duration
{
    UITextField *responder = nil;
    if ([_name isFirstResponder]) {
        responder = _name;
    }else if ([_mobile isFirstResponder]) {
        responder = _mobile;
    }else if ([_email isFirstResponder]) {
        responder = _email;
    }else if ([_passWord isFirstResponder]) {
        responder = _passWord;
    }else if ([_currentJob isFirstResponder]) {
        responder = _currentJob;
    }else if ([_currentCompany isFirstResponder]) {
        responder = _currentCompany;
    }else if ([_goalCompany isFirstResponder]) {
        responder = _goalCompany;
    }else if ([_IdCardNum isFirstResponder]) {
        responder = _IdCardNum;
    }
    if (responder) {
        if (self.contentView.frame.origin.y < 0) {
            [UIView animateWithDuration:duration
                             animations:^{
                                 self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 
                             }];
        }
    }
}

- (BOOL)clearKeyBoard
{
    BOOL canResignFirstResponder = NO;
    if ([_name isFirstResponder]) {
        [_name resignFirstResponder];
        canResignFirstResponder = YES;
    }else if ([_mobile isFirstResponder]) {
        [_mobile resignFirstResponder];
        canResignFirstResponder = YES;
    }else if ([_email isFirstResponder]) {
        [_email resignFirstResponder];
        canResignFirstResponder = YES;
    }else if ([_passWord isFirstResponder]) {
        [_passWord resignFirstResponder];
        canResignFirstResponder = YES;
    }else if ([_currentJob isFirstResponder]) {
        [_currentJob resignFirstResponder];
        canResignFirstResponder = YES;
    }else if ([_currentCompany isFirstResponder]) {
        [_currentCompany resignFirstResponder];
        canResignFirstResponder = YES;
    }else if ([_goalCompany isFirstResponder]) {
        [_goalCompany resignFirstResponder];
        canResignFirstResponder = YES;
    }else if ([_IdCardNum isFirstResponder]) {
        [_IdCardNum resignFirstResponder];
        canResignFirstResponder = YES;
    }
    return canResignFirstResponder;
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
