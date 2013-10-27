//
//  MyGrowingViewController.m
//  Recruitment
//
//  Created by M J on 13-10-14.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "MyGrowingViewController.h"
#import "CustomLongPressGestureRecognizer.h"
#import "CustomAlertView.h"
#import "MyGrowing.h"
#import "CustomButton.h"

@interface MyGrowingViewController ()

@property (assign, nonatomic) BOOL          alertShow;

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
        _alertShow = NO;
        
        subDataSource = [NSMutableDictionary dictionaryWithDictionary:[self getGrowingDataFromArray:[MyGrowing getMyGrowsWithNum:12]]];
        
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

- (void)pressCellItem:(CustomButton*)sender
{
    NSLog(@"press item");
    if (![self clearKeyBoard]) {
        NSArray *array = [subDataSource objectForKey:[dataSource objectAtIndex:sender.indexPath.section]];
        MyGrowing *growDetail = [array objectAtIndex:sender.indexPath.row];
        GrowingDetailViewController *growingDetailView = [[GrowingDetailViewController alloc]initWithGrowDetail:growDetail];
        growingDetailView.delegate = self;
        [self.navigationController pushViewController:growingDetailView animated:YES];
    }
}

- (void)longPress:(CustomLongPressGestureRecognizer*)longPress
{
    if (!_alertShow) {
        _alertShow = YES;
        CustomAlertView *alertView = [[CustomAlertView alloc]initWithTitle:nil message:@"删除内容?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView setTag:102];
        [alertView setIndexPath:longPress.indexPath];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    _alertShow = NO;
    if (alertView.tag == 102) {
        switch (buttonIndex) {
            case 1:{
                CustomAlertView *customAlert = (CustomAlertView*)alertView;
                NSMutableArray *array = [subDataSource objectForKey:[dataSource objectAtIndex:customAlert.indexPath.section]];
                if ([array count] > customAlert.indexPath.row) {
                    [array removeObjectAtIndex:customAlert.indexPath.row];
                }
                if ([array count] == 0) {
                    [dataSource removeObjectAtIndex:customAlert.indexPath.section];
                }
                [theTableView reloadData];
                break;
            }
            default:
                break;
        }
    }
}

#pragma mark - table view handle
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *titleView   = [self createHeaderView];
    UILabel *titleLabel = (UILabel*)[titleView viewWithTag:101];
    NSString *key = [dataSource objectAtIndex:section];
    [titleLabel setText:key];
    return titleView;
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
    return [dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [subDataSource objectForKey:[dataSource objectAtIndex:section]];
    return [array count]/2 + (([array count]%2 != 0)?1:0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierString = @"cell";
    MyGrowingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString];
    if (cell == nil) {
        cell = [[MyGrowingViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierString];
    }
    NSArray *array = [subDataSource objectForKey:[dataSource objectAtIndex:indexPath.section]];
    [cell createSubviewWithParams:array indexPath:indexPath];
    CustomButton *button1 = (CustomButton*)cell.cellItem1;
    [button1 addTarget:self action:@selector(pressCellItem:) forControlEvents:UIControlEventTouchUpInside];
    CustomLongPressGestureRecognizer *longPress1 = [[CustomLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [longPress1 setMinimumPressDuration:1.0f];
    [longPress1 setDelegate:self];
    [longPress1 setIndexPath:button1.indexPath];
    [button1 addGestureRecognizer:longPress1];
    if (cell.cellItem2) {
        CustomButton *button2 = (CustomButton*)cell.cellItem2;
        [button2 addTarget:self action:@selector(pressCellItem:) forControlEvents:UIControlEventTouchUpInside];
        CustomLongPressGestureRecognizer *longPress2 = [[CustomLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [longPress2 setMinimumPressDuration:1.0f];
        [longPress2 setDelegate:self];
        [longPress2 setIndexPath:button2.indexPath];
        [button2 addGestureRecognizer:longPress2];
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
    [titleLabel setTextColor:color(grayColor)];
    [titleLabel setFont:[UIFont systemFontOfSize:12]];
    [headerView addSubview:titleLabel];
    
    return headerView;
}

- (NSDictionary*)getGrowingDataFromArray:(NSArray*)array
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (MyGrowing *growing in array) {
        NSString *key = [Utils stringWithDate:[Utils dateWithString:growing.date withFormat:@"yyyy年MM月dd日 / HH:mm"] withFormat:@"yyyy年MM月"];
        if ([dictionary.allKeys containsObject:key]) {
            NSMutableArray *array = [dictionary objectForKey:key];
            [array addObject:growing];
        }else{
            NSMutableArray *array = [NSMutableArray array];
            [array addObject:growing];
            [dictionary setObject:array forKey:key];
        }
    }
    dataSource = [NSMutableArray arrayWithArray:dictionary.allKeys];
    [self sortArray:dataSource];
    return dictionary;
}

- (void)sortArray:(NSMutableArray*)array
{
    [array sortUsingComparator:^(NSString *growDate1,NSString *growDate2){
        double date1 = [[Utils dateWithString:growDate1 withFormat:@"yyyy年MM月"] timeIntervalSince1970];
        double date2 = [[Utils dateWithString:growDate2 withFormat:@"yyyy年MM月"] timeIntervalSince1970];
        if (date1 >= date2) {
            return NSOrderedDescending;
        }else{
            return NSOrderedAscending;
        }
    }];
}

#pragma mark - Growing delegate method
- (void)reloadWithData:(NSArray*)data
{
    if (data) {
        subDataSource = [NSMutableDictionary dictionaryWithDictionary:[self getGrowingDataFromArray:data]];
    }
    
    [self.theTableView reloadData];
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
    GrowingDetailViewController *growingDetailView = [[GrowingDetailViewController alloc]initWithData:subDataSource];
    growingDetailView.delegate = self;
    if (self.navigationController) {
        [self.navigationController pushViewController:growingDetailView animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }
    
    if (textField == searchBar) {
        [self searchGrowNote];
    }
    
    return YES;
}

- (void)searchGrowNote
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[subDataSource allValues]];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSArray *object in array) {
        [tempArray addObjectsFromArray:object];
    }
    
    if (![Utils textIsEmpty:searchBar.text]) {

        
        if ([dataSource count] != 0) {
            [dataSource removeAllObjects];
        }
        
        for (MyGrowing *grow in tempArray) {
            NSLog(@"title = %@",grow.title);
            if ([grow.title rangeOfString:searchBar.text].length != 0 || [grow.date rangeOfString:searchBar.text].length != 0) {
                [dataSource addObject:grow];
            }
        }
        for (MyGrowing *grow in dataSource) {
            NSLog(@"data title = %@",grow.title);
        }
        
        [self getGrowingDataFromArray:dataSource];
        [self.theTableView reloadData];
    }else{
        [[Model shareModel] showPromptText:@"搜索条件为空" model:YES];
        [self getGrowingDataFromArray:tempArray];
        [self.theTableView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[Model shareModel] showPromptText:@"长按删除成长内容" model:YES];
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
            CustomButton *subview = [self createSubview];

            _cellItem1 = subview;
        }
        _cellItem1.frame = CGRectMake(0, 0, _cellItem1.frame.size.width, _cellItem1.frame.size.height);

        MyGrowing *grow = [params objectAtIndex:indexPath.row * 2 + 0];
        UILabel     *titleLabel  = (UILabel*)[_cellItem1 viewWithTag:101];
        UIImageView *detailImage = (UIImageView*)[_cellItem1 viewWithTag:102];
        
        NSString *titleText = @"";
        titleText = grow.date?[titleText stringByAppendingString:[Utils stringWithDate:[Utils dateWithString:grow.date withFormat:@"yyyy年MM月dd日 / HH:mm"] withFormat:@"yyyy年MM月dd日"]]:titleText;
        titleText = grow.title?(titleText?[titleText stringByAppendingFormat:@" %@",grow.title]:[titleText stringByAppendingString:grow.title]):titleText;
        
        [titleLabel setText:titleText];
        [detailImage setImage:grow.image];
        
        _cellItem1.indexPath = [NSIndexPath indexPathForRow:indexPath.row * 2 + 0 inSection:indexPath.section];
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
            CustomButton *subview = [self createSubview];

            _cellItem2 = subview;
        }
        _cellItem2.frame = CGRectMake(controlXLength(_cellItem1), 0, _cellItem2.frame.size.width, _cellItem2.frame.size.height);

        MyGrowing *grow = [params objectAtIndex:indexPath.row * 2 + 1];
        UILabel     *titleLabel  = (UILabel*)[_cellItem2 viewWithTag:101];
        UIImageView *detailImage = (UIImageView*)[_cellItem2 viewWithTag:102];
        
        NSString *titleText = @"";
        titleText = grow.date?[titleText stringByAppendingString:[Utils stringWithDate:[Utils dateWithString:grow.date withFormat:@"yyyy年MM月dd日 / HH:mm"] withFormat:@"yyyy年MM月dd日"]]:titleText;
        titleText = grow.title?(titleText?[titleText stringByAppendingFormat:@" %@",grow.title]:[titleText stringByAppendingString:grow.title]):titleText;
        
        [titleLabel setText:titleText];
        [detailImage setImage:grow.image];
        
        _cellItem2.indexPath = [NSIndexPath indexPathForRow:indexPath.row * 2 + 1 inSection:indexPath.section];
        if (!_cellItem2.superview) {
            [self.contentView addSubview:_cellItem2];
        }
    }else{
        if (_cellItem2.superview) {
            [_cellItem2 removeFromSuperview];
        }
    }
}

- (CustomButton*)createSubview
{
    CustomButton *subview = [CustomButton buttonWithType:UIButtonTypeCustom];
    [subview setFrame:CGRectMake(0, 0, appFrame.size.width/2, appFrame.size.width/2)];
    [subview setBackgroundColor:color(clearColor)];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, subview.frame.size.width - 10, subview.frame.size.height - 10)];
    [backImage setBackgroundColor:color(clearColor)];
    [backImage setImage:imageNameAndType(@"growing_item", @"png")];
    [subview addSubview:backImage];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, backImage.frame.size.width - 30, 30)];
    [titleLabel setBackgroundColor:color(clearColor)];
    //[titleLabel setText:[Utils stringWithDate:[NSDate date] withFormat:@"yyyy年MM月  我的成长"]];
    [titleLabel setAdjustsFontSizeToFitWidth:YES];
    [titleLabel setAdjustsLetterSpacingToFitWidth:YES];
    [titleLabel setBaselineAdjustment:UIBaselineAdjustmentNone];
    [titleLabel setFont:[UIFont systemFontOfSize:14]];
    [titleLabel setMinimumScaleFactor:0.3];
    [titleLabel setTag:101];
    [subview addSubview:titleLabel];
    
    UIImageView *detailImage = [[UIImageView alloc]initWithFrame:CGRectMake(titleLabel.frame.origin.x + 1.0f, controlYLength(titleLabel), titleLabel.frame.size.width+ 3.0f, subview.frame.size.height*2/5)];
    [detailImage setBackgroundColor:color(clearColor)];
    [detailImage setTag:102];
    [subview addSubview:detailImage];
    
    return subview;
}

@end

