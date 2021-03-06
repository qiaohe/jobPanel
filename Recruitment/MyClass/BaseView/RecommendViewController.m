//
//  RecommendViewController.m
//  Recruitment
//
//  Created by M J on 13-10-12.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "RecommendViewController.h"
#import "InformationViewController.h"
#import "JobDetailViewController.h"
#import "MyResumeViewController.h"
#import "CustomButton.h"
#import "CompanyDetail.h"
#import "JobInformation.h"

@interface RecommendViewCell ()

@property (strong, nonatomic) UIImageView           *backgroundImageView;
@property (strong, nonatomic) UIView                *detailView;

@end

@implementation RecommendViewCell

@synthesize progressBar;
@synthesize selectStatus;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setCellSubviewFrame];
    }
    return self;
}

- (void)setCellSubviewFrame
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    _detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, appFrame.size.width, RecommendViewCellHeight)];
    [_detailView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_detailView];
        
    selectStatus = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [selectStatus setCenter:CGPointMake(20, RecommendViewCellHeight/2)];
    [selectStatus setImage:imageNameAndType(@"recommend_item_normal", @"png")];
    [selectStatus setHighlightedImage:imageNameAndType(@"recommend_item_select", @"png")];
    [self.detailView addSubview:selectStatus];

    _leftItem = [CustomButton buttonWithType:UIButtonTypeCustom];
    [_leftItem setFrame:CGRectMake(0, 0, RecommendViewCellHeight, RecommendViewCellHeight)];
    [_leftItem setCenter:selectStatus.center];
    [_leftItem setBackgroundColor:color(clearColor)];
    [self.contentView addSubview:_leftItem];
    
    _leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(controlXLength(selectStatus), 0, RecommendViewCellHeight, RecommendViewCellHeight)];
    [_leftImage setBounds:CGRectMake(0, 0, _leftItem.frame.size.width * 0.7, _leftItem.frame.size.height * 0.7)];
    [_leftImage setBackgroundColor:color(clearColor)];
    [self.contentView addSubview:_leftImage];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(controlXLength(_leftImage), 10, appFrame.size.width - controlXLength(_leftImage) - 10, (RecommendViewCellHeight - 20)*2/3)];
    [_titleLabel setBackgroundColor:color(clearColor)];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [self.contentView addSubview:_titleLabel];
    
    _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.frame.origin.x, controlYLength(_titleLabel), _titleLabel.frame.size.width, _titleLabel.frame.size.height)];
    [_detailLabel setBackgroundColor:color(clearColor)];
    [_detailLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [self.contentView addSubview:_detailLabel];
    
    UIImageView *locationLeftImage = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.frame.origin.x, controlYLength(_titleLabel), 15, 15)];
    [locationLeftImage setImage:imageNameAndType(@"resume_location", @"png")];
    [self.contentView addSubview:locationLeftImage];
    
    _locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(controlXLength(locationLeftImage), controlYLength(_titleLabel), _titleLabel.frame.size.width - locationLeftImage.frame.size.width, _titleLabel.frame.size.height/2)];
    [_locationLabel setBackgroundColor:color(clearColor)];
    [_locationLabel setFont:[UIFont systemFontOfSize:11]];
    [_locationLabel setTextColor:color(darkGrayColor)];
    [self.contentView addSubview:_locationLabel];
    
    progressBar = [[UIImageView alloc]initWithFrame:CGRectMake(appFrame.size.width - 85 - 5, RecommendViewCellHeight - 15 - 5, 85, 15)];
    [progressBar setBackgroundColor:[UIColor clearColor]];
    [progressBar setImage:imageNameAndType(@"recommend_compatibility", @"png")];
    [self.detailView addSubview:progressBar];
    
    _salaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, progressBar.frame.size.width, 20)];
    [_salaryLabel setBackgroundColor:color(clearColor)];
    [_salaryLabel setCenter:CGPointMake(progressBar.center.x, progressBar.frame.origin.y - _salaryLabel.frame.size.height/2 + 5)];
    [_salaryLabel setTextAlignment:NSTextAlignmentCenter];
    [_salaryLabel setFont:[UIFont systemFontOfSize:12]];
    [_salaryLabel setAdjustsFontSizeToFitWidth:YES];
    [_salaryLabel setAdjustsLetterSpacingToFitWidth:YES];
    [_salaryLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    [_salaryLabel setMinimumScaleFactor:0.5];
    [self.detailView addSubview:_salaryLabel];

}

- (void)setBackgroundImage:(UIImage*)image
{
    if (image) {
        if (!_backgroundImageView) {
            _backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, appFrame.size.width, RecommendViewCellHeight + 1)];
            [_backgroundImageView setBackgroundColor:[UIColor clearColor]];
            if (_detailView) {
                [self.contentView insertSubview:_backgroundImageView belowSubview:_detailView];
            }else
                [self.contentView addSubview:_backgroundImageView];
        }
        [_backgroundImageView setImage:image];
    }else{
        if (_backgroundImageView && _backgroundImageView.superview) {
            [_backgroundImageView removeFromSuperview];
        }
    }
}


@end

@interface RecommendViewController ()

