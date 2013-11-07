//
//  ResumeSubitemViewController.m
//  Recruitment
//
//  Created by M J on 13-11-5.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "ResumeSubitemViewController.h"
#import "WorkExperienceDetailViewController.h"
#import "EduExperienceDetailViewController.h"
#import "WorkExperience.h"
#import "EduExperience.h"

@interface ResumeSubitemViewController ()

@end

@implementation ResumeSubitemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithType:(ResumeSubitemInitType)initType
{
    self = [super init];
    if (self) {
        _type = initType;
        if (_type == ResumeSubitemWorkExperience) {
            _dataSource = [NSMutableArray arrayWithArray:[WorkExperience getRecommendDataWithNum:5]];
        }else if(_type == ResumeSubitemEduExperience){
            _dataSource = [NSMutableArray arrayWithArray:[EduExperience getRecommendDataWithNum:5]];
        }
        [self setSubviewFrame];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ResumeSubitemViewCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierStr = @"cell";
    ResumeSubitemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierStr];
    if (cell == nil) {
        cell = [[ResumeSubitemCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifierStr];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [cell.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [cell.titleLabel setTextColor:color(darkGrayColor)];
        [cell.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [cell.titleLabel setAdjustsLetterSpacingToFitWidth:YES];
        [cell.titleLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
        [cell.titleLabel setMinimumScaleFactor:0.5];
        
        [cell.detailLabel setFont:[UIFont systemFontOfSize:14]];
        [cell.detailLabel setTextColor:UIColorFromRGB(0x0ca7bc)];
        [cell.detailLabel setAdjustsFontSizeToFitWidth:YES];
        [cell.detailLabel setAdjustsLetterSpacingToFitWidth:YES];
        [cell.detailLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
        [cell.detailLabel setMinimumScaleFactor:0.5];
        
        [cell setBackGroundImage:imageNameAndType(@"settingitem_arrow_normal", nil)];
    }
    if (_type == ResumeSubitemWorkExperience) {
        WorkExperience *experience = [_dataSource objectAtIndex:indexPath.row];
        NSLog(@"date = %@",[NSString stringWithFormat:@"%@ 到 %@",experience.startDate,experience.endDate]);
        [cell.titleLabel setText:experience.workCompany];
        [cell.detailLabel setText:[NSString stringWithFormat:@"%@ 到 %@",experience.startDate,experience.endDate]];
    }else{
        EduExperience *experience = [_dataSource objectAtIndex:indexPath.row];
        [cell.titleLabel setText:experience.collegeName];
        [cell.detailLabel setText:[NSString stringWithFormat:@"%@ 到 %@",experience.startDate,experience.endDate]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == ResumeSubitemWorkExperience) {
        WorkExperienceDetailViewController *experienceView = [[WorkExperienceDetailViewController alloc]init];
        [self pushViewController:experienceView transitionType:TransitionPush completionHandler:nil];
    }else if (_type == ResumeSubitemEduExperience){
        EduExperienceDetailViewController *experienceView = [[EduExperienceDetailViewController alloc]init];
        [self pushViewController:experienceView transitionType:TransitionPush completionHandler:nil];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - view init
- (void)setSubviewFrame
{
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    if (_type == ResumeSubitemWorkExperience) {
        [self setTitle:@"工作经历"];
    }else {
        [self setTitle:@"教育经历"];
    }
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setBackgroundColor:color(clearColor)];
    [deleteButton setFrame:CGRectMake(self.view.frame.size.width - returnButton.frame.size.width * 2 - 5, returnButton.frame.origin.y, returnButton.frame.size.width, returnButton.frame.size.height)];
    [deleteButton setTag:100];
    [deleteButton setImage:imageNameAndType(@"home_delete", @"png") forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(pressRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteButton];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setBackgroundColor:color(clearColor)];
    [addButton setFrame:CGRectMake(controlXLength(deleteButton), returnButton.frame.origin.y, returnButton.frame.size.width, returnButton.frame.size.height)];
    [addButton setTag:101];
    [addButton setImage:imageNameAndType(@"growing_add_normal", @"png") forState:UIControlStateNormal];
    [addButton setImage:imageNameAndType(@"growing_add_press", @"png") forState:UIControlStateHighlighted];
    [addButton setImage:imageNameAndType(@"growing_add_press", @"png") forState:UIControlStateSelected];
    [addButton addTarget:self action:@selector(pressRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    _theTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, controlYLength(self.topBar), self.contentView.frame.size.width, self.contentView.frame.size.height - controlYLength(self.topBar))];
    [_theTableView setDelegate:self];
    [_theTableView setDataSource:self];
    //[_theTableView setBackgroundColor:color(clearColor)];
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

- (void)pressRightButton:(UIButton*)sender
{
    switch (sender.tag) {
        case 100:{
            static BOOL edit = NO;
            edit = edit?NO:YES;
            [_theTableView setEditing:edit animated:YES];
            break;
        }case 101:{
            if (_type == ResumeSubitemWorkExperience) {
                WorkExperienceDetailViewController *experienceView = [[WorkExperienceDetailViewController alloc]init];
                [self pushViewController:experienceView transitionType:TransitionPush completionHandler:nil];
            }else if (_type == ResumeSubitemEduExperience){
                EduExperienceDetailViewController *experienceView = [[EduExperienceDetailViewController alloc]init];
                [self pushViewController:experienceView transitionType:TransitionPush completionHandler:nil];
            }
            break;
        }
        default:
            break;
    }
    
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

@interface ResumeSubitemCell ()

@property (strong, nonatomic) UIImageView           *backGroundImageView;

@end

@implementation ResumeSubitemCell

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
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, appFrame.size.width - 30, ResumeSubitemViewCellHeight/2)];
    [_titleLabel setBackgroundColor:color(clearColor)];
    [self.contentView addSubview:_titleLabel];
    
    _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.frame.origin.x, controlYLength(_titleLabel), _titleLabel.frame.size.width, _titleLabel.frame.size.height)];
    [_detailLabel setBackgroundColor:color(clearColor)];
    [self.contentView addSubview:_detailLabel];
}

- (void)setLeftImage:(UIImage*)image
{
    if (image) {
        if (!_leftImageView) {
            _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ResumeSubitemViewCellHeight, ResumeSubitemViewCellHeight)];
            [_leftImageView setBackgroundColor:color(clearColor)];
        }
        if (!_leftImageView.superview) {
            [self.contentView addSubview:_leftImageView];
        }
        [_titleLabel setFrame:CGRectMake(20 + ResumeSubitemViewCellHeight, _titleLabel.frame.origin.y, appFrame.size.width - 30 - ResumeSubitemViewCellHeight - (_rightImageView.superview?ResumeSubitemViewCellHeight:0), _titleLabel.frame.size.height)];
        [_detailLabel setFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y, _titleLabel.frame.size.width, _titleLabel.frame.size.height)];
    }else{
        if (_leftImageView.superview) {
            [_leftImageView removeFromSuperview];
        }
        [_titleLabel setFrame:CGRectMake(20, _titleLabel.frame.origin.y, appFrame.size.width - 30 - (_rightImageView.superview?ResumeSubitemViewCellHeight:0), _titleLabel.frame.size.height)];
        [_detailLabel setFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y, _titleLabel.frame.size.width, _titleLabel.frame.size.height)];
    }
    
}

