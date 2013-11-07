//
//  WorkExperienceDetailViewController.m
//  Recruitment
//
//  Created by M J on 13-11-5.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "WorkExperienceDetailViewController.h"

@interface WorkExperienceDetailViewController ()

@property (strong, nonatomic) DatePickerViewController      *datePickerView;

@end

@implementation WorkExperienceDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithWorkExperience:(WorkExperience*)experience
{
    self = [super init];
    if (self) {
        _workExperience = experience;
        [self setSubviewFrame];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setSubviewFrame];
    }
    return self;
}

- (void)pressButton:(UIButton*)sender
{
    if (sender.tag == 100 || sender.tag == 101) {
        switch (sender.tag) {
            case 100:{
                _datePickerType = DatePickerStart;
                break;
            }case 101:{
                _datePickerType = DatePickerEnd;
                break;
            }
            default:
                break;
        }
        if (!_datePickerView) {
            _datePickerView = [[DatePickerViewController alloc]init];
            [_datePickerView.view setFrame:CGRectMake(0, 0, appFrame.size.width, appFrame.size.height)];
            [_datePickerView setDelegate:self];
        }
        [self.view addSubview:_datePickerView.view];
        [_datePickerView fire];
    }
}

- (void)pickerFinished:(NSDate*)date
{
    switch (_datePickerType) {
        case DatePickerStart:
            [_startDate setText:[Utils stringWithDate:date withFormat:@"yyyy年MM月"]];
            break;
        case DatePickerEnd:
            [_endDate setText:[Utils stringWithDate:date withFormat:@"yyyy年MM月"]];
            break;
        default:
            break;
    }
    [_datePickerView.view removeFromSuperview];
}

- (void)pickerCancel
{
    [_datePickerView.view removeFromSuperview];
}

