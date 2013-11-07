//
//  RecruitManagerViewController.m
//  Recruitment
//
//  Created by M J on 13-10-16.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "RecruitManagerViewController.h"
#import "InformationViewController.h"
#import "MyResumeViewController.h"
#import "ResumeTraceViewController.h"

@interface RecruitManagerViewController ()

@end

@implementation RecruitManagerViewController

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

- (void)pressButton:(UIButton*)sender
{
    switch (sender.tag) {
        case 101:{
            MyResumeViewController *myResumeView = [[MyResumeViewController alloc]initWithType:MyResumeEdit];
            [self.navigationController pushViewController:myResumeView animated:YES];
            break;
        }case 102:{
            InformationViewController *informationView = [[InformationViewController alloc]initWithType:Informationcollect];
            [self.navigationController pushViewController:informationView animated:YES];
            break;
        }case 103:{
            ResumeTraceViewController *resumeTraceView = [[ResumeTraceViewController alloc]init];
            [self.navigationController pushViewController:resumeTraceView animated:YES];
            break;
        }
        default:
            break;
    }
}

- (void)setSubviewFrame
{
    [self setBackGroundImage:imageNameAndType(@"subview_backimage", @"png")];
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setTitle:@"应聘管理"];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    UIImageView *resumeLeft = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [resumeLeft setBackgroundColor:color(clearColor)];
    [resumeLeft setImage:imageNameAndType(@"myresume", @"png")];
    UIButton *myResume = [UIButton buttonWithType:UIButtonTypeCustom];
    [myResume setTag:101];
    [myResume setFrame:CGRectMake(10, controlYLength(self.topBar) + 10, self.view.frame.size.width - 20, resumeLeft.frame.size.height)];
    [myResume setBackgroundColor:color(clearColor)];
    [myResume setBackgroundImage:imageNameAndType(@"setting_item_normal", @"png") forState:UIControlStateNormal];
    [myResume setBackgroundImage:imageNameAndType(@"setting_item_press", @"png") forState:UIControlStateHighlighted];
    [myResume setTitle:@"我的简历" forState:UIControlStateNormal];
    [myResume.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [myResume setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [myResume setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [myResume setTitleEdgeInsets:UIEdgeInsetsMake(0, resumeLeft.frame.size.width, 0, 0)];
    [myResume addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [myResume addSubview:resumeLeft];
    [self.contentView addSubview:myResume];
    
    UIImageView *collectLeft = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, resumeLeft.frame.size.width, resumeLeft.frame.size.height)];
    [collectLeft setBackgroundColor:color(clearColor)];
    [collectLeft setImage:imageNameAndType(@"mycollect", @"png")];
    UIButton *myCollect = [UIButton buttonWithType:UIButtonTypeCustom];
    [myCollect setTag:102];
    [myCollect setBackgroundColor:color(clearColor)];
    [myCollect setFrame:CGRectMake(myResume.frame.origin.x, controlYLength(myResume) + 5, myResume.frame.size.width, myResume.frame.size.height)];
    [myCollect setBackgroundImage:imageNameAndType(@"setting_item_normal", @"png") forState:UIControlStateNormal];
    [myCollect setBackgroundImage:imageNameAndType(@"setting_item_press", @"png") forState:UIControlStateHighlighted];
    [myCollect setTitle:@"我的收藏" forState:UIControlStateNormal];
    [myCollect.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [myCollect setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [myCollect setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [myCollect setTitleEdgeInsets:UIEdgeInsetsMake(0, collectLeft.frame.size.width, 0, 0)];
    [myCollect addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [myCollect addSubview:collectLeft];
    [self.contentView addSubview:myCollect];
    
    UIImageView *traceLeft = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, resumeLeft.frame.size.width, resumeLeft.frame.size.height)];
    [traceLeft setBackgroundColor:color(clearColor)];
    [traceLeft setImage:imageNameAndType(@"recruittrace", @"png")];
    UIButton *recruitTrace = [UIButton buttonWithType:UIButtonTypeCustom];
    [recruitTrace setTag:103];
    [recruitTrace setBackgroundColor:color(clearColor)];
    [recruitTrace setFrame:CGRectMake(myResume.frame.origin.x, controlYLength(myCollect) + 5, myResume.frame.size.width, myResume.frame.size.height)];
    [recruitTrace setBackgroundImage:imageNameAndType(@"setting_item_normal", @"png") forState:UIControlStateNormal];
    [recruitTrace setBackgroundImage:imageNameAndType(@"setting_item_press", @"png") forState:UIControlStateHighlighted];
    [recruitTrace setTitle:@"应聘追踪" forState:UIControlStateNormal];
    [recruitTrace.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [recruitTrace setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [recruitTrace setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [recruitTrace setTitleEdgeInsets:UIEdgeInsetsMake(0, traceLeft.frame.size.width, 0, 0)];
    [recruitTrace addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [recruitTrace addSubview:traceLeft];
    [self.contentView addSubview:recruitTrace];
    
    [self setBottomBarBackGroundImage:imageNameAndType(@"bottombar", @"png")];
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeButton setBackgroundColor:color(clearColor)];
    [homeButton setTag:101];
    [homeButton setImage:imageNameAndType(@"returnhome_normal", @"png") forState:UIControlStateNormal];
    [homeButton setImage:imageNameAndType(@"returnhome_press", @"png") forState:UIControlStateHighlighted];
    [self setPopToMainViewButton:homeButton];
    [self setBottomBarItems:@[homeButton]];
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
