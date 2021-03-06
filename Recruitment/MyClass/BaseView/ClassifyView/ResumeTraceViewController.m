//
//  ResumeTraceViewController.m
//  Recruitment
//
//  Created by M J on 13-10-18.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "ResumeTraceViewController.h"
#import "InformationViewController.h"
#import "InformationDetailViewController.h"
#import "ContactsStatusViewController.h"
#import "Contacts.h"
#import "CompanyDetail.h"

@interface ResumeTraceViewController ()

@end

@implementation ResumeTraceViewController

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
        self.dataSource = [NSMutableArray array];
        [self tabBar:_theTabBar didSelectItem:[_theTabBar.items objectAtIndex:0]];
        [self setSubviewFrame];
    }
    return self;
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
    CompanyDetail *detail = [_dataSource objectAtIndex:indexPath.row];
    [cell setBackGroundImage:imageNameAndType(@"information_textbackimage", nil)];
    [cell.leftImage setImage:imageNameAndType(detail.companyLogo, @"png")];
    NSString *text = [detail.jobArray componentsJoinedByString:@"+"];
    text = detail.title?[NSString stringWithFormat:@"%@:%@",detail.title,text]:text;
    [cell.titleLabel setText:text];
    [cell.locationLabel setText:detail.location];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompanyDetail *information = [_dataSource objectAtIndex:indexPath.row];
    InformationDetailViewController *informationDetail = [[InformationDetailViewController alloc]initWithObject:information ];
    [self.navigationController pushViewController:informationDetail animated:YES];
}

- (void)setSubviewFrame
{
    [self setBackGroundImage:imageNameAndType(@"information_backimage", @"png")];
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setTitle:@"简历追踪"];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setBackgroundColor:color(colorWithRed:219 green:219 blue:219 alpha:1)];
    [button1 setTag:100];
    [button1 setFrame:CGRectMake(0, controlYLength(self.topBar), self.contentView.frame.size.width/4, 30)];
    [button1 setBackgroundImage:imageNameAndType(@"delivery_normal", @"png") forState:UIControlStateNormal];
    [button1 setBackgroundImage:imageNameAndType(@"delivery_press", @"png") forState:UIControlStateSelected];
    //[button1 setAlpha:0.7];
    //[button1 setTitle:@"已投递" forState:UIControlStateNormal];
    [button1.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [button1 setTitleColor:color(grayColor) forState:UIControlStateNormal];
    [button1 setTitleColor:color(blackColor) forState:UIControlStateSelected];
    [self.contentView addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setBackgroundColor:color(colorWithRed:219 green:219 blue:219 alpha:1)];
    [button2 setTag:101];
    [button2 setFrame:CGRectMake(controlXLength(button1), button1.frame.origin.y, button1.frame.size.width, button1.frame.size.height)];
    [button2 setBackgroundImage:imageNameAndType(@"readed_normal", @"png") forState:UIControlStateNormal];
    [button2 setBackgroundImage:imageNameAndType(@"readed_press", @"png") forState:UIControlStateSelected];
    //[button2 setAlpha:0.7];
    //[button2 setTitle:@"已审阅" forState:UIControlStateNormal];
    [button2.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [button2 setTitleColor:color(grayColor) forState:UIControlStateNormal];
    [button2 setTitleColor:color(blackColor) forState:UIControlStateSelected];
    [self.contentView addSubview:button2];

    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setBackgroundColor:color(colorWithRed:219 green:219 blue:219 alpha:1)];
    [button3 setTag:102];
    [button3 setFrame:CGRectMake(controlXLength(button2), button1.frame.origin.y, button1.frame.size.width, button1.frame.size.height)];
    [button3 setBackgroundImage:imageNameAndType(@"reject_normal", @"png") forState:UIControlStateNormal];
    [button3 setBackgroundImage:imageNameAndType(@"reject_press", @"png") forState:UIControlStateSelected];
    //[button3 setAlpha:0.7];
    //[button3 setTitle:@"已拒绝" forState:UIControlStateNormal];
    [button3.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [button3 setTitleColor:color(grayColor) forState:UIControlStateNormal];
    [button3 setTitleColor:color(blackColor) forState:UIControlStateSelected];
    [self.contentView addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button4 setBackgroundColor:color(colorWithRed:219 green:219 blue:219 alpha:1)];
    [button4 setTag:103];
    [button4 setFrame:CGRectMake(controlXLength(button3), button1.frame.origin.y, button1.frame.size.width, button1.frame.size.height)];
    [button4 setBackgroundImage:imageNameAndType(@"notice_normal", @"png") forState:UIControlStateNormal];
    [button4 setBackgroundImage:imageNameAndType(@"notice_press", @"png") forState:UIControlStateSelected];
    //[button4 setAlpha:0.7];
    //[button4 setTitle:@"通知面试" forState:UIControlStateNormal];
    [button4.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [button4 setTitleColor:color(grayColor) forState:UIControlStateNormal];
    [button4 setTitleColor:color(blackColor) forState:UIControlStateSelected];
    [self.contentView addSubview:button4];
    
    _theTabBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, controlYLength(self.topBar), self.view.frame.size.width, button1.frame.size.height)];
    [_theTabBar setBackgroundColor:color(clearColor)];
    [_theTabBar setAlpha:0.1];
    [_theTabBar setDelegate:self];
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i<4; i++) {
        UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:nil image:nil tag:200 + i];
        [items addObject:item];
    }
    [_theTabBar setItems:items];
    [self.contentView addSubview:_theTabBar];
    
    _theTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, controlYLength(button1), self.view.frame.size.width, self.view.frame.size.height - controlYLength(button1))];
    [_theTableView setBackgroundColor:color(clearColor)];
    [_theTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    for (int i = 0; i<4; i++) {
        UIButton *button = (UIButton*)[self.contentView viewWithTag:i + 100];
        button.selected = NO;
    }
    NSInteger index = 100 + [tabBar.items indexOfObject:item];
    UIButton *button = (UIButton*)[self.contentView viewWithTag:index];
    button.selected = YES;
    
    [self loadDataWithIndex:index];
}

- (void)loadDataWithIndex:(NSInteger)_index
{
    NSInteger itemNum;
    switch (_index) {
        case 100:{
            itemNum = 3;
            break;
        }case 101:{
            itemNum = 10;
            break;
        }case 102:{
            itemNum = 5;
            break;
        }case 103:{
            itemNum = 2;
            break;
        }
        default:
            itemNum = 0;
            break;
    }
    [self.dataSource removeAllObjects];
    
    [self.dataSource addObjectsFromArray:[CompanyDetail getRecommendDataWithNum:itemNum]];
    
    [_theTableView reloadData];
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
