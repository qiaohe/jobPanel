//
//  MyGrowingViewController.m
//  Recruitment
//
//  Created by M J on 13-10-14.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "MyGrowingViewController.h"
#import "GrowingDetailViewController.h"

@interface MyGrowingViewController ()

@end

@implementation MyGrowingViewController

@synthesize searchBar;
@synthesize theTableView;
@synthesize dataSource;
@synthesize subDataSource;

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
        self.dataSource = [NSMutableArray arrayWithArray:@[@"grow_item1",@"grow_item2",@"grow_item1"]];
        self.subDataSource = [NSMutableArray arrayWithArray:@[@"grow_item2",@"grow_item1",@"grow_item2"]];
        [self setSubviewFrame];
    }
    return self;
}

- (void)pressBottomBarItem:(UIButton*)sender
{
    switch (sender.tag) {
        case 101:{
            
            break;
        }case 102:{
            
            break;
        }
        default:
            break;
    }
}

#pragma mark - table view handle
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self createHeaderView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return MyGrowingHeaderViewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MyGrowingCellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"number of lines = %u",[dataSource count]/2 + (([dataSource count]%2 != 0)?1:0));
    if (section == 0) {
        return [dataSource count]/2 + (([dataSource count]%2 != 0)?1:0);
    }else if (section == 1){
        return [subDataSource count]/2 + (([subDataSource count]%2 != 0)?1:0);
    }else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierString = @"cell";
    MyGrowingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString];
    if (cell == nil) {
        cell = [[MyGrowingViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierString];
    }
    if (indexPath.section == 0) {
        [cell createSubviewWithParams:dataSource indexPath:indexPath];
    }else if (indexPath.section == 1){
        [cell createSubviewWithParams:subDataSource indexPath:indexPath];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self clearKeyBoard]) {
        
    }
}

- (UIView*)createHeaderView
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, MyGrowingHeaderViewHeight)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *cellBackImage = [[UIImageView alloc]initWithFrame:headerView.frame];
    [cellBackImage setBackgroundColor:color(clearColor)];
    [cellBackImage setImage:imageNameAndType(@"growing_celltitle", @"png")];
    [headerView addSubview:cellBackImage];
    /**
    UIImageView *topLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 5)];
    [topLine setBackgroundColor:color(clearColor)];
    [topLine setImage:imageNameAndType(@"growing_line", @"png")];
    [headerView addSubview:topLine];
    
    UIImageView *bottomLine = [[UIImageView alloc]initWithFrame:CGRectMake(topLine.frame.origin.x, headerView.frame.size.height - topLine.frame.size.height, topLine.frame.size.width, topLine.frame.size.height)];
    [bottomLine setBackgroundColor:color(clearColor)];
    [bottomLine setImage:imageNameAndType(@"growing_line", @"png")];
    [headerView addSubview:bottomLine];*/
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height)];
    [titleLabel setBackgroundColor:color(clearColor)];
    [titleLabel setTag:101];
    [titleLabel setText:[Utils stringWithDate:[NSDate date] withFormat:@"yyyy年MM月"]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:color(darkGrayColor)];
    [titleLabel setFont:[UIFont systemFontOfSize:13]];
    [headerView addSubview:titleLabel];
    
    return headerView;
}

#pragma mark - view init
- (void)setSubviewFrame
{
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setTitle:@"我的成长"];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [returnButton addTarget:self action:@selector(pressReturnButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setBackgroundColor:color(clearColor)];
    [rightButton setFrame:CGRectMake(self.view.frame.size.width - 40 - 5, returnButton.frame.origin.y, returnButton.frame.size.width, returnButton.frame.size.height)];
    [rightButton setImage:imageNameAndType(@"growing_add_normal", @"png") forState:UIControlStateNormal];
    [rightButton setImage:imageNameAndType(@"growing_add_press", @"png") forState:UIControlStateNormal];
    [rightButton setImage:imageNameAndType(@"growing_add_press", @"png") forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(pressRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    
    UIImageView *searchBarBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, controlYLength(self.topBar), self.view.frame.size.width, 35)];
    [searchBarBackImage setBackgroundColor:color(clearColor)];
    [searchBarBackImage setImage:imageNameAndType(@"searchBar", @"png")];
    [self.contentView addSubview:searchBarBackImage];
    
    self.searchBar = [[UITextField alloc]initWithFrame:searchBarBackImage.frame];
    [searchBar setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [searchBar setPlaceholder:@"Search"];
    [searchBar setFont:[UIFont systemFontOfSize:13]];
    UIButton *leftView = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftView setBackgroundColor:[UIColor clearColor]];
    [leftView setFrame:CGRectMake(0, 0, 50, searchBar.frame.size.height)];
    [leftView setEnabled:NO];
    [searchBar setLeftView:leftView];
    [searchBar setDelegate:self];
    [searchBar setReturnKeyType:UIReturnKeySearch];
    [searchBar setLeftViewMode:UITextFieldViewModeAlways];
    [self.contentView addSubview:searchBar];
    
    UIImageView *detailImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, controlYLength(searchBar) - 3, self.view.frame.size.width, self.view.frame.size.height - controlYLength(searchBar))];
    [detailImageView setBackgroundColor:[UIColor clearColor]];
    [detailImageView setImage:imageNameAndType(@"growing_backimage", @"png")];
    [self.contentView addSubview:detailImageView];
    
    theTableView = [[UITableView alloc]initWithFrame:CGRectMake(detailImageView.frame.origin.x, detailImageView.frame.origin.y, detailImageView.frame.size.width, detailImageView.frame.size.height - 10)];
    [theTableView setBackgroundColor:color(clearColor)];
    [theTableView setDelegate:self];
    [theTableView setDataSource:self];
    [theTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.contentView addSubview:theTableView];
    
    [self createTheBottomBar];
}