- (void)setRightImage:(UIImage*)image
{
    if (image) {
        if (!_rightImageView) {
            _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ResumeSubitemViewCellHeight, ResumeSubitemViewCellHeight)];
            [_rightImageView setBackgroundColor:color(clearColor)];
        }
        if (!_rightImageView.superview) {
            [self.contentView addSubview:_rightImageView];
        }
        [_titleLabel setFrame:CGRectMake(20 + (_leftImageView.superview?ResumeSubitemViewCellHeight:0), _titleLabel.frame.origin.y, appFrame.size.width - 30 - ResumeSubitemViewCellHeight - (_leftImageView.superview?ResumeSubitemViewCellHeight:0), _titleLabel.frame.size.height)];
        [_detailLabel setFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y, _titleLabel.frame.size.width, _titleLabel.frame.size.height)];
    }else{
        if (_leftImageView.superview) {
            [_leftImageView removeFromSuperview];
        }
        [_titleLabel setFrame:CGRectMake(20 + (_leftImageView.superview?ResumeSubitemViewCellHeight:0), _titleLabel.frame.origin.y, appFrame.size.width - 30 - (_leftImageView.superview?ResumeSubitemViewCellHeight:0), _titleLabel.frame.size.height)];
        [_detailLabel setFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y, _titleLabel.frame.size.width, _titleLabel.frame.size.height)];
    }
}


- (void)setBackGroundImage:(UIImage*)image
{
    if (!_backGroundImageView) {
        _backGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, appFrame.size.width, ResumeSubitemViewCellHeight)];
        [_backGroundImageView setBackgroundColor:color(clearColor)];
        [self insertSubview:_backGroundImageView belowSubview:self.contentView];
    }
    [_backGroundImageView setImage:image];
}


@end
