//
//  JobDetailViewController.m
//  Recruitment
//
//  Created by M J on 13-11-6.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "JobDetailViewController.h"
#import "InformationDetailViewController.h"
#import "InformationViewController.h"
#import "MyResumeViewController.h"
#import "JobInformation.h"
#import "CompanyDetail.h"

@interface JobDetailViewController ()

@end

@implementation JobDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithDetail:(JobInformation*)jobDetail
{
    self = [super init];
    if (self){
        _jobInformation = jobDetail;
        [self setSubviewFrame];
    }

    return self;
}

- (void)pressCompanyLogoBtn:(UIButton*)sender
{
    CompanyDetail *detail = [[CompanyDetail alloc]initWithJobInformation:_jobInformation];
    InformationDetailViewController *detailView = [[InformationDetailViewController alloc]initWithObject:detail];
    [self pushViewController:detailView transitionType:TransitionPush completionHandler:nil];
}

- (void)setSubviewFrame
{
    [self setBackGroundImage:imageNameAndType(@"information_backimage", @"png")];
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setTitle:@"职位详情"];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png")
                  forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png")
                  forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png")
                  forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    UIImageView *companyDetailImage = [[UIImageView alloc]initWithFrame:
                                       CGRectMake(0,
                                                  controlYLength(self.topBar),
                                                  self.contentView.frame.size.width,
                                                  self.contentView.frame.size.width * 3/5)];
    NSString *imageName = arc4random()%2 == 0?@"detail_item1":@"detail_item2";
    [companyDetailImage setImage:imageNameAndType(imageName, @"png")];
    [companyDetailImage setBackgroundColor:color(clearColor)];
    [self.contentView addSubview:companyDetailImage];
    
    UIButton *companyLogoBtn = [[UIButton alloc]initWithFrame:
                                     CGRectMake(0,
                                                controlYLength(companyDetailImage),
                                                80,
                                                80)];
    [companyLogoBtn setBackgroundColor:color(clearColor)];
    [companyLogoBtn setBounds:CGRectMake(0,
                                           0,
                                           companyLogoBtn.frame.size.width * 0.7,
                                           companyLogoBtn.frame.size.height * 0.7)];
    [companyLogoBtn setImage:imageNameAndType(_jobInformation.jobIcon, nil) forState:UIControlStateNormal];
    [companyLogoBtn addTarget:self action:@selector(pressCompanyLogoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:companyLogoBtn];
    
    UILabel     *companyNameLabel = [[UILabel alloc]initWithFrame:
                                     CGRectMake(controlXLength(companyLogoBtn) + 5,
                                                companyLogoBtn.frame.origin.y + 5,
                                                self.contentView.frame.size.width - controlXLength(companyLogoBtn) - 5,
                                                (companyLogoBtn.frame.size.height - 5)/3)];
    [companyNameLabel setBackgroundColor:color(clearColor)];
    [companyNameLabel setText:_jobInformation.company];
    [companyNameLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [self.contentView addSubview:companyNameLabel];
    
    UILabel     *companyDetailLabel = [[UILabel alloc]initWithFrame:
                                       CGRectMake(companyNameLabel.frame.origin.x,
                                                  controlYLength(companyNameLabel),
                                                  companyNameLabel.frame.size.width,
                                                  companyNameLabel.frame.size.height)];
    [companyDetailLabel setBackgroundColor:color(clearColor)];
    [companyDetailLabel setNumberOfLines:0];
    [companyDetailLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [companyDetailLabel setAdjustsFontSizeToFitWidth:YES];
    [companyDetailLabel setAdjustsLetterSpacingToFitWidth:YES];
    [companyDetailLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    [companyDetailLabel setMinimumScaleFactor:0.5];
    [companyDetailLabel setText:_jobInformation.position];
    [companyDetailLabel setFont:[UIFont systemFontOfSize:12]];
    [self.contentView addSubview:companyDetailLabel];
    
    UILabel     *locationLabel      = [[UILabel alloc]initWithFrame:
                                       CGRectMake(self.contentView.frame.size.width - 10 - 80,
                                                  controlYLength(companyDetailLabel),
                                                  80,
                                                  30)];
    [locationLabel setBackgroundColor:color(clearColor)];
    [locationLabel setText:_jobInformation.location];
    [locationLabel setFont:[UIFont systemFontOfSize:10]];
    [locationLabel setTextColor:color(grayColor)];
    [self.contentView addSubview:locationLabel];
    
    UIImageView *locationImage      = [[UIImageView alloc]initWithFrame:
                                       CGRectMake(locationLabel.frame.origin.x - 20,
                                                  locationLabel.frame.origin.y + 5,
                                                  20,
                                                  20)];
    [locationImage setBackgroundColor:color(clearColor)];
    [locationImage setImage:imageNameAndType(@"resume_location", @"png")];
    [self.contentView addSubview:locationImage];
    
    UIImageView *detailLine1 = [[UIImageView alloc]initWithFrame:
                                CGRectMake(10,
                                           controlYLength(locationImage),
                                           self.contentView.frame.size.width - 20,
                                           5)];
    [detailLine1 setBackgroundColor:color(clearColor)];
    [detailLine1 setImage:imageNameAndType(@"detail_line", nil)];
    [self.contentView addSubview:detailLine1];
    
    UILabel *jobs = [[UILabel alloc]initWithFrame:
                     CGRectMake(detailLine1.frame.origin.x + 10,
                                controlYLength(detailLine1) + 5,
                                detailLine1.frame.size.width - 20,
                                20)];
    [jobs setTextColor:color(darkGrayColor)];
    [jobs setText:[NSString stringWithFormat:@"职位:%@",_jobInformation.position]];
    [jobs setFont:[UIFont systemFontOfSize:10]];
    [jobs setBackgroundColor:color(clearColor)];
    [jobs setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:jobs];
    
    UILabel *salaryForYear = [[UILabel alloc]initWithFrame:jobs.frame];
    [salaryForYear setTextColor:color(darkGrayColor)];
    [salaryForYear setText:[NSString stringWithFormat:@"年薪资待遇:%@",_jobInformation.salary]];
    [salaryForYear setFont:jobs.font];
    [salaryForYear setBackgroundColor:color(clearColor)];
    [salaryForYear setTextAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:salaryForYear];
    
    UILabel *workLocation = [[UILabel alloc]initWithFrame:
                            CGRectMake(jobs.frame.origin.x,
                                       controlYLength(jobs),
                                       jobs.frame.size.width,
                                       jobs.frame.size.height)];
    [workLocation setTextColor:color(darkGrayColor)];
    [workLocation setText:[NSString stringWithFormat:@"公司规模:%@",_jobInformation.location]];
    [workLocation setFont:jobs.font];
    [workLocation setBackgroundColor:color(clearColor)];
    [workLocation setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:workLocation];
    
    UIImageView *detailLine2 = [[UIImageView alloc]initWithFrame:
                                CGRectMake(detailLine1.frame.origin.x,
                                           controlYLength(workLocation) + 5,
                                           detailLine1.frame.size.width,
                                           detailLine1.frame.size.height)];
    [detailLine2 setBackgroundColor:color(clearColor)];
    [detailLine2 setImage:imageNameAndType(@"detail_line", nil)];
    [self.contentView addSubview:detailLine2];
    
    UITextView *companyDescription = [[UITextView alloc]initWithFrame:
                                      CGRectMake(jobs.frame.origin.x,
                                                 controlYLength(detailLine2) + 10,
                                                 jobs.frame.size.width,
                                                 [Utils heightForWidth:jobs.frame.size.width
                                                                  text:[NSString stringWithFormat:@"  %@",_jobInformation.positionDescription]
                                                                  font:[UIFont systemFontOfSize:14]])];
    [companyDescription setBackgroundColor:color(clearColor)];
    [companyDescription setFont:[UIFont systemFontOfSize:14]];
    [companyDescription setEditable:NO];
    [companyDescription setScrollEnabled:NO];
    [companyDescription setText:[NSString stringWithFormat:@"  %@",_jobInformation.positionDescription]];
    [self.contentView addSubview:companyDescription];
    
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectButton setBackgroundColor:color(clearColor)];
    [collectButton setImage:imageNameAndType(@"collect_normal", @"png") forState:UIControlStateNormal];
    [collectButton setImage:imageNameAndType(@"collect_press", @"png") forState:UIControlStateHighlighted];
    [collectButton setTag:101];
    
    UIButton *deliverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deliverButton setBackgroundColor:color(clearColor)];
    [deliverButton setImage:imageNameAndType(@"deliver_normal", @"png") forState:UIControlStateNormal];
    [deliverButton setImage:imageNameAndType(@"deliver_press", @"png") forState:UIControlStateHighlighted];
    [deliverButton setTag:102];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setBackgroundColor:color(clearColor)];
    [shareButton setImage:imageNameAndType(@"share_normal", @"png") forState:UIControlStateNormal];
    [shareButton setImage:imageNameAndType(@"share_press", @"png") forState:UIControlStateHighlighted];
    [shareButton setTag:103];
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeButton setBackgroundColor:color(clearColor)];
    [homeButton setTag:102];
    [homeButton setImage:imageNameAndType(@"returnhome_normal", @"png") forState:UIControlStateNormal];
    [homeButton setImage:imageNameAndType(@"returnhome_press", @"png") forState:UIControlStateHighlighted];
    [self setPopToMainViewButton:homeButton];
    [self setBottomBarItems:@[collectButton,deliverButton,shareButton,homeButton]];
    [self setBottomBarBackGroundImage:imageNameAndType(@"bottombar", @"png")];
    
    [collectButton  addTarget:self action:@selector(pressBottomBarItem:) forControlEvents:UIControlEventTouchUpInside];
    [deliverButton  addTarget:self action:@selector(pressBottomBarItem:) forControlEvents:UIControlEventTouchUpInside];
    [shareButton    addTarget:self action:@selector(pressBottomBarItem:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)pressBottomBarItem:(UIButton*)sender
{
    switch (sender.tag) {
        case 101:{
            [[Model shareModel] showPromptText:@"收藏成功" model:YES];
            InformationViewController *informationView = [[InformationViewController alloc]initWithType:Informationcollect];
            [self.navigationController pushViewController:informationView animated:YES];
            break;
        }case 102:{
            MyResumeViewController *myResumeView = [[MyResumeViewController alloc]initWithType:MyResumeDeliver];
            [self.navigationController pushViewController:myResumeView animated:YES];
            break;
        }case 103:{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"分享到" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"腾讯微博",@"新浪微博", nil];
            [alertView setTag:301];
            [alertView show];
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
