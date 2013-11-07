//
//  CompanyDetailViewController.m
//  Recruitment
//
//  Created by M J on 13-11-1.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "CompanyDetailViewController.h"

@interface CompanyDetailViewController ()

@end

@implementation CompanyDetailViewController

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

- (id)initWithIndustryInformation:(IndustryInformation*)information
{
    self = [super init];
    if (self) {
        _information = information;
        [self setSubviewFrame];
    }
    return self;
}

- (void)setSubviewFrame
{
    [self setBackGroundImage:imageNameAndType(@"information_backimage", @"png")];
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setTitle:@"咨讯详情"];
    
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
    [companyDetailImage setImage:imageNameAndType(@"company_detail_item", @"jpg")];
    [companyDetailImage setBackgroundColor:color(clearColor)];
    [self.contentView addSubview:companyDetailImage];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, controlYLength(companyDetailImage) + 10, self.contentView.frame.size.width - 20, 0)];
    [titleLabel setFont:[UIFont systemFontOfSize:13]];
    CGFloat height = [Utils heightForWidth:titleLabel.frame.size.width text:[NSString stringWithFormat:@"    %@",_information.title] font:titleLabel.font];
    [titleLabel setFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y, titleLabel.frame.size.width, height)];
    [titleLabel setText:[NSString stringWithFormat:@"    %@",_information.title]];
    [titleLabel setNumberOfLines:0];
    [titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:titleLabel];
    
    UILabel *detailAndDescriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.frame.origin.x, controlYLength(titleLabel) + 10, titleLabel.frame.size.width, 0)];
    [detailAndDescriptionLabel setFont:[UIFont systemFontOfSize:13]];
    CGFloat detailHeight = [Utils heightForWidth:detailAndDescriptionLabel.frame.size.width text:[NSString stringWithFormat:@"    %@",_information.detail] font:detailAndDescriptionLabel.font];
    [detailAndDescriptionLabel setFrame:CGRectMake(detailAndDescriptionLabel.frame.origin.x, detailAndDescriptionLabel.frame.origin.y, detailAndDescriptionLabel.frame.size.width, detailHeight)];
    [detailAndDescriptionLabel setText:[NSString stringWithFormat:@"    %@",_information.detail]];
    [detailAndDescriptionLabel setNumberOfLines:0];
    [detailAndDescriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:detailAndDescriptionLabel];
    
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