#pragma mark - view init
- (void)setSubviewFrame
{
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setTitle:@"工作经验"];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    UIButton *startDateLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
    [startDateLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [startDateLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [startDateLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [startDateLeft setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [startDateLeft setTitle:@"开始时间" forState:UIControlStateNormal];
    _startDate = [[UITextField alloc]initWithFrame:CGRectMake(15, controlYLength(self.topBar) + 10, self.view.frame.size.width - 30, startDateLeft.frame.size.height)];
    [_startDate setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_startDate setBackgroundColor:color(clearColor)];
    [_startDate setLeftView:startDateLeft];
    [_startDate setEnabled:NO];
    [_startDate setFont:[UIFont systemFontOfSize:13]];
    [_startDate setLeftViewMode:UITextFieldViewModeAlways];
    [_startDate setBackground:imageNameAndType(@"experience_item_normal", nil)];
    [self.contentView addSubview:_startDate];
    
    UIButton *startDateButton = [[UIButton alloc]initWithFrame:_startDate.frame];
    [startDateButton setBackgroundColor:color(clearColor)];
    [startDateButton setTag:100];
    [startDateButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:startDateButton];
    
    UIButton *endDateLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, startDateLeft.frame.size.width, startDateLeft.frame.size.height)];
    [endDateLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [endDateLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [endDateLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [endDateLeft setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [endDateLeft setTitle:@"结束时间" forState:UIControlStateNormal];
    _endDate = [[UITextField alloc]initWithFrame:CGRectMake(_startDate.frame.origin.x, controlYLength(_startDate) + 1, _startDate.frame.size.width, _startDate.frame.size.height)];
    [_endDate setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_endDate setBackgroundColor:color(clearColor)];
    [_endDate setLeftView:endDateLeft];
    [_endDate setEnabled:NO];
    [_endDate setFont:[UIFont systemFontOfSize:13]];
    [_endDate setLeftViewMode:UITextFieldViewModeAlways];
    [_endDate setBackground:imageNameAndType(@"experience_item_normal", nil)];
    [self.contentView addSubview:_endDate];
    
    UIButton *endDateButton = [[UIButton alloc]initWithFrame:_endDate.frame];
    [endDateButton setBackgroundColor:color(clearColor)];
    [endDateButton setTag:101];
    [endDateButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:endDateButton];
    
    UIButton *companyNameLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, _endDate.frame.size.height)];
    [companyNameLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [companyNameLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [companyNameLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [companyNameLeft setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [companyNameLeft setTitle:@"公司" forState:UIControlStateNormal];
    _companyName = [[UITextField alloc]initWithFrame:CGRectMake(_endDate.frame.origin.x, controlYLength(_endDate) + 1, _startDate.frame.size.width, _startDate.frame.size.height)];
    [_companyName setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_companyName setBackgroundColor:color(clearColor)];
    [_companyName setLeftView:companyNameLeft];
    [_companyName setDelegate:self];
    [_companyName setReturnKeyType:UIReturnKeyDone];
    [_companyName setFont:[UIFont systemFontOfSize:13]];
    [_companyName setLeftViewMode:UITextFieldViewModeAlways];
    [_companyName setBackground:imageNameAndType(@"experience_textimage", nil)];
    [self.contentView addSubview:_companyName];
    
    UIButton *industryLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, startDateLeft.frame.size.width, startDateLeft.frame.size.height)];
    [industryLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [industryLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [industryLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [industryLeft setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [industryLeft setTitle:@"行业" forState:UIControlStateNormal];
    _industry = [[UITextField alloc]initWithFrame:CGRectMake(_startDate.frame.origin.x, controlYLength(_companyName) + 1, _startDate.frame.size.width, _startDate.frame.size.height)];
    [_industry setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_industry setBackgroundColor:color(clearColor)];
    [_industry setLeftView:industryLeft];
    [_industry setEnabled:NO];
    [_industry setFont:[UIFont systemFontOfSize:13]];
    [_industry setLeftViewMode:UITextFieldViewModeAlways];
    [_industry setBackground:imageNameAndType(@"experience_item_normal", nil)];
    [self.contentView addSubview:_industry];
    
    UIButton *industryButton = [[UIButton alloc]initWithFrame:_industry.frame];
    [industryButton setBackgroundColor:color(clearColor)];
    [industryButton setTag:102];
    [industryButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:industryButton];
    
    UIButton *companySizeLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, startDateLeft.frame.size.width, startDateLeft.frame.size.height)];
    [companySizeLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [companySizeLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [companySizeLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [companySizeLeft setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [companySizeLeft setTitle:@"公司规模" forState:UIControlStateNormal];
    _companySize = [[UITextField alloc]initWithFrame:CGRectMake(_startDate.frame.origin.x, controlYLength(_industry) + 1, _startDate.frame.size.width, _startDate.frame.size.height)];
    [_companySize setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_companySize setBackgroundColor:color(clearColor)];
    [_companySize setLeftView:companySizeLeft];
    [_companySize setEnabled:NO];
    [_companySize setFont:[UIFont systemFontOfSize:13]];
    [_companySize setLeftViewMode:UITextFieldViewModeAlways];
    [_companySize setBackground:imageNameAndType(@"experience_item_normal", nil)];
    [self.contentView addSubview:_companySize];
    
    UIButton *companySizeButton = [[UIButton alloc]initWithFrame:_companySize.frame];
    [companySizeButton setBackgroundColor:color(clearColor)];
    [companySizeButton setTag:103];
    [companySizeButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:companySizeButton];
    
    UIButton *companyPropertyLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, startDateLeft.frame.size.width, startDateLeft.frame.size.height)];
    [companyPropertyLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [companyPropertyLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [companyPropertyLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [companyPropertyLeft setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [companyPropertyLeft setTitle:@"公司性质" forState:UIControlStateNormal];
    _companyProperty = [[UITextField alloc]initWithFrame:CGRectMake(_startDate.frame.origin.x, controlYLength(_companySize) + 1, _startDate.frame.size.width, _startDate.frame.size.height)];
    [_companyProperty setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_companyProperty setBackgroundColor:color(clearColor)];
    [_companyProperty setLeftView:companyPropertyLeft];
    [_companyProperty setEnabled:NO];
    [_companyProperty setFont:[UIFont systemFontOfSize:13]];
    [_companyProperty setLeftViewMode:UITextFieldViewModeAlways];
    [_companyProperty setBackground:imageNameAndType(@"experience_item_normal", nil)];
    [self.contentView addSubview:_companyProperty];
    
    UIButton *companyPropertyButton = [[UIButton alloc]initWithFrame:_companyProperty.frame];
    [companyPropertyButton setBackgroundColor:color(clearColor)];
    [companyPropertyButton setTag:104];
    [companyPropertyButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:companyPropertyButton];
    
    UIButton *positionLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, _endDate.frame.size.height)];
    [positionLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [positionLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [positionLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [positionLeft setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [positionLeft setTitle:@"职位" forState:UIControlStateNormal];
    _position = [[UITextField alloc]initWithFrame:CGRectMake(_endDate.frame.origin.x, controlYLength(_companyProperty) + 1, _startDate.frame.size.width, _startDate.frame.size.height)];
    [_position setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_position setBackgroundColor:color(clearColor)];
    [_position setLeftView:positionLeft];
    [_position setDelegate:self];
    [_position setReturnKeyType:UIReturnKeyDone];
    [_position setFont:[UIFont systemFontOfSize:13]];
    [_position setLeftViewMode:UITextFieldViewModeAlways];
    [_position setBackground:imageNameAndType(@"experience_textimage", nil)];
    [self.contentView addSubview:_position];
    
    UIButton *positionDescriptionLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, startDateLeft.frame.size.width, startDateLeft.frame.size.height)];
    [positionDescriptionLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [positionDescriptionLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [positionDescriptionLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [positionDescriptionLeft setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [positionDescriptionLeft setTitle:@"工作描述" forState:UIControlStateNormal];
    _positionDescription = [[UITextField alloc]initWithFrame:CGRectMake(_startDate.frame.origin.x, controlYLength(_position) + 20, _startDate.frame.size.width, _startDate.frame.size.height)];
    [_positionDescription setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_positionDescription setBackgroundColor:color(clearColor)];
    [_positionDescription setLeftView:positionDescriptionLeft];
    [_positionDescription setEnabled:NO];
    [_positionDescription setFont:[UIFont systemFontOfSize:13]];
    [_positionDescription setLeftViewMode:UITextFieldViewModeAlways];
    [_positionDescription setBackground:imageNameAndType(@"experience_item_normal", nil)];
    [self.contentView addSubview:_positionDescription];
    
    UIButton *positionDescriptionButton = [[UIButton alloc]initWithFrame:_positionDescription.frame];
    [positionDescriptionButton setBackgroundColor:color(clearColor)];
    [positionDescriptionButton setTag:105];
    [positionDescriptionButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:positionDescriptionButton];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setBackgroundImage:imageNameAndType(@"resume_done_normal", @"png") forState:UIControlStateNormal];
    [doneButton setBackgroundImage:imageNameAndType(@"resume_done_press", @"png") forState:UIControlStateHighlighted];
    [doneButton setBackgroundColor:color(clearColor)];
    [doneButton setFrame:CGRectMake(self.contentView.frame.size.width/6, controlYLength(positionDescriptionButton) + 20, self.contentView.frame.size.width*2/3, 50)];
    [doneButton addTarget:self action:@selector(pressDoneButton:) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.contentView addSubview:doneButton];
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeButton setBackgroundColor:color(clearColor)];
    [homeButton setTag:102];
    [homeButton setImage:imageNameAndType(@"returnhome_normal", @"png") forState:UIControlStateNormal];
    [homeButton setImage:imageNameAndType(@"returnhome_press", @"png") forState:UIControlStateHighlighted];
    [self setPopToMainViewButton:homeButton];
    [self setBottomBarItems:@[homeButton]];
    [self setBottomBarBackGroundImage:imageNameAndType(@"bottombar", @"png")];
}

- (void)pressDoneButton:(UIButton*)sender
{
    [self popViewControllerTransitionType:TransitionPush completionHandler:^{
        [[Model shareModel] showPromptText:@"操作完成" model:YES];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self clearKeyBoard];
    return YES;
}

- (BOOL)clearKeyBoard
{
    BOOL canResignFirstResponder = NO;
    if([_companyName isFirstResponder]){
        [_companyName resignFirstResponder];
        canResignFirstResponder = YES;
    }else if ([_position isFirstResponder]){
        [_position resignFirstResponder];
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
