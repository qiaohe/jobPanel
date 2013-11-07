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
        cellSource = [NSMutableArray arrayWithArray:[Contacts getContactsWithNum:4]];
        _dataSource = cellSource;
        [self setSubviewFrame];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contacts *imageName = [_dataSource objectAtIndex:indexPath.row];
    if (imageName.isUnfold) {
        return ContactsUnfoldCellHeight(imageName);
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
    
    [cell.leftImage setImage:imageNameAndType(contact.userPicture, nil)];
    [cell.titleLabel setText:contact.contactName];
    [cell.locationLabel setText:contact.location];
    [cell subjoinviewShow:contact];
    NSLog(@"trends count = %u",[contact.trends count]);
    [cell.rightImage setImage:imageNameAndType(@"arrow_down", nil)];
    [cell.rightImage setHighlightedImage:imageNameAndType(@"arrow_up", nil)];
    
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
    [_theTableView setBackgroundColor:color(whiteColor)];
    [_theTableView setDelegate:self];
    [_theTableView setDataSource:self];
    [_theTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
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

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    CGAffineTransform currentTransform = self.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, frame.size.width / self.frame.size.width, frame.size.height/self.frame.size.height);
    [self setTransform:newTransform];
}

- (void)setCellSubviewFrame
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.contentView setBackgroundColor:color(clearColor)];
    
//    _backGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, appFrame.size.width, ContactsStatusCellHeight)];
//    [_backGroundImageView setBackgroundColor:color(clearColor)];
//    [self.contentView addSubview:_backGroundImageView];
    
    _leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ContactsStatusCellHeight, ContactsStatusCellHeight)];
    [_leftImage setBounds:CGRectMake(0, 0, _leftImage.frame.size.width * 0.7, _leftImage.frame.size.height * 0.7)];
    [_leftImage setBackgroundColor:color(clearColor)];
    [self.contentView addSubview:_leftImage];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ContactsStatusCellHeight, 10, appFrame.size.width - ContactsStatusCellHeight * 2, (ContactsStatusCellHeight - 20)*2/3)];
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
                                                 17,
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
    
    _rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(controlXLength(_locationLabel), 0, ContactsStatusCellHeight, ContactsStatusCellHeight)];
    [_rightImage setBounds:CGRectMake(0, 0, _leftImage.frame.size.width * 0.7, _leftImage.frame.size.height * 0.7)];
    [_rightImage setBackgroundColor:color(clearColor)];
    
    [self.contentView addSubview:_rightImage];
    
    [self setSubjoinviewFrame];
}

- (void)setSubjoinviewFrame
{
    UIView *subjoinView = [[UIView alloc]initWithFrame:CGRectMake(0, ContactsStatusCellHeight, appFrame.size.width, 30)];
    [subjoinView setBackgroundColor:color(clearColor)];
    [subjoinView setTag:100];
    [subjoinView setHidden:YES];
    [self.contentView addSubview:subjoinView];
    
    UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, subjoinView.frame.size.width - 10, 25)];
    [promptLabel setBackgroundColor:color(clearColor)];
    [promptLabel setText:@"最新动态:"];
    [promptLabel setFont:[UIFont systemFontOfSize:13]];
    [subjoinView addSubview:promptLabel];
        
    _theTableView = [[UITableView alloc]initWithFrame:CGRectMake(25, controlYLength(promptLabel) + 5, appFrame.size.width - 35, 0)];
    [_theTableView setDelegate:self];
    [_theTableView setDataSource:self];
    [_theTableView setBackgroundColor:color(clearColor)];
    [_theTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [subjoinView addSubview:_theTableView];
}

- (void)subjoinviewShow:(Contacts *)param
{
    UIView *tempView = [self.contentView viewWithTag:100];
    _dataSource = param.trends;
    [tempView setFrame:CGRectMake(tempView.frame.origin.x, tempView.frame.origin.y, tempView.frame.size.width, 30 + ContactsUnfoldItemHeight * [_dataSource count])];
    [_theTableView setFrame:CGRectMake(_theTableView.frame.origin.x, _theTableView.frame.origin.y, _theTableView.frame.size.width, ContactsUnfoldItemHeight * [_dataSource count])];
    [_theTableView reloadData];
    tempView.hidden = !param.isUnfold;
    _rightImage.highlighted = !tempView.hidden;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ContactsUnfoldItemHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierString = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierString];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.imageView setBounds:CGRectMake(0, 0, cell.imageView.frame.size.width * 0.5, cell.imageView.frame.size.height * 0.5)];
        CGAffineTransform currentTransform = cell.imageView.transform;
        CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, 0.6, 0.6);
        [cell.imageView setTransform:newTransform];
        UIImage *star = imageNameAndType(@"star_light", nil);
        //star = [star resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, -10, -10) ];
        [cell.imageView setImage:star];
        UIGraphicsEndImageContext();
        [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
        [cell.textLabel setAdjustsFontSizeToFitWidth:YES];
        [cell.textLabel setAdjustsLetterSpacingToFitWidth:YES];
        [cell.textLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
        [cell.textLabel setMinimumScaleFactor:0.5];
    }
    ContactTrends *contact = [_dataSource objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@: %@",contact.trendsTitle,contact.trendsDetail]];
    
    return cell;
}

- (void)setBackGroundImage:(UIImage*)image
{
    if (!_backGroundImageView) {
        _backGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -1, appFrame.size.width, ContactsStatusCellHeight + 1)];
        [_backGroundImageView setBackgroundColor:color(clearColor)];
        [self insertSubview:_backGroundImageView belowSubview:self.contentView];
    }
    [_backGroundImageView setImage:image];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
   // [_rightImage setHighlighted:selected];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    //[_rightImage setHighlighted:highlighted];
}

@end
