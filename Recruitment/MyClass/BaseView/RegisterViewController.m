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
@property (assign, nonatomic) BOOL              isScroll;

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
    self = [super init];
    if (self) {
        _isScroll = NO;
        _dataSource = [NSMutableArray arrayWithArray:@[@"欧美公司",@"国有企业",@"管理职位",@"技术职位",@"要创业",@"有激情",@"工资高",@"环境好",@"高评价"]];
        _selectDataSource = [NSMutableArray array];
        [self setSubviewFrame];
    }
    return self;
}

- (void)pressNextButton:(UIButton*)sender
{
    [self.view setUserInteractionEnabled:NO];
    if (currentSubview.tag != 302) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + _scrollView.frame.size.width, _scrollView.contentOffset.y) animated:YES];
    }else {
        HomeViewController *homeView = [[HomeViewController alloc]init];
        [self pushViewController:homeView transitionType:TransitionMoveIn completionHandler:nil];
    }
}

- (void)pressUserPicture:(UIButton*)sender
{
    if(!imagePicker){
        imagePicker = [[ImagePickerViewController alloc]init];
        imagePicker.delegate = self;
        imagePicker.view.frame = CGRectMake(imagePicker.view.frame.origin.x, 0, appFrame.size.width, appFrame.size.height);
    }
    
    [self.view addSubview:imagePicker.view];
    imagePicker.view.alpha = 0;
    
    [UIView transitionWithView:imagePicker.view
                      duration:0.35f
                       options:UIViewAnimationOptionCurveEaseIn
                    animations:^{
                        imagePicker.view.alpha = 1;
                    }
                    completion:^(BOOL finished){
                        
                    }];
    
    //[self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)didFinishPickImage:(UIImage *)image
{
    [userPicture setImage:image forState:UIControlStateNormal];
    [userPicture setImage:image forState:UIControlStateHighlighted];
    [userPicture setImage:image forState:UIControlStateSelected];
    [imagePicker.view removeFromSuperview];
}

- (void)didCancel
{
    [imagePicker.view removeFromSuperview];
}

#pragma mark - view init
- (void)setSubviewFrame
{
    [self setBackGroundImage:imageNameAndType(@"register_back", @"png")];
    
    UIImageView *userPictureBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, 40, 100, 100)];
    [userPictureBackImage setBackgroundColor:color(clearColor)];
    [userPictureBackImage setTag:400];
    [userPictureBackImage setImage:imageNameAndType(@"selectimage_background", nil)];
    [self.contentView addSubview:userPictureBackImage];
    
    userPicture = [UIButton buttonWithType:UIButtonTypeCustom];
    [userPicture setFrame:userPictureBackImage.frame];
    [userPicture setBackgroundColor:[UIColor clearColor]];
    [userPicture setImage:imageNameAndType(@"register_selectpicture_normal", nil) forState:UIControlStateNormal];
    [userPicture setBounds:CGRectMake(0, 0, userPicture.frame.size.width - 11, userPicture.frame.size.height - 11)];
    [userPicture addTarget:self action:@selector(pressUserPicture:) forControlEvents:UIControlEventTouchUpInside];
    userPicture.layer.masksToBounds = YES;
    userPicture.layer.cornerRadius = userPicture.frame.size.width/2;
    [userPicture.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.contentView addSubview:userPicture];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, controlYLength(userPicture) + 35, self.view.frame.size.width, self.view.frame.size.height - 45 - controlYLength(userPicture))];
    [_scrollView setBackgroundColor:color(clearColor)];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setDelegate:self];
    [_scrollView setBounces:NO];
    [self.contentView addSubview:_scrollView];
    
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width * 3, _scrollView.frame.size.height)];
    for (int i = 0; i<3; i++) {
        switch (i) {
            case 0:{
                UIView *subView = [self createRegisterView1];
                subView.tag = 300 + i;
                subView.frame = CGRectMake(_scrollView.frame.size.width * i, 0, subView.frame.size.width, subView.frame.size.height);
                [_scrollView addSubview:subView];
                break;
            }case 1:{
                UIView *subView = [self createRegisterView2];
                subView.tag = 300 + i;
                subView.frame = CGRectMake(_scrollView.frame.size.width * i, 0, subView.frame.size.width, subView.frame.size.height);
                [_scrollView addSubview:subView];
                break;
            }case 2:{
                UIView *subView = [self createRegisterView3];
                subView.tag = 300 + i;
                subView.frame = CGRectMake(_scrollView.frame.size.width * i, 0, subView.frame.size.width, subView.frame.size.height);
                [_scrollView addSubview:subView];
                break;
            }
            default:
                break;
        }
    }
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setTag:103];
    [nextButton setBackgroundColor:[UIColor clearColor]];
    [nextButton setFrame:CGRectMake(0, self.view.frame.size.height - 45, appFrame.size.width, 45)];
    [nextButton setBackgroundImage:imageNameAndType(@"register_bottom_line", @"png") forState:UIControlStateNormal];
    [nextButton setBackgroundImage:imageNameAndType(@"register_bottom_line", @"png") forState:UIControlStateHighlighted];
    [nextButton setBackgroundImage:imageNameAndType(@"register_bottom_line", @"png") forState:UIControlStateDisabled];
    [nextButton setImage:imageNameAndType(@"register_next_normal", @"png") forState:UIControlStateNormal];
    [nextButton setImage:imageNameAndType(@"register_next_press", @"png") forState:UIControlStateHighlighted];
    [nextButton setImage:imageNameAndType(@"register_next_press", @"png") forState:UIControlStateDisabled];
    [nextButton addTarget:self action:@selector(pressNextButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.view setUserInteractionEnabled:NO];
    [self scrollViewDidEndScroll:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScroll:scrollView];
}