- (void)createTheBottomBar
{
    [self setBottomBarBackGroundImage:imageNameAndType(@"bottombar", @"png")];
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeButton setBackgroundColor:color(clearColor)];
    [homeButton setTag:101];
    [homeButton setImage:imageNameAndType(@"returnhome_normal", @"png") forState:UIControlStateNormal];
    [homeButton setImage:imageNameAndType(@"returnhome_press", @"png") forState:UIControlStateHighlighted];
    [self setPopToMainViewButton:homeButton];
    [self setBottomBarItems:@[homeButton]];
    
}

- (void)pressReturnButton:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pressRightButton:(UIButton*)sender
{
    GrowingDetailViewController *growingDetailView = [[GrowingDetailViewController alloc]init];
    if (self.navigationController) {
        [self.navigationController pushViewController:growingDetailView animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (BOOL)clearKeyBoard
{
    BOOL canResignFirstResponder = NO;
    if ([searchBar isFirstResponder]) {
        [searchBar resignFirstResponder];
        canResignFirstResponder = YES;
    }
    return canResignFirstResponder;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@interface MyGrowingViewCell ()

@end

@implementation MyGrowingViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)createSubviewWithParams:(NSArray*)params indexPath:(NSIndexPath*)indexPath
{
    if ([params count] >= indexPath.row * 2 + 1) {
        if (!_cellItem1) {
            NSString *imageName = [params objectAtIndex:indexPath.row * 2];
            UIView *subview = [self createSubview];
            subview.frame = CGRectMake(0, 0, subview.frame.size.width, subview.frame.size.height);
            UIImageView *detailImage = (UIImageView*)[subview viewWithTag:102];
            [detailImage setImage:imageNameAndType(imageName, @"jpg")];
            _cellItem1 = subview;
        }
        if (!_cellItem1.superview) {
            [self.contentView addSubview:_cellItem1];
        }
    }else{
        if (_cellItem1.superview) {
            [_cellItem1 removeFromSuperview];
        }
    }
    if ([params count] >= indexPath.row * 2 + 2){
        if (!_cellItem2) {
            NSString *imageName = [params objectAtIndex:indexPath.row * 2 + 1];
            UIView *subview = [self createSubview];
            subview.frame = CGRectMake(controlXLength(_cellItem1), 0, subview.frame.size.width, subview.frame.size.height);
            UIImageView *detailImage = (UIImageView*)[subview viewWithTag:102];
            [detailImage setImage:imageNameAndType(imageName, @"jpg")];
            _cellItem2 = subview;
        }
        if (!_cellItem2.superview) {
            [self.contentView addSubview:_cellItem2];
        }
    }else{
        if (_cellItem2.superview) {
            [_cellItem2 removeFromSuperview];
        }
    }
}

- (UIView*)createSubview
{
    UIView *subview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, appFrame.size.width/2, appFrame.size.width/2)];
    [subview setBackgroundColor:color(clearColor)];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, subview.frame.size.width, subview.frame.size.height - 10)];
    [backImage setBackgroundColor:color(clearColor)];
    [backImage setImage:imageNameAndType(@"growing_item", @"png")];
    [subview addSubview:backImage];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, backImage.frame.size.width - 30, 30)];
    [titleLabel setBackgroundColor:color(clearColor)];
    [titleLabel setText:[Utils stringWithDate:[NSDate date] withFormat:@"yyyy年MM月  我的成长"]];
    [titleLabel setAdjustsFontSizeToFitWidth:YES];
    [titleLabel setAdjustsLetterSpacingToFitWidth:YES];
    [titleLabel setBaselineAdjustment:UIBaselineAdjustmentNone];
    [titleLabel setFont:[UIFont systemFontOfSize:14]];
    [titleLabel setMinimumScaleFactor:0.3];
    [titleLabel setTag:101];
    [subview addSubview:titleLabel];
    
    UIImageView *detailImage = [[UIImageView alloc]initWithFrame:CGRectMake(titleLabel.frame.origin.x, controlYLength(titleLabel), titleLabel.frame.size.width, subview.frame.size.height*2/5)];
    [detailImage setBackgroundColor:color(clearColor)];
    [detailImage setTag:102];
    [subview addSubview:detailImage];
    
    return subview;
}

@end

