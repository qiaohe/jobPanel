//
//  MyResumeDetailViewController.m
//  Recruitment
//
//  Created by M J on 13-10-18.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "MyResumeDetailViewController.h"

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


- (void)setSubviewFrame
{
    [self setBackGroundImage:imageNameAndType(@"resume_detail_backimage", @"png")];
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setTitle:@"我的简历"];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    UIButton *workExperience = [UIButton buttonWithType:UIButtonTypeCustom];
    [workExperience setFrame:CGRectMake(10, controlYLength(self.topBar) + 170, self.view.frame.size.width - 20, 40)];
    [workExperience setBackgroundColor:color(clearColor)];
    [workExperience setBackgroundImage:imageNameAndType(@"setting_item_normal", @"png") forState:UIControlStateNormal];
    [workExperience setBackgroundImage:imageNameAndType(@"setting_item_press", @"png") forState:UIControlStateHighlighted];
    [workExperience setTitle:@"工作经验" forState:UIControlStateNormal];
    [workExperience.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [workExperience setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [workExperience setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [workExperience setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.contentView addSubview:workExperience];
    
    UIButton *eduExperience = [UIButton buttonWithType:UIButtonTypeCustom];
    [eduExperience setBackgroundColor:color(clearColor)];
    [eduExperience setFrame:CGRectMake(workExperience.frame.origin.x, controlYLength(workExperience) - 2.50f, workExperience.frame.size.width, workExperience.frame.size.height)];
    [eduExperience setBackgroundImage:imageNameAndType(@"setting_item_normal", @"png") forState:UIControlStateNormal];
    [eduExperience setBackgroundImage:imageNameAndType(@"setting_item_press", @"png") forState:UIControlStateHighlighted];
    [eduExperience setTitle:@"教育经历" forState:UIControlStateNormal];
    [eduExperience.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [eduExperience setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [eduExperience setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [eduExperience setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.contentView addSubview:eduExperience];
    
    UIButton *achievement = [UIButton buttonWithType:UIButtonTypeCustom];
    [achievement setBackgroundColor:color(clearColor)];
    [achievement setFrame:CGRectMake(workExperience.frame.origin.x, controlYLength(eduExperience) + 15, workExperience.frame.size.width, workExperience.frame.size.height)];
    [achievement setBackgroundImage:imageNameAndType(@"setting_item_normal", @"png") forState:UIControlStateNormal];
    [achievement setBackgroundImage:imageNameAndType(@"setting_item_press", @"png") forState:UIControlStateHighlighted];
    [achievement setTitle:@"成就、经验、理念和作品" forState:UIControlStateNormal];
    [achievement.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [achievement setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [achievement setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [achievement setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.contentView addSubview:achievement];
    
    UIButton *personalShine = [UIButton buttonWithType:UIButtonTypeCustom];
    [personalShine setBackgroundColor:color(clearColor)];
    [personalShine setFrame:CGRectMake(workExperience.frame.origin.x, controlYLength(achievement) - 2.50f, workExperience.frame.size.width, workExperience.frame.size.height)];
    [personalShine setBackgroundImage:imageNameAndType(@"setting_item_normal", @"png") forState:UIControlStateNormal];
    [personalShine setBackgroundImage:imageNameAndType(@"setting_item_press", @"png") forState:UIControlStateHighlighted];
    [personalShine setTitle:@"个人亮点" forState:UIControlStateNormal];
    [personalShine.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [personalShine setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [personalShine setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [personalShine setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.contentView addSubview:personalShine];
    
    UIButton *referrerAssess = [UIButton buttonWithType:UIButtonTypeCustom];
    [referrerAssess setBackgroundColor:color(clearColor)];
    [referrerAssess setFrame:CGRectMake(workExperience.frame.origin.x, controlYLength(personalShine) - 2.50f, workExperience.frame.size.width, workExperience.frame.size.height)];
    [referrerAssess setBackgroundImage:imageNameAndType(@"setting_item_normal", @"png") forState:UIControlStateNormal];
    [referrerAssess setBackgroundImage:imageNameAndType(@"setting_item_press", @"png") forState:UIControlStateHighlighted];
    [referrerAssess setTitle:@"推荐人评估" forState:UIControlStateNormal];
    [referrerAssess.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [referrerAssess setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [referrerAssess setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [referrerAssess setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.contentView addSubview:referrerAssess];
    
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
