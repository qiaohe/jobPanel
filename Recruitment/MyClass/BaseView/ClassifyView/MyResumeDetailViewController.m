//
//  MyResumeDetailViewController.m
//  Recruitment
//
//  Created by M J on 13-10-18.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "MyResumeDetailViewController.h"
#import "ResumeSubitemViewController.h"
#import "AchievementViewController.h"
#import "MyResumeDetail.h"

@interface MyResumeDetailViewController ()

@end

@implementation MyResumeDetailViewController

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

- (id)initWithResumeDetail:(MyResumeDetail*)resumeDetail
{
    self = [super init];
    if (self) {
        _myResume = resumeDetail;
        [self setSubviewFrame];
    }
    return self;
}

- (void)editDone:(NSString *)string
{
    [[Model shareModel] showPromptText:@"操作成功" model:YES];
}

- (void)pressButton:(UIButton*)sender
{
    switch (sender.tag) {
        case 100:{
            ResumeSubitemViewController *subitemView = [[ResumeSubitemViewController alloc]initWithType:ResumeSubitemWorkExperience];
            [self pushViewController:subitemView transitionType:TransitionPush completionHandler:nil];
            break;
        }case 101:{
            ResumeSubitemViewController *subitemView = [[ResumeSubitemViewController alloc]initWithType:ResumeSubitemEduExperience];
            [self pushViewController:subitemView transitionType:TransitionPush completionHandler:nil];
            break;
        }case 102:{
            AchievementViewController *achievementView = [[AchievementViewController alloc]init];
            [self pushViewController:achievementView transitionType:TransitionPush completionHandler:nil];
            break;
        }case 103:{
            TextEditViewController *textEditView = [[TextEditViewController alloc]initWithType:TextEditPersonalLight];
            [textEditView setDelegate:self];
            [self pushViewController:textEditView transitionType:TransitionPush completionHandler:nil];
            break;
        }case 104:{
            TextEditViewController *textEditView = [[TextEditViewController alloc]initWithType:TextEditReferralCommend];
            [textEditView setDelegate:self];
            [self pushViewController:textEditView transitionType:TransitionPush completionHandler:nil];
            break;
        }
        default:
            break;
    }
}

- (void)selectMyPicture:(UIButton*)sender
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
}


- (void)didFinishPickImage:(UIImage *)image
{
    UIButton *userPicture = (UIButton*)[self.contentView viewWithTag:200];
    
    [userPicture setImage:image forState:UIControlStateNormal];
    [userPicture setImage:image forState:UIControlStateHighlighted];
    [userPicture setImage:image forState:UIControlStateSelected];
    
    _myResume.userPicture = image;
    
    [imagePicker.view removeFromSuperview];
}

- (void)didCancel
{
    [imagePicker.view removeFromSuperview];
}

- (void)pressDoneButton:(UIButton*)sender
{
    [[Model shareModel] showPromptText:@"操作完成" model:YES];
}

