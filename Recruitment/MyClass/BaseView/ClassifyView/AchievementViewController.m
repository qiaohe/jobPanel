//
//  AchievementViewController.m
//  Recruitment
//
//  Created by M J on 13-11-5.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "AchievementViewController.h"
#import "GrowingDetailViewController.h"
#import "MyGrowing.h"

@interface AchievementViewController ()

@end

@implementation AchievementViewController

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
        _dataSource = [NSMutableArray arrayWithArray:[MyGrowing getMyGrowsWithNum:5]];
        [self setSubviewFrame];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AchievementViewCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierStr = @"cell";
    AchievementViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierStr];
    if (cell == nil) {
        cell = [[AchievementViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierStr];
        [cell.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [cell.titleLabel setTextColor:UIColorFromRGB(0x0ca7bc)];
        
        [cell.detailLabel setFont:[UIFont systemFontOfSize:13]];
        [cell.detailLabel setTextColor:color(darkGrayColor)];
    }
    MyGrowing *growing = [_dataSource objectAtIndex:indexPath.row];
    
    [cell setLeftImage:growing.image];
    [cell.titleLabel setText:growing.title];
    [cell.detailLabel setText:growing.detail];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyGrowing *growing = [_dataSource objectAtIndex:indexPath.row];
    GrowingDetailViewController *growingDetailView = [[GrowingDetailViewController alloc]initWithGrowDetail:growing];
    [self pushViewController:growingDetailView transitionType:TransitionPush completionHandler:nil];
}

#pragma mark - view init
- (void)setSubviewFrame
{
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setTitle:@"成就和作品"];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    _theTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, controlYLength(self.topBar), self.view.frame.size.width, self.view.frame.size.height - controlYLength(self.topBar))];
    [_theTableView setBackgroundColor:color(clearColor)];
    [_theTableView setDelegate:self];
    [_theTableView setDataSource:self];
    [self.contentView addSubview:_theTableView];
    
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

@interface AchievementViewCell ()

@property (strong, nonatomic) UIImageView           *leftImageView;

@end

@implementation AchievementViewCell

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
    
    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, appFrame.size.width * 2/5, AchievementViewCellHeight - 10)];
    [_leftImageView setContentMode:UIViewContentModeScaleAspectFit];
    [_leftImageView setBackgroundColor:color(clearColor)];
    [self.contentView addSubview:_leftImageView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(controlXLength(_leftImageView) + 15, _leftImageView.frame.origin.y, self.frame.size.width - controlXLength(_leftImageView) - 15 - 10, 25)];
    [_titleLabel setBackgroundColor:color(clearColor)];
    [self.contentView addSubview:_titleLabel];
    
    _detailLabel = [[UITextView alloc]initWithFrame:CGRectMake(_titleLabel.frame.origin.x - 8, controlYLength(_titleLabel), _titleLabel.frame.size.width + 8, AchievementViewCellHeight - controlYLength(_titleLabel) - _leftImageView.frame.origin.y)];
    [_detailLabel setBackgroundColor:color(clearColor)];
    [_detailLabel setEditable:NO];
    [self.contentView addSubview:_detailLabel];
}

- (void)setLeftImage:(UIImage*)image
{
    [_leftImageView setImage:image];
}

@end