- (void)scrollViewDidEndScroll:(UIScrollView*)scrollView
{
    UIButton *button = (UIButton*)[self.view viewWithTag:103];
    
    NSInteger currentViewTag = scrollView.contentOffset.x / scrollView.frame.size.width + 300;
    currentSubview = [_scrollView viewWithTag:currentViewTag];
    
    if (scrollView.contentOffset.x >= scrollView.contentSize.width - scrollView.frame.size.width) {
        if (button) {
            [button setTitle:@"进入应用" forState:UIControlStateNormal];
            [button setImage:nil forState:UIControlStateNormal];
            [button setImage:nil forState:UIControlStateHighlighted];
            [button setImage:nil forState:UIControlStateDisabled];
        }
    }else {
        [button setTitle:nil forState:UIControlStateNormal];
        [button setImage:imageNameAndType(@"register_next_normal", @"png") forState:UIControlStateNormal];
        [button setImage:imageNameAndType(@"register_next_press", @"png") forState:UIControlStateHighlighted];
        [button setImage:imageNameAndType(@"register_next_press", @"png") forState:UIControlStateDisabled];
    }
    NSLog(@"end");
    [self.view setUserInteractionEnabled:YES];
}

- (UIView*)createRegisterView1
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
    [userName setReturnKeyType:UIReturnKeyNext];
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
    [phoneNum setReturnKeyType:UIReturnKeyNext];
    [phoneNum setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
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
    [email setReturnKeyType:UIReturnKeyNext];
    [email setKeyboardType:UIKeyboardTypeDefault];
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
    [password setKeyboardType:UIKeyboardTypeDefault];
    [password setReturnKeyType:UIReturnKeyDone];
    [password setSecureTextEntry:YES];
    [password setDelegate:self];
    [subview addSubview:password];
    
    return subview;
}

- (UIView*)createRegisterView2
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
    [currentPosition setReturnKeyType:UIReturnKeyNext];
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
    
    
    
    return subview;
}