#pragma mark - view init
- (void)setSubviewFrame
{
    //[self setBackGroundImage:imageNameAndType(@"resume_detail_backimage", @"png")];
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setTitle:_myResume?_myResume.resumeName:@"未命名简历"];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    UILabel *nameLeft = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 25)];
    [nameLeft setBackgroundColor:color(clearColor)];
    [nameLeft setText:@"姓名:"];
    [nameLeft setFont:[UIFont systemFontOfSize:11]];
    [nameLeft setTextColor:color(darkGrayColor)];
    _name = [[UITextField alloc]initWithFrame:CGRectMake(10, controlYLength(self.topBar) + 10, self.contentView.frame.size.width - 20, nameLeft.frame.size.height)];
    [_name setBackgroundColor:color(clearColor)];
    [_name setEnabled:NO];
    [_name setTextColor:nameLeft.textColor];
    [_name setFont:nameLeft.font];
    [_name setText:_myResume.name];
    [_name setLeftView:nameLeft];
    [_name setLeftViewMode:UITextFieldViewModeAlways];
    [_name setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.contentView addSubview:_name];
    
    UILabel *birthDateLeft = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, nameLeft.frame.size.width, nameLeft.frame.size.height)];
    [birthDateLeft setBackgroundColor:color(clearColor)];
    [birthDateLeft setText:@"出生日期:"];
    [birthDateLeft setFont:[UIFont systemFontOfSize:11]];
    [birthDateLeft setTextColor:color(darkGrayColor)];
    _birthDate = [[UITextField alloc]initWithFrame:CGRectMake(10, controlYLength(_name), self.contentView.frame.size.width - 20, nameLeft.frame.size.height)];
    [_birthDate setBackgroundColor:color(clearColor)];
    [_birthDate setEnabled:NO];
    [_birthDate setTextColor:nameLeft.textColor];
    [_birthDate setFont:nameLeft.font];
    [_birthDate setText:_myResume.birthDate];
    [_birthDate setLeftView:birthDateLeft];
    [_birthDate setLeftViewMode:UITextFieldViewModeAlways];
    [_birthDate setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.contentView addSubview:_birthDate];
    
    UILabel *currentJobLeft = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, nameLeft.frame.size.width, nameLeft.frame.size.height)];
    [currentJobLeft setBackgroundColor:color(clearColor)];
    [currentJobLeft setText:@"目前职位:"];
    [currentJobLeft setFont:[UIFont systemFontOfSize:11]];
    [currentJobLeft setTextColor:color(darkGrayColor)];
    _currentJob = [[UITextField alloc]initWithFrame:CGRectMake(10, controlYLength(_birthDate), self.contentView.frame.size.width - 20, nameLeft.frame.size.height)];
    [_currentJob setBackgroundColor:color(clearColor)];
    [_currentJob setEnabled:NO];
    [_currentJob setTextColor:nameLeft.textColor];
    [_currentJob setFont:nameLeft.font];
    [_currentJob setText:_myResume.currentJob];
    [_currentJob setLeftView:currentJobLeft];
    [_currentJob setLeftViewMode:UITextFieldViewModeAlways];
    [_currentJob setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.contentView addSubview:_currentJob];
    
    UILabel *currentCompanyLeft = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, nameLeft.frame.size.width, nameLeft.frame.size.height)];
    [currentCompanyLeft setBackgroundColor:color(clearColor)];
    [currentCompanyLeft setText:@"目前公司:"];
    [currentCompanyLeft setFont:[UIFont systemFontOfSize:11]];
    [currentCompanyLeft setTextColor:color(darkGrayColor)];
    _currentCompany = [[UITextField alloc]initWithFrame:CGRectMake(10, controlYLength(_currentJob), self.contentView.frame.size.width - 20, nameLeft.frame.size.height)];
    [_currentCompany setBackgroundColor:color(clearColor)];
    [_currentCompany setEnabled:NO];
    [_currentCompany setTextColor:nameLeft.textColor];
    [_currentCompany setFont:nameLeft.font];
    [_currentCompany setText:_myResume.currentCompany];
    [_currentCompany setLeftView:currentCompanyLeft];
    [_currentCompany setLeftViewMode:UITextFieldViewModeAlways];
    [_currentCompany setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.contentView addSubview:_currentCompany];
    
    UILabel *locationLeft = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, nameLeft.frame.size.width, nameLeft.frame.size.height)];
    [locationLeft setBackgroundColor:color(clearColor)];
    [locationLeft setText:@"所在城市:"];
    [locationLeft setFont:[UIFont systemFontOfSize:11]];
    [locationLeft setTextColor:color(darkGrayColor)];
    _location = [[UITextField alloc]initWithFrame:CGRectMake(10, controlYLength(_currentCompany), self.contentView.frame.size.width - 20, nameLeft.frame.size.height)];
    [_location setBackgroundColor:color(clearColor)];
    [_location setEnabled:NO];
    [_location setTextColor:nameLeft.textColor];
    [_location setFont:nameLeft.font];
    [_location setText:_myResume.location];
    [_location setLeftView:locationLeft];
    [_location setLeftViewMode:UITextFieldViewModeAlways];
    [_location setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.contentView addSubview:_location];
    
    UIButton *myPicture = [[UIButton alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width - 60 - 10, controlYLength(self.topBar) + 15, 60, 60)];
    [myPicture.layer setCornerRadius:myPicture.frame.size.width/2];
    [myPicture.layer setMasksToBounds:YES];
    if (_myResume.userPicture) {
        [myPicture setImage:_myResume.userPicture forState:UIControlStateNormal];
    }else{
        [myPicture setImage:imageNameAndType(@"resume_selectimage_normal", @"png") forState:UIControlStateNormal];
    }
    [myPicture setTag:200];
    [myPicture addTarget:self action:@selector(selectMyPicture:) forControlEvents:UIControlEventTouchUpInside];
    [myPicture setBackgroundColor:color(clearColor)];
    [self.contentView addSubview:myPicture];
    
    UIButton *workExperience = [UIButton buttonWithType:UIButtonTypeCustom];
    [workExperience setTag:100];
    [workExperience setFrame:CGRectMake(10, controlYLength(_location) + 15, self.view.frame.size.width - 20, 45)];
    [workExperience setBackgroundColor:color(clearColor)];
    [workExperience setBackgroundImage:imageNameAndType(@"setting_item_normal", @"png") forState:UIControlStateNormal];
    [workExperience setBackgroundImage:imageNameAndType(@"setting_item_press", @"png") forState:UIControlStateHighlighted];
    [workExperience setTitle:@"工作经验" forState:UIControlStateNormal];
    [workExperience.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [workExperience setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [workExperience setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [workExperience setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [workExperience addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:workExperience];
    
    UIButton *eduExperience = [UIButton buttonWithType:UIButtonTypeCustom];
    [eduExperience setTag:101];
    [eduExperience setBackgroundColor:color(clearColor)];
    [eduExperience setFrame:CGRectMake(workExperience.frame.origin.x, controlYLength(workExperience) - 2.50f, workExperience.frame.size.width, workExperience.frame.size.height)];
    [eduExperience setBackgroundImage:imageNameAndType(@"setting_item_normal", @"png") forState:UIControlStateNormal];
    [eduExperience setBackgroundImage:imageNameAndType(@"setting_item_press", @"png") forState:UIControlStateHighlighted];
    [eduExperience setTitle:@"教育经历" forState:UIControlStateNormal];
    [eduExperience.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [eduExperience setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [eduExperience setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [eduExperience setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [eduExperience addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:eduExperience];
    
    UIButton *achievement = [UIButton buttonWithType:UIButtonTypeCustom];
    [achievement setTag:102];
    [achievement setBackgroundColor:color(clearColor)];
    [achievement setFrame:CGRectMake(workExperience.frame.origin.x, controlYLength(eduExperience) + 15, workExperience.frame.size.width, workExperience.frame.size.height)];
    [achievement setBackgroundImage:imageNameAndType(@"setting_item_normal", @"png") forState:UIControlStateNormal];
    [achievement setBackgroundImage:imageNameAndType(@"setting_item_press", @"png") forState:UIControlStateHighlighted];
    [achievement setTitle:@"成就、经验、理念和作品" forState:UIControlStateNormal];
    [achievement.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [achievement setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [achievement setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [achievement setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [achievement addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:achievement];
    
    UIButton *personalShine = [UIButton buttonWithType:UIButtonTypeCustom];
    [personalShine setTag:103];
    [personalShine setBackgroundColor:color(clearColor)];
    [personalShine setFrame:CGRectMake(workExperience.frame.origin.x, controlYLength(achievement) - 2.50f, workExperience.frame.size.width, workExperience.frame.size.height)];
    [personalShine setBackgroundImage:imageNameAndType(@"setting_item_normal", @"png") forState:UIControlStateNormal];
    [personalShine setBackgroundImage:imageNameAndType(@"setting_item_press", @"png") forState:UIControlStateHighlighted];
    [personalShine setTitle:@"个人亮点" forState:UIControlStateNormal];
    [personalShine.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [personalShine setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [personalShine setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [personalShine setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [personalShine addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:personalShine];
    
    UIButton *referrerAssess = [UIButton buttonWithType:UIButtonTypeCustom];
    [referrerAssess setTag:104];
    [referrerAssess setBackgroundColor:color(clearColor)];
    [referrerAssess setFrame:CGRectMake(workExperience.frame.origin.x, controlYLength(personalShine) - 2.50f, workExperience.frame.size.width, workExperience.frame.size.height)];
    [referrerAssess setBackgroundImage:imageNameAndType(@"setting_item_normal", @"png") forState:UIControlStateNormal];
    [referrerAssess setBackgroundImage:imageNameAndType(@"setting_item_press", @"png") forState:UIControlStateHighlighted];
    [referrerAssess setTitle:@"推荐人评估" forState:UIControlStateNormal];
    [referrerAssess.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [referrerAssess setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [referrerAssess setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [referrerAssess setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [referrerAssess addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:referrerAssess];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setBackgroundColor:color(clearColor)];
    [doneButton setFrame:CGRectMake(self.view.frame.size.width/6, controlYLength(referrerAssess) + 20, self.view.frame.size.width*2/3, 45)];
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton setBackgroundImage:imageNameAndType(@"resume_done_normal", @"png") forState:UIControlStateNormal];
    [doneButton setBackgroundImage:imageNameAndType(@"resume_done_press", @"png") forState:UIControlStateHighlighted];
    [doneButton addTarget:self action:@selector(pressDoneButton:) forControlEvents:UIControlEventTouchUpInside];
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
