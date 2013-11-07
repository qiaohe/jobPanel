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
#import "companyDetail.h"
#import "CompanyDetailViewController.h"
#import "IndustryInformation.h"

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
        if (type == InformationIndustryPage) {
            cellSource = [NSMutableArray arrayWithArray:[IndustryInformation getRecommendDataWithNum:4]];
        }else{
            cellSource = [NSMutableArray arrayWithArray:[CompanyDetail getRecommendDataWithNum:7]];
        }
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
        cellSource = [NSMutableArray arrayWithArray:[CompanyDetail getRecommendDataWithNum:7]];
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
        [self setTitle:@"机遇列表"];
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
    }else if (_type == InformationNearPage){
        [self setTitle:@"附近公司"];
    }
    
    _theTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _searchBar?controlYLength(_searchBar):controlYLength(self.topBar), self.view.frame.size.width, self.view.frame.size.height - (_searchBar?controlYLength(_searchBar):controlYLength(self.topBar)))];
    [_theTableView setBackgroundColor:color(whiteColor)];
    [_theTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
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
    if (_type == InformationIndustryPage) {
        IndustryInformation *detail = [_dataSource objectAtIndex:indexPath.row];
        [cell.leftImage setImage:imageNameAndType(detail.picture, nil)];

        [cell.titleLabel setText:detail.title];
        [cell.locationLabel setText:detail.location];
    }else{
        CompanyDetail *jobDetail = [_dataSource objectAtIndex:indexPath.row];
        NSString *text = [jobDetail.jobArray componentsJoinedByString:@"+"];
        text = jobDetail.title?[NSString stringWithFormat:@"%@:%@",jobDetail.title,text]:text;
        [cell.titleLabel setText:text];
        [cell.detailLabel setText:jobDetail.detail];
        [cell.leftImage setImage:imageNameAndType(jobDetail.companyLogo, nil)];

        if (_type == InformationNearPage) {
            [cell.locationLabel setText:[NSString stringWithFormat:@"距离%d米",arc4random()%500 + 20]];
        }else
            [cell.locationLabel setText:jobDetail.location];
    }
    
    
    //[cell setBackGroundImage:stretchImage(@"information_textbackimage", nil)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self clearKeyBoard]) {
        if (_type == InformationIndustryPage) {
            IndustryInformation *detail = [_dataSource objectAtIndex:indexPath.row];
            CompanyDetailViewController *companyDetail = [[CompanyDetailViewController alloc]initWithIndustryInformation:detail];
            [self.navigationController pushViewController:companyDetail animated:YES];
        }else{
            CompanyDetail *information = [_dataSource objectAtIndex:indexPath.row];
            InformationDetailViewController *informationDetail = [[InformationDetailViewController alloc]initWithObject:information];
            [self.navigationController pushViewController:informationDetail animated:YES];
        }
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
        
        for (CompanyDetail *information in cellSource) {
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
