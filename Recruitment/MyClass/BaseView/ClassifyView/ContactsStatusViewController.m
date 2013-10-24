//
//  ContactsStatusViewController.m
//  Recruitment
//
//  Created by M J on 13-10-15.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "ContactsStatusViewController.h"
#import "Contacts.h"

static      NSMutableArray      *cellSource;

@interface ContactsStatusViewController ()

@end

@implementation ContactsStatusViewController

@synthesize searchBar;

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
        cellSource = [NSMutableArray arrayWithArray:[Contacts getContactsWithNum:7]];
        _dataSource = cellSource;
        [self setSubviewFrame];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contacts *imageName = [_dataSource objectAtIndex:indexPath.row];
    if (imageName.isUnfold) {
        return ContactsStatusCellHeight * 2;
    }else
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
    Contacts *contact = [_dataSource objectAtIndex:indexPath.row];
    NSLog(@"icon name = %@",contact.userPicture);
    [cell.leftImage setImage:imageNameAndType(contact.userPicture, nil)];
    NSString *text = [contact.jobArray componentsJoinedByString:@"+"];
    text = contact.title?[NSString stringWithFormat:@"%@:%@",contact.title,text]:text;
    [cell.titleLabel setText:text];
    [cell.locationLabel setText:contact.location];
    [cell setBackGroundImage:imageNameAndType(@"information_backimage", nil)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self clearKeyBoard]) {
        Contacts *imageName = [_dataSource objectAtIndex:indexPath.row];
        imageName.isUnfold = imageName.isUnfold?NO:YES;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)setSubviewFrame
{
    [self setTitle:@"人脉动态"];
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setBackGroundImage:imageNameAndType(@"subview_backimage", @"png")];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
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
    
    _theTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, controlYLength(searchBar), self.contentView.frame.size.width, self.contentView.frame.size.height - controlYLength(searchBar))];
    [_theTableView setBackgroundColor:color(whiteColor)];
    [_theTableView setDelegate:self];
    [_theTableView setDataSource:self];
    [_theTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self clearKeyBoard];
    
    if (textField == searchBar) {
        [self searchInformation];
    }
    
    return YES;
}


- (void)searchInformation
{
    if (![Utils textIsEmpty:searchBar.text]) {
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (Contacts *contact in cellSource) {
            NSString *searchText = contact.title?contact.title:@"";
            searchText = [searchText stringByAppendingString:([contact.jobArray componentsJoinedByString:@" "]?[contact.jobArray componentsJoinedByString:@" "]:@"")];
            if ([[searchText uppercaseString] rangeOfString:[searchBar.text uppercaseString]].length > 0) {
                [tempArray addObject:contact];
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
    if ([searchBar isFirstResponder]) {
        [searchBar resignFirstResponder];
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

@interface ContactsStatusCell ()

@property (strong, nonatomic) UIImageView               *backGroundImageView;

@end

@implementation ContactsStatusCell

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
    [self.contentView setBackgroundColor:color(clearColor)];
    
    _leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, ContactsStatusCellHeight, ContactsStatusCellHeight)];
    [_leftImage setBounds:CGRectMake(0, 0, _leftImage.frame.size.width * 1.2, _leftImage.frame.size.height * 1.2)];
    [_leftImage setBackgroundColor:color(clearColor)];
    [self.contentView addSubview:_leftImage];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(controlXLength(_leftImage), 10, appFrame.size.width - controlXLength(_leftImage) - 10, (ContactsStatusCellHeight - 20)*2/3)];
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
}

- (void)setBackGroundImage:(UIImage*)image
{
    if (!_backGroundImageView) {
        _backGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, appFrame.size.width, ContactsStatusCellHeight + 1)];
        [_backGroundImageView setBackgroundColor:color(clearColor)];
        [self insertSubview:_backGroundImageView belowSubview:self.contentView];
    }
    [_backGroundImageView setImage:image];
}

@end
