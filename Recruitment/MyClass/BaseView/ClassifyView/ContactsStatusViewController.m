//
//  ContactsStatusViewController.m
//  Recruitment
//
//  Created by M J on 13-10-15.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "ContactsStatusViewController.h"
#import "Contacts.h"
#import "MyGrowing.h"

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
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contacts *imageName = [_dataSource objectAtIndex:indexPath.row];
    if (imageName.isUnfold) {
        return ContactsUnfoldCellHeight;
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
    [cell subjoinviewShow:contact];
    [cell setBackGroundImage:imageNameAndType(@"information_textbackimage", nil)];
    
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
    [returnButton setImage:imageNameAndType(@"return_normal", @"png")
                  forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png")
                  forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png")
                  forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    UIImageView *searchBarBackImage = [[UIImageView alloc]initWithFrame:
                                       CGRectMake(0,
                                                  controlYLength(self.topBar),
                                                  self.view.frame.size.width,
                                                  35)];
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
    
    _theTableView = [[UITableView alloc]initWithFrame:
                     CGRectMake(0,
                                controlYLength(searchBar),
                                self.contentView.frame.size.width,
                                self.contentView.frame.size.height - controlYLength(searchBar))];
    [_theTableView setBackgroundColor:color(clearColor)];
    [_theTableView setDelegate:self];
    [_theTableView setDataSource:self];
    [_theTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.contentView addSubview:_theTableView];
    
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
        [self setCellSubviewFrame];
    }
    return self;
}

- (void)setCellSubviewFrame
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.contentView setBackgroundColor:color(clearColor)];
    
    _backGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, appFrame.size.width, ContactsStatusCellHeight + 1)];
    [_backGroundImageView setBackgroundColor:color(clearColor)];
    [self.contentView addSubview:_backGroundImageView];
    
    _leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ContactsStatusCellHeight, ContactsStatusCellHeight)];
    [_leftImage setBounds:CGRectMake(0, 0, _leftImage.frame.size.width * 0.7, _leftImage.frame.size.height * 0.7)];
    [_leftImage setBackgroundColor:color(clearColor)];
    [self.contentView addSubview:_leftImage];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(controlXLength(_leftImage), 10, appFrame.size.width - controlXLength(_leftImage) - 10, (ContactsStatusCellHeight - 20)*2/3)];
    [_titleLabel setBackgroundColor:color(clearColor)];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [self.contentView addSubview:_titleLabel];
    
    _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.frame.origin.x, controlYLength(_titleLabel), _titleLabel.frame.size.width, _titleLabel.frame.size.height)];
    [_detailLabel setBackgroundColor:color(clearColor)];
    [_detailLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [self.contentView addSubview:_detailLabel];
    
    UIImageView *locationLeftImage = [[UIImageView alloc]initWithFrame:
                                      CGRectMake(_titleLabel.frame.origin.x,
                                                 controlYLength(_titleLabel),
                                                 15,
                                                 15)];
    [locationLeftImage setImage:imageNameAndType(@"resume_location", @"png")];
    [self.contentView addSubview:locationLeftImage];
    
    _locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(controlXLength(locationLeftImage),
                                                              controlYLength(_titleLabel),
                                                              _titleLabel.frame.size.width - locationLeftImage.frame.size.width,
                                                              _titleLabel.frame.size.height/2)];
    [_locationLabel setBackgroundColor:color(clearColor)];
    [_locationLabel setFont:[UIFont systemFontOfSize:11]];
    [_locationLabel setTextColor:color(darkGrayColor)];
    [self.contentView addSubview:_locationLabel];
    
    [self setSubjoinviewFrame];
}

- (void)setSubjoinviewFrame
{
    UIView *subjoinView = [[UIView alloc]initWithFrame:CGRectMake(0, ContactsStatusCellHeight, appFrame.size.width, ContactsUnfoldCellHeight - ContactsStatusCellHeight)];
    [subjoinView setBackgroundColor:color(clearColor)];
    [subjoinView setTag:100];
    [subjoinView setHidden:YES];
    [self.contentView addSubview:subjoinView];
    
    UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, subjoinView.frame.size.width - 10, 25)];
    [promptLabel setBackgroundColor:color(clearColor)];
    [promptLabel setText:@"我的作品:"];
    [promptLabel setFont:[UIFont systemFontOfSize:13]];
    [subjoinView addSubview:promptLabel];
        
    BaseContentView *subjoinScorllView = [[BaseContentView alloc]initWithFrame:CGRectMake(0, controlYLength(promptLabel), subjoinView.frame.size.width, subjoinView.frame.size.height - controlYLength(promptLabel))];
    [subjoinScorllView setSuperResponder:self];
    [subjoinScorllView setPagingEnabled:NO];
    [subjoinScorllView setShowsHorizontalScrollIndicator:NO];
    [subjoinScorllView setShowsVerticalScrollIndicator:NO];
    [subjoinScorllView setTag:101];
    [subjoinScorllView setBackgroundColor:color(clearColor)];
    [subjoinView addSubview:subjoinScorllView];
}

- (void)subjoinviewShow:(Contacts *)param
{
    UIView *tempView = [self.contentView viewWithTag:100];
    BaseContentView *subjoinView = (BaseContentView*)[tempView viewWithTag:101];
    [subjoinView removeAllSubview];
    
    if ([param.myGrowings count] != 0) {
        for (int i = 0;i<[param.myGrowings count];i++) {
            MyGrowing *growing = [param.myGrowings objectAtIndex:i];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(appFrame.size.width*i/2, 0, appFrame.size.width/2, ContactsUnfoldCellHeight - ContactsStatusCellHeight - 35)];
            [imageView setBounds:CGRectMake(0, 0, imageView.frame.size.width*0.8, imageView.frame.size.height)];
            [imageView setImage:growing.image];
            [subjoinView addSubview:imageView];
        }
    }
    tempView.hidden = !param.isUnfold;
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
