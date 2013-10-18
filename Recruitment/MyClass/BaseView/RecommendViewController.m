//
//  RecommendViewController.m
//  Recruitment
//
//  Created by M J on 13-10-12.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "RecommendViewController.h"
#import "InformationViewController.h"
#import "MyResumeViewController.h"
#import "CustomButton.h"

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
        [self setSubviewFrame];
    }
    return self;
}

- (void)setSubviewFrame
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
    
    progressBar = [[UIImageView alloc]initWithFrame:CGRectMake(appFrame.size.width - 85 - 5, RecommendViewCellHeight - 15 - 5, 85, 15)];
    [progressBar setBackgroundColor:[UIColor clearColor]];
    [progressBar setImage:imageNameAndType(@"recommend_compatibility", @"png")];
    [self.detailView addSubview:progressBar];
}

- (void)setBackgroundImage:(UIImage*)image
{
    if (image) {
        if (!_backgroundImageView) {
            _backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, appFrame.size.width, RecommendViewCellHeight)];
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
        NSArray *array = @[@"classify_item1",@"classify_item2",@"classify_item3",@"classify_item1",@"classify_item2",@"classify_item3"];
        self.dataSource = [NSMutableArray arrayWithArray:array];

        [self setViewFrame];
    }
    return self;
}

- (void)pressLeftButton:(CustomButton*)sender
{
    
}

- (void)pressBottomBarItem:(UIButton*)sender
{
    switch (sender.tag) {
        case 101:{
            InformationViewController *informationView = [[InformationViewController alloc]initWithType:Informationcollect];
            [self.navigationController pushViewController:informationView animated:YES];
            break;
        }case 102:{
            MyResumeViewController *myResumeView = [[MyResumeViewController alloc]initWithType:MyResumeDeliver];
            [self.navigationController pushViewController:myResumeView animated:YES];
            break;
        }case 103:{
            
            break;
        }
        default:
            break;
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
    NSString *imageName = [dataSource objectAtIndex:indexPath.row];
    [cell setBackgroundImage:imageNameAndType(imageName, @"png")];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendViewCell *cell = (RecommendViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.selectStatus.highlighted = cell.selectStatus.highlighted?NO:YES;
}

- (void)setViewFrame
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
    [returnButton addTarget:self action:@selector(pressReturnButton:) forControlEvents:UIControlEventTouchUpInside];
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
    [theTableView setBackgroundColor:[UIColor clearColor]];
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
}

- (void)pressReturnButton:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
