//
//  ContactsStatusViewController.m
//  Recruitment
//
//  Created by M J on 13-10-15.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "ContactsStatusViewController.h"
#import "Contacts.h"

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
        _dataSource = [NSMutableArray array];
        for (int i = 0; i<7; i++) {
            NSInteger index = (arc4random() % 3) + 1;
            NSString *imageName = [@"contact_item" stringByAppendingFormat:@"%d",index];
            Contacts *contact   = [[Contacts alloc]init];
            contact.title       = imageName;
            [_dataSource addObject:contact];
        }
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
    Contacts *imageName = [_dataSource objectAtIndex:indexPath.row];
    [cell setBackGroundImage:imageNameAndType(imageName.title, @"png")];
    
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
    [_theTableView setBackgroundColor:color(clearColor)];
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
    return YES;
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
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setSubviewFrame
{
    _leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ContactsStatusCellHeight, ContactsStatusCellHeight)];
    [_leftImage setBounds:CGRectMake(0, 0, _leftImage.frame.size.width * 0.8, _leftImage.frame.size.height * 0.8)];
    [_leftImage setBackgroundColor:color(clearColor)];
    [self.contentView addSubview:_leftImage];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(controlXLength(_leftImage) + 10, 10, appFrame.size.width - controlXLength(_leftImage) - 10, (ContactsStatusCellHeight - 20)*2/5)];
    [_titleLabel setBackgroundColor:color(clearColor)];
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [self.contentView addSubview:_titleLabel];
    
    _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.frame.origin.x, controlYLength(_titleLabel), _titleLabel.frame.size.width, _titleLabel.frame.size.height)];
    [_detailLabel setBackgroundColor:color(clearColor)];
    [_detailLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [self.contentView addSubview:_detailLabel];
    
    _locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(_detailLabel.frame.origin.x, controlYLength(_detailLabel), _detailLabel.frame.size.width, _detailLabel.frame.size.height/2)];
    [_locationLabel setBackgroundColor:color(clearColor)];
    [_locationLabel setFont:[UIFont boldSystemFontOfSize:11]];
    [self.contentView addSubview:_locationLabel];
}

- (void)setBackGroundImage:(UIImage*)image
{
    if (!_backGroundImageView) {
        _backGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, appFrame.size.width, ContactsStatusCellHeight)];
        [_backGroundImageView setBackgroundColor:color(clearColor)];
        [self insertSubview:_backGroundImageView aboveSubview:self.contentView];
    }
    [_backGroundImageView setImage:image];
}

@end