@end

@implementation RecommendViewController

@synthesize dataSource;
@synthesize theTableView;
@synthesize scrollView;

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
        self.dataSource = [NSMutableArray arrayWithArray:[JobInformation getRecommendDataWithNum:10]];
        [self setSubviewFrame];
    }
    return self;
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 301) {
        switch (buttonIndex) {
            case 1:{
                [[Model shareModel] showPromptText:@"分享到腾讯微博成功" model:YES];
                break;
            }case 2:{
                [[Model shareModel] showPromptText:@"分享到新浪微博成功" model:YES];
                break;
            }
            default:
                break;
        }
    }
}

#pragma mark - table view handle
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RecommendViewCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierStr = @"cell";
    RecommendViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierStr];
    if (cell == nil) {
        cell = [[RecommendViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierStr];
    }
    JobInformation *jobDetail = [dataSource objectAtIndex:indexPath.row];
    [cell.leftImage setImage:imageNameAndType(jobDetail.jobIcon, nil)];
    [cell.leftItem setIndexPath:indexPath];
    [cell.leftItem addTarget:self action:@selector(pressCellLeftItem:) forControlEvents:UIControlEventTouchUpInside];
    NSString *text = [NSString stringWithFormat:@"%@: %@",jobDetail.company,jobDetail.position];
    [cell.titleLabel setText:text];
    [cell.locationLabel setText:jobDetail.location];
    NSInteger microNum = arc4random()%100;
    microNum = microNum - microNum%10 + 10;
    
    NSInteger largeNum = arc4random()%50;
    largeNum = largeNum - largeNum%10 + microNum;
    [cell.salaryLabel setText:[NSString stringWithFormat:@"%dW - %dW",microNum,largeNum]];
    //[cell setBackgroundImage:imageNameAndType(@"information_textbackimage", nil)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobInformation *jobDetail = [dataSource objectAtIndex:indexPath.row];
    JobDetailViewController *informationDetail = [[JobDetailViewController alloc]initWithDetail:jobDetail];
    [self pushViewController:informationDetail transitionType:TransitionPush completionHandler:nil];
}

- (void)pressCellLeftItem:(CustomButton*)sender
{
    RecommendViewCell *cell = (RecommendViewCell*)[theTableView cellForRowAtIndexPath:sender.indexPath];
    cell.selectStatus.highlighted = cell.selectStatus.highlighted?NO:YES;
}

#pragma mark - view init
- (void)setSubviewFrame
{
    [self setBackGroundImage:imageNameAndType(@"classify_backimage", @"png")];
    [self setTitle:@"精选职位"];
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, controlYLength(self.topBar), appFrame.size.width, 145)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [scrollView setBounces:NO];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setPagingEnabled:YES];
    
    NSArray *array = @[@"recommend_show1",@"recommend_show2"];
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width * [array count], scrollView.frame.size.height)];
    for (int i = 0;i<[array count];i++) {
        NSString *imageName = [array objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(scrollView.frame.size.width * i, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        [imageView setBackgroundColor:[UIColor clearColor]];
        [imageView setImage:imageNameAndType(imageName, @"png")];
        [scrollView addSubview:imageView];
    }
    [self.view addSubview:scrollView];
    
    theTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, controlYLength(scrollView), appFrame.size.width, appFrame.size.height - controlYLength(scrollView))];
    [theTableView setDelegate:self];
    [theTableView setDataSource:self];
    [theTableView setBackgroundColor:[UIColor whiteColor]];
    [theTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.view addSubview:theTableView];
    
    [self createTheBottomBar];
}

- (void)createTheBottomBar
{
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
    [homeButton setImage:imageNameAndType(@"returnhome_normal", @"png") forState:UIControlStateNormal];
    [homeButton setImage:imageNameAndType(@"returnhome_press", @"png") forState:UIControlStateHighlighted];
    [self setPopToMainViewButton:homeButton];
    
    [self setBottomBarBackGroundImage:imageNameAndType(@"bottombar", @"png")];
    [self setBottomBarItems:@[collectButton,deliverButton,shareButton,homeButton]];
    
    [collectButton  addTarget:self action:@selector(pressBottomBarItem:) forControlEvents:UIControlEventTouchUpInside];
    [deliverButton  addTarget:self action:@selector(pressBottomBarItem:) forControlEvents:UIControlEventTouchUpInside];
    [shareButton    addTarget:self action:@selector(pressBottomBarItem:) forControlEvents:UIControlEventTouchUpInside];
    
    [NSTimer scheduledTimerWithTimeInterval:2.50f target:self selector:@selector(playImage:) userInfo:nil repeats:YES];
}

- (void)pressReturnButton:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)playImage:(NSTimer*)timer
{
    CGPoint point = CGPointMake(scrollView.contentOffset.x + scrollView.frame.size.width, scrollView.contentOffset.y);
    if (point.x >= scrollView.contentSize.width) {
        point.x = 0;
    }
    [scrollView setContentOffset:point animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    CGPoint point = CGPointMake(0, scrollView.contentOffset.y);
    [scrollView setContentOffset:point animated:NO];
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
