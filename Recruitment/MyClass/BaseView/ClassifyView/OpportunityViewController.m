//
//  OpportunityViewController.m
//  Recruitment
//
//  Created by Jack Wang on 10/30/13.
//  Copyright (c) 2013 M J. All rights reserved.
//

#import "OpportunityViewController.h"
#import "InformationViewController.h"
#import "JobViewController.h"
#import "ShakeViewController.h"

@interface OpportunityViewController ()

@end

@implementation OpportunityViewController

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
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setBackGroundImage:imageNameAndType(@"subview_backimage", @"png")];
    [self setTitle:@"关注机遇"];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    UIImageView *opportunityLeft = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [opportunityLeft setBounds:CGRectMake(0, 0, opportunityLeft.frame.size.width*0.8, opportunityLeft.frame.size.height*0.8)];
    [opportunityLeft setBackgroundColor:color(clearColor)];
    [opportunityLeft setImage:imageNameAndType(@"opportunity_list", @"png")];
    
    UIButton *opportunityList = [UIButton buttonWithType:UIButtonTypeCustom];
    [opportunityList setFrame:CGRectMake(10, controlYLength(self.topBar) + 10, self.view.frame.size.width - 20, 50)];
    [opportunityList setBackgroundColor:color(clearColor)];
    [opportunityList setBackgroundImage:imageNameAndType(@"setting_item_normal", @"png") forState:UIControlStateNormal];
    [opportunityList setBackgroundImage:imageNameAndType(@"setting_item_press", @"png") forState:UIControlStateHighlighted];
    opportunityList.tag = 101;
    [opportunityList addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [opportunityList setTitle:@"机遇列表" forState:UIControlStateNormal];
    [opportunityList.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [opportunityList setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [opportunityList setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [opportunityList setTitleEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
    [opportunityList addSubview:opportunityLeft];
    [self.contentView addSubview:opportunityList];
    
    UIImageView *nearCompanyLeft = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [nearCompanyLeft setBounds:CGRectMake(0, 0, opportunityLeft.frame.size.width*0.8, opportunityLeft.frame.size.height*0.8)];
    [nearCompanyLeft setBackgroundColor:color(clearColor)];
    [nearCompanyLeft setImage:imageNameAndType(@"near_company", @"png")];
    
    UIButton *nearCompany = [UIButton buttonWithType:UIButtonTypeCustom];
    [nearCompany setFrame:CGRectMake(opportunityList.frame.origin.x, controlYLength(opportunityList) + 10, opportunityList.frame.size.width, opportunityList.frame.size.height)];
    [nearCompany setBackgroundColor:color(clearColor)];
    [nearCompany setBackgroundImage:imageNameAndType(@"setting_item_normal", @"png") forState:UIControlStateNormal];
    [nearCompany setBackgroundImage:imageNameAndType(@"setting_item_press", @"png") forState:UIControlStateHighlighted];
    nearCompany.tag = 102;
    [nearCompany addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [nearCompany setTitle:@"附近公司" forState:UIControlStateNormal];
    [nearCompany.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [nearCompany setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [nearCompany setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [nearCompany setTitleEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
    [nearCompany addSubview:nearCompanyLeft];
    [self.contentView addSubview:nearCompany];
    
    
    UIImageView *shakeLeft = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [shakeLeft setBounds:CGRectMake(0, 0, opportunityLeft.frame.size.width*0.8, opportunityLeft.frame.size.height*0.8)];
    [shakeLeft setBackgroundColor:color(clearColor)];
    [shakeLeft setImage:imageNameAndType(@"shake_icon", @"png")];
    
    UIButton *shake = [UIButton buttonWithType:UIButtonTypeCustom];
    [shake setFrame:CGRectMake(opportunityList.frame.origin.x, controlYLength(nearCompany) + 10, opportunityList.frame.size.width, opportunityList.frame.size.height)];
    [shake setBackgroundColor:color(clearColor)];
    [shake setBackgroundImage:imageNameAndType(@"setting_item_normal", @"png") forState:UIControlStateNormal];
    [shake setBackgroundImage:imageNameAndType(@"setting_item_press", @"png") forState:UIControlStateHighlighted];
    shake.tag = 103;
    [shake addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [shake setTitle:@"摇一摇" forState:UIControlStateNormal];
    [shake.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [shake setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [shake setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [shake setTitleEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
    [shake addSubview:shakeLeft];
    [self.contentView addSubview:shake];
    
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

- (void)pressButton:(UIButton*)sender
{
    switch (sender.tag) {
        case 101:{
            JobViewController *jobView = [[JobViewController alloc]init];
            [self.navigationController pushViewController:jobView animated:YES];
            break;
        }case 102:{
            InformationViewController *informationView = [[InformationViewController alloc]initWithType:InformationNearPage];
            [self.navigationController pushViewController:informationView animated:YES];
            break;
        }case 103:{
            ShakeViewController *shakeView = [[ShakeViewController alloc] init];
            [self.navigationController pushViewController:shakeView animated:YES];
            break;
        }
        default:
            break;
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
