//
//  SettingViewController.m
//  Recruitment
//
//  Created by M J on 13-10-16.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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
    [self setBackGroundImage:imageNameAndType(@"subview_backimage", @"png")];
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setTitle:@"设置"];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    UIButton *accountManager = [UIButton buttonWithType:UIButtonTypeCustom];
    [accountManager setFrame:CGRectMake(10, controlYLength(self.topBar) + 10, self.view.frame.size.width - 20, 50)];
    [accountManager setBackgroundColor:color(clearColor)];
    [accountManager setBackgroundImage:imageNameAndType(@"setting_item_normal", @"png") forState:UIControlStateNormal];
    [accountManager setBackgroundImage:imageNameAndType(@"setting_item_press", @"png") forState:UIControlStateHighlighted];
    [accountManager setTitle:@"账号维护" forState:UIControlStateNormal];
    [accountManager.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [accountManager setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [accountManager setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [accountManager setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.contentView addSubview:accountManager];
    
    UIButton *resumeManager = [UIButton buttonWithType:UIButtonTypeCustom];
    [resumeManager setBackgroundColor:color(clearColor)];
    [resumeManager setFrame:CGRectMake(accountManager.frame.origin.x, controlYLength(accountManager), accountManager.frame.size.width, accountManager.frame.size.height)];
    [resumeManager setBackgroundImage:imageNameAndType(@"setting_item_normal", @"png") forState:UIControlStateNormal];
    [resumeManager setBackgroundImage:imageNameAndType(@"setting_item_press", @"png") forState:UIControlStateHighlighted];
    [resumeManager setTitle:@"简历维护" forState:UIControlStateNormal];
    [resumeManager.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [resumeManager setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [resumeManager setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [resumeManager setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.contentView addSubview:resumeManager];
    
    UIButton *inputContacts = [UIButton buttonWithType:UIButtonTypeCustom];
    [inputContacts setBackgroundColor:color(clearColor)];
    [inputContacts setFrame:CGRectMake(accountManager.frame.origin.x, controlYLength(resumeManager), accountManager.frame.size.width, accountManager.frame.size.height)];
    [inputContacts setBackgroundImage:imageNameAndType(@"settingitem", @"png") forState:UIControlStateNormal];
    [inputContacts setBackgroundImage:imageNameAndType(@"settingitem", @"png") forState:UIControlStateHighlighted];
    [inputContacts setTitle:@"导入人脉" forState:UIControlStateNormal];
    [inputContacts.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [inputContacts setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [inputContacts setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [inputContacts setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.contentView addSubview:inputContacts];
    
    UIButton *jobNotification = [UIButton buttonWithType:UIButtonTypeCustom];
    [jobNotification setBackgroundColor:color(clearColor)];
    [jobNotification setFrame:CGRectMake(accountManager.frame.origin.x, controlYLength(inputContacts) + 30, accountManager.frame.size.width, accountManager.frame.size.height)];
    [jobNotification setBackgroundImage:imageNameAndType(@"settingitem", @"png") forState:UIControlStateNormal];
    [jobNotification setBackgroundImage:imageNameAndType(@"settingitem", @"png") forState:UIControlStateHighlighted];
    [jobNotification setTitle:@"职位推送" forState:UIControlStateNormal];
    [jobNotification.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [jobNotification setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [jobNotification setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [jobNotification setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.contentView addSubview:jobNotification];
    
    UISwitch *sch = [[UISwitch alloc]init];
    [sch setCenter:CGPointMake(controlXLength(jobNotification) - sch.frame.size.width/2 - 5, jobNotification.center.y)];
    [sch setBackgroundColor:color(clearColor)];
    //[sch setOnImage:imageNameAndType(@"setting_switch_on", @"png")];
    //[sch setOffImage:imageNameAndType(@"setting_switch_off", @"png")];
    [sch setOn:YES];
    [self.contentView addSubview:sch];
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
