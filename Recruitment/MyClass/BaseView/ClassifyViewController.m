//
//  ClassifyViewController.m
//  Recruitment
//
//  Created by M J on 13-10-12.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "ClassifyViewController.h"
#import "SettingViewController.h"
#import "RecommendViewController.h"
#import "MyGrowingViewController.h"
#import "ContactsStatusViewController.h"
#import "InformationViewController.h"
#import "RecruitManagerViewController.h"
#import "OpportunityViewController.h"

@interface ClassifyViewController ()

@end

@implementation ClassifyViewController

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
    [self setBackGroundImage:imageNameAndType(@"classify_backimage", @"png")];
    
    [self setTopBarBackGroundImage:imageNameAndType(@"classify_topbar", @"png")];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 80, 40)];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setBackgroundColor:[UIColor clearColor]];
    [rightButton setFrame:CGRectMake(self.view.frame.size.width - 45, 0, 40, 40)];
    [rightButton setImage:imageNameAndType(@"setting_normal", @"png") forState:UIControlStateNormal];
    [rightButton setImage:imageNameAndType(@"setting_press", @"png") forState:UIControlStateHighlighted];
    [rightButton setImage:imageNameAndType(@"setting_press", @"png") forState:UIControlStateSelected];
    [rightButton setTag:100];
    [rightButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    
    CGFloat surplusHeight = self.view.frame.size.height - (self.topBar.frame.origin.y + self.topBar.frame.size.height);
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, controlYLength(self.topBar), self.view.frame.size.width, surplusHeight)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scrollView];
    
    UIButton *myGrew = [UIButton buttonWithType:UIButtonTypeCustom];
    [myGrew setFrame:CGRectMake(10, 10, (self.view.frame.size.width - 30)/2, (surplusHeight - 40)/3)];
    [myGrew setBackgroundColor:[UIColor clearColor]];
    myGrew.tag = 101;
    [myGrew addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [myGrew setImage:imageNameAndType(@"classify_mygrew", @"png") forState:UIControlStateNormal];
    [scrollView addSubview:myGrew];
    
    UILabel *growingLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, myGrew.frame.size.width - 20, 40)];
    [growingLabel setBackgroundColor:color(clearColor)];
    [growingLabel setFont:[UIFont systemFontOfSize:14]];
    [growingLabel setText:@"我的成长"];
    [growingLabel setTextColor:color(whiteColor)];
    [myGrew addSubview:growingLabel];
    
    UIButton *resource = [UIButton buttonWithType:UIButtonTypeCustom];
    [resource setFrame:CGRectMake(self.view.frame.size.width - 10 - myGrew.frame.size.width, myGrew.frame.origin.y, myGrew.frame.size.width, myGrew.frame.size.height)];
    [resource setBackgroundColor:[UIColor clearColor]];
    resource.tag = 102;
    [resource addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [resource setImage:imageNameAndType(@"classify_resource", @"png") forState:UIControlStateNormal];
    [scrollView addSubview:resource];
    
    UILabel *resourceLabel = [[UILabel alloc]initWithFrame:CGRectMake(growingLabel.frame.origin.x, growingLabel.frame.origin.y, growingLabel.frame.size.width, growingLabel.frame.size.height)];
    [resourceLabel setBackgroundColor:color(clearColor)];
    [resourceLabel setFont:[UIFont systemFontOfSize:14]];
    [resourceLabel setText:@"资源人脉"];
    [resourceLabel setTextColor:color(whiteColor)];
    [resource addSubview:resourceLabel];
    
    UIButton *Industryinformation = [UIButton buttonWithType:UIButtonTypeCustom];
    [Industryinformation setFrame:CGRectMake(myGrew.frame.origin.x, controlYLength(myGrew) + 10, myGrew.frame.size.width, myGrew.frame.size.height)];
    [Industryinformation setBackgroundColor:[UIColor clearColor]];
    Industryinformation.tag = 103;
    [Industryinformation addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [Industryinformation setImage:imageNameAndType(@"classify_Industryinformation", @"png") forState:UIControlStateNormal];
    [scrollView addSubview:Industryinformation];
    
    UILabel *IndustryinformationLabel = [[UILabel alloc]initWithFrame:CGRectMake(growingLabel.frame.origin.x, growingLabel.frame.origin.y, growingLabel.frame.size.width, growingLabel.frame.size.height)];
    [IndustryinformationLabel setBackgroundColor:color(clearColor)];
    [IndustryinformationLabel setFont:[UIFont systemFontOfSize:14]];
    [IndustryinformationLabel setText:@"行业资讯"];
    [IndustryinformationLabel setTextColor:color(whiteColor)];
    [Industryinformation addSubview:IndustryinformationLabel];
    
    UIButton *opportunity = [UIButton buttonWithType:UIButtonTypeCustom];
    [opportunity setFrame:CGRectMake(resource.frame.origin.x, Industryinformation.frame.origin.y, myGrew.frame.size.width, myGrew.frame.size.height)];
    [opportunity setBackgroundColor:[UIColor clearColor]];
    opportunity.tag = 104;
    [opportunity addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [opportunity setImage:imageNameAndType(@"classify_opportunity", @"png") forState:UIControlStateNormal];
    [scrollView addSubview:opportunity];
    
    UILabel *opportunityLabel = [[UILabel alloc]initWithFrame:CGRectMake(growingLabel.frame.origin.x, growingLabel.frame.origin.y, growingLabel.frame.size.width, growingLabel.frame.size.height)];
    [opportunityLabel setBackgroundColor:color(clearColor)];
    [opportunityLabel setFont:[UIFont systemFontOfSize:14]];
    [opportunityLabel setText:@"关注机遇"];
    [opportunityLabel setTextColor:color(whiteColor)];
    [opportunity addSubview:opportunityLabel];
    
    UIButton *recommend = [UIButton buttonWithType:UIButtonTypeCustom];
    [recommend setFrame:CGRectMake(myGrew.frame.origin.x, controlYLength(Industryinformation) + 10, myGrew.frame.size.width, myGrew.frame.size.height)];
    [recommend setBackgroundColor:[UIColor clearColor]];
    recommend.tag = 105;
    [recommend addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [recommend setImage:imageNameAndType(@"classify_recommend", @"png") forState:UIControlStateNormal];
    [scrollView addSubview:recommend];
    
    UILabel *recommendLabel = [[UILabel alloc]initWithFrame:CGRectMake(growingLabel.frame.origin.x, growingLabel.frame.origin.y, growingLabel.frame.size.width, growingLabel.frame.size.height)];
    [recommendLabel setBackgroundColor:color(clearColor)];
    [recommendLabel setFont:[UIFont systemFontOfSize:14]];
    [recommendLabel setText:@"精选职位"];
    [recommendLabel setTextColor:color(whiteColor)];
    [recommend addSubview:recommendLabel];
    
    UIButton *recruitmanager = [UIButton buttonWithType:UIButtonTypeCustom];
    [recruitmanager setFrame:CGRectMake(opportunity.frame.origin.x, recommend.frame.origin.y, myGrew.frame.size.width, myGrew.frame.size.height)];
    [recruitmanager setBackgroundColor:[UIColor clearColor]];
    recruitmanager.tag = 106;
    [recruitmanager addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [recruitmanager setImage:imageNameAndType(@"classify_recruitmanager", @"png") forState:UIControlStateNormal];
    [scrollView addSubview:recruitmanager];
    
    UILabel *recruitmanagerLabel = [[UILabel alloc]initWithFrame:CGRectMake(growingLabel.frame.origin.x, growingLabel.frame.origin.y, growingLabel.frame.size.width, growingLabel.frame.size.height)];
    [recruitmanagerLabel setBackgroundColor:color(clearColor)];
    [recruitmanagerLabel setFont:[UIFont systemFontOfSize:14]];
    [recruitmanagerLabel setText:@"应聘管理"];
    [recruitmanagerLabel setTextColor:color(whiteColor)];
    [recruitmanager addSubview:recruitmanagerLabel];
}

- (void)pressButton:(UIButton*)sender
{
    switch (sender.tag) {
        case 100:{
            SettingViewController *settingView = [[SettingViewController alloc]init];
            [self.navigationController pushViewController:settingView animated:YES];
            break;
        }case 101:{
            MyGrowingViewController *myGrowingView =[[MyGrowingViewController alloc]init];
            [self.navigationController pushViewController:myGrowingView animated:YES];
            break;
        }case 102:{
            ContactsStatusViewController *contactsView = [[ContactsStatusViewController alloc]init];
            [self.navigationController pushViewController:contactsView animated:YES];
            break;
        }case 103:{
            InformationViewController *informationView = [[InformationViewController alloc]initWithType:InformationIndustryPage];
            [self.navigationController pushViewController:informationView animated:YES];
            break;
        }case 104:{
            OpportunityViewController *opportunityView = [[OpportunityViewController alloc] init];
            [self.navigationController pushViewController:opportunityView animated:YES];
            break;
        }case 105:{
            RecommendViewController *recommendView = [[RecommendViewController alloc]init];
            [self.navigationController pushViewController:recommendView animated:YES];
            break;
        }case 106:{
            RecruitManagerViewController *recruiteManagerView = [[RecruitManagerViewController alloc]init];
            [self.navigationController pushViewController:recruiteManagerView animated:YES];
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
