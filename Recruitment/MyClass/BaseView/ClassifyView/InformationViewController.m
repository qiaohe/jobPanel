//
//  InformationViewController.m
//  Recruitment
//
//  Created by M J on 13-10-16.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "InformationViewController.h"
#import "ContactsStatusViewController.h"
#import "InformationDetailViewController.h"
#import "JobInformation.h"

static      NSMutableArray          *cellSource;

@interface InformationViewController ()

@property (assign, nonatomic) InformationType       type;

@end

@implementation InformationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithType:(InformationType)type
{
    self = [super init];
    if (self) {
        cellSource = [NSMutableArray arrayWithArray:[JobInformation getCommentDataWithNum:7]];
        self.dataSource = cellSource;
        _type = type;
        
        [self setSubviewFrame];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        cellSource = [NSMutableArray arrayWithArray:[JobInformation getCommentDataWithNum:7]];
        self.dataSource = cellSource;
        
        [self setSubviewFrame];
    }
    return self;
}

- (void)setSubviewFrame
{
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setBackGroundImage:imageNameAndType(@"subview_backimage", @"png")];
    [self setTitle:@"行业资讯"];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    if (_type == InformationOpportunityPage) {
        [self setTitle:@"关注机遇"];
        UIImageView *searchBarBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, controlYLength(self.topBar), self.view.frame.size.width, 35)];
        [searchBarBackImage setBackgroundColor:color(clearColor)];
        [searchBarBackImage setImage:imageNameAndType(@"searchBar", @"png")];
        [self.contentView addSubview:searchBarBackImage];
        
        _searchBar = [[UITextField alloc]initWithFrame:searchBarBackImage.frame];
        [_searchBar setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_searchBar setPlaceholder:@"Search"];
        [_searchBar setDelegate:self];
        [_searchBar setFont:[UIFont systemFontOfSize:13]];
        UIButton *leftView = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftView setBackgroundColor:[UIColor clearColor]];
        [leftView setFrame:CGRectMake(0, 0, 50, _searchBar.frame.size.height)];
        [leftView setEnabled:NO];
        [_searchBar setLeftView:leftView];
        [_searchBar setDelegate:self];
        [_searchBar setReturnKeyType:UIReturnKeySearch];
        [_searchBar setLeftViewMode:UITextFieldViewModeAlways];
        [self.contentView addSubview:_searchBar];
    }else if (_type == Informationcollect){
        [self setTitle:@"收藏职位"];
    }
    
    _theTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _searchBar?controlYLength(_searchBar):controlYLength(self.topBar), self.view.frame.size.width, self.view.frame.size.height - controlYLength(self.topBar))];
    [_theTableView setBackgroundColor:color(whiteColor)];
    [_theTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_theTableView setDelegate:self];
    [_theTableView setDataSource:self];
    [self.contentView addSubview:_theTableView];
    
    if (_type == Informationcollect) {
        UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [homeButton setBackgroundColor:color(clearColor)];
        [homeButton setTag:102];
        [homeButton setImage:imageNameAndType(@"returnhome_normal", @"png") forState:UIControlStateNormal];
        [homeButton setImage:imageNameAndType(@"returnhome_press", @"png") forState:UIControlStateHighlighted];
        [self setPopToMainViewButton:homeButton];
        [self setBottomBarItems:@[homeButton]];
        [self setBottomBarBackGroundImage:imageNameAndType(@"bottombar", @"png")];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ContactsStatusCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierString = @"cell";
    ContactsStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString];
    if (cell == nil) {
        cell = [[ContactsStatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierString];
    }
    JobInformation *jobDetail = [_dataSource objectAtIndex:indexPath.row];
    [cell.leftImage setImage:imageNameAndType(jobDetail.jobIcon, nil)];
    NSString *text = [jobDetail.jobArray componentsJoinedByString:@"+"];
    text = jobDetail.title?[NSString stringWithFormat:@"%@:%@",jobDetail.title,text]:text;
    [cell.titleLabel setText:text];
    [cell.detailLabel setText:jobDetail.detail];
    [cell.locationLabel setText:jobDetail.location];
    [cell setBackGroundImage:imageNameAndType(@"information_backimage", nil)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self clearKeyBoard]) {
        InformationDetailViewController *informationDetail = [[InformationDetailViewController alloc]init];
        [self.navigationController pushViewController:informationDetail animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }
    
    if (textField == _searchBar) {
        [self searchInformation];
    }
    
    return YES;
}

- (void)searchInformation
{
    if (![Utils textIsEmpty:_searchBar.text]) {
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (JobInformation *information in cellSource) {
            NSString *searchText = information.title?information.title:@"";
            searchText = [searchText stringByAppendingString:([information.jobArray componentsJoinedByString:@" "]?[information.jobArray componentsJoinedByString:@" "]:@"")];
            if ([[searchText uppercaseString] rangeOfString:[_searchBar.text uppercaseString]].length > 0) {
                [tempArray addObject:information];
            }
        }
        
        _dataSource = tempArray;
        
        [self.theTableView reloadData];
    }else{
        [[Model shareModel] showPromptText:@"搜索参数为空" model:YES];
        _dataSource = cellSource;
        [self.theTableView reloadData];
    }
}

- (BOOL)clearKeyBoard
{
    BOOL canResignFirstResponder = NO;
    if ([_searchBar isFirstResponder]) {
        [_searchBar resignFirstResponder];
        canResignFirstResponder = YES;
    }
    return canResignFirstResponder;
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