- (UIView*)createRegisterView3
{
    NSInteger lineNum = [_dataSource count]/3 + ([_dataSource count]%3 > 0?1:0);

    UIView *subview = [[UIView alloc]initWithFrame:[self frameWithRect:CGRectMake(0, 165, 320, 45 * lineNum + 4 + 20 + 45) adaptWidthOrHeight:adaptWidth]];
    [subview setBackgroundColor:[UIColor clearColor]];
    for (int i = 0; i<[_dataSource count]; i++) {
        NSInteger x = i%3;
        NSInteger y = i/3;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (subview.frame.size.width  - 20)/3, 45)];
        [imageView setCenter:CGPointMake(subview.frame.size.width/6 + (subview.frame.size.width/3) * x, (subview.frame.size.height - 20 - 45)/(lineNum * 2) + ((subview.frame.size.height - 20 - 45)/lineNum) * y)];
        [imageView setImage:imageNameAndType(@"register_item_select", nil)];
        [imageView setHighlightedImage:imageNameAndType(@"register_item_normal", nil)];
        [imageView setTag:400 + i];
        [subview addSubview:imageView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:imageView.frame];
        button.tag = 300 + i;
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button setBackgroundColor:color(clearColor)];
        [button setTitleColor:color(blackColor) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectGoalJob:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[_dataSource objectAtIndex:i] forState:UIControlStateNormal];
        [subview addSubview:button];
    }
    
    goalCompany = [[UITextField alloc]initWithFrame:CGRectMake(0, subview.frame.size.height - 45, self.view.frame.size.width, 45)];
    [goalCompany setBackgroundColor:[UIColor clearColor]];
    [goalCompany setTag:206];
    [goalCompany setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [goalCompany setBackground:imageNameAndType(@"register_textback", @"png")];
    UIButton *goalCompanyLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [goalCompanyLeft setBackgroundColor:[UIColor clearColor]];
    [goalCompanyLeft setFrame:CGRectMake(0, 0, goalCompany.frame.size.width/3, goalCompany.frame.size.height)];
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

- (void)selectGoalJob:(UIButton*)sender
{
    if (![self clearKeyBoard]) {
        NSInteger index = sender.tag - 300;
        UIImageView *imageView = (UIImageView*)[currentSubview viewWithTag:sender.tag + 100];
        imageView.highlighted = imageView.highlighted?NO:YES;
        NSObject *object = [_dataSource objectAtIndex:index];
        
        if (imageView.highlighted) {
            if (![_selectDataSource containsObject:object]) {
                [sender setTitleColor:color(whiteColor) forState:UIControlStateNormal];
                [_selectDataSource addObject:[_dataSource objectAtIndex:index]];
            } 
        }else{
            if ([_selectDataSource containsObject:object]){
                [sender setTitleColor:color(blackColor) forState:UIControlStateNormal];
                [_selectDataSource removeObject:object];
            }
        }
    }
    //NSString *goalText = [_selectDataSource componentsJoinedByString:@","];
    //[goalCompany setText:goalText];
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
        //CGFloat baseHeight = (deviceVersion >= 7.0)?23:0;
        CGFloat changeY = _scrollView.frame.origin.y + controlYLength(textField) + 1 - (self.view.frame.size.height - frame.size.height);
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
        UIControl *control = (UIControl*)[_scrollView viewWithTag:textField.tag + 1];
        if ([control canBecomeFirstResponder]) {
            [control becomeFirstResponder];
        }
    }else if (textField.tag >= 204 && textField.tag < 205){
        UIControl *control = (UIControl*)[_scrollView viewWithTag:textField.tag + 1];
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
    }else if ([phoneNum isFirstResponder]) {
        responder = phoneNum;
    }else if ([email isFirstResponder]) {
        responder = email;
    }else if ([password isFirstResponder]) {
        responder = password;
    }else if ([currentPosition isFirstResponder]) {
        responder = currentPosition;
    }else if ([currentCompany isFirstResponder]) {
        responder = currentCompany;
    }else if ([goalCompany isFirstResponder]) {
        responder = goalCompany;
    }
    if (responder) {
        //CGFloat baseHeight = (deviceVersion >= 7.0)?23:0;
        if (_scrollView.frame.origin.y + controlYLength(responder) + 1.0f > self.view.frame.size.height - frame.size.height) {
            CGFloat changeY = _scrollView.frame.origin.y + controlYLength(responder) + 1 - (self.view.frame.size.height - frame.size.height);
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
    }else if ([phoneNum isFirstResponder]) {
        responder = phoneNum;
    }else if ([email isFirstResponder]) {
        responder = email;
    }else if ([password isFirstResponder]) {
        responder = password;
    }else if ([currentPosition isFirstResponder]) {
        responder = currentPosition;
    }else if ([currentCompany isFirstResponder]) {
        responder = currentCompany;
    }else if ([goalCompany isFirstResponder]) {
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
