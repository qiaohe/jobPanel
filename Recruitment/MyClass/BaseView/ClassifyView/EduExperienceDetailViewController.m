//
//  EduExperienceDetailViewController.m
//  Recruitment
//
//  Created by M J on 13-11-5.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "EduExperienceDetailViewController.h"

@interface EduExperienceDetailViewController ()

@property (strong, nonatomic) DatePickerViewController      *datePickerView;

@end

@implementation EduExperienceDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithWorkExperience:(EduExperience*)experience
{
    self = [super init];
    if (self) {
        _eduExperience = experience;
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


- (void)setSubviewFrame
{
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setTitle:@"教育经历"];
    
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
    
    UIButton *collegeNameLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, startDateLeft.frame.size.width, startDateLeft.frame.size.height)];
    [collegeNameLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [collegeNameLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [collegeNameLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [collegeNameLeft setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [collegeNameLeft setTitle:@"学校" forState:UIControlStateNormal];
    _collegeName = [[UITextField alloc]initWithFrame:CGRectMake(_startDate.frame.origin.x, controlYLength(_endDate) + 1, _startDate.frame.size.width, _startDate.frame.size.height)];
    [_collegeName setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_collegeName setBackgroundColor:color(clearColor)];
    [_collegeName setDelegate:self];
    [_collegeName setLeftView:collegeNameLeft];
    [_collegeName setReturnKeyType:UIReturnKeyDone];
    [_collegeName setFont:[UIFont systemFontOfSize:13]];
    [_collegeName setLeftViewMode:UITextFieldViewModeAlways];
    [_collegeName setBackground:imageNameAndType(@"experience_textimage", nil)];
    [self.contentView addSubview:_collegeName];
    
    UIButton *educationLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, startDateLeft.frame.size.width, startDateLeft.frame.size.height)];
    [educationLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [educationLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [educationLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [educationLeft setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [educationLeft setTitle:@"学历" forState:UIControlStateNormal];
    _education = [[UITextField alloc]initWithFrame:CGRectMake(_startDate.frame.origin.x, controlYLength(_collegeName) + 1, _startDate.frame.size.width, _startDate.frame.size.height)];
    [_education setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_education setBackgroundColor:color(clearColor)];
    [_education setLeftView:educationLeft];
    [_education setEnabled:NO];
    [_education setFont:[UIFont systemFontOfSize:13]];
    [_education setLeftViewMode:UITextFieldViewModeAlways];
    [_education setBackground:imageNameAndType(@"experience_item_normal", nil)];
    [self.contentView addSubview:_education];
    
    UIButton *educationButton = [[UIButton alloc]initWithFrame:_education.frame];
    [educationButton setBackgroundColor:color(clearColor)];
    [educationButton setTag:103];
    [educationButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:educationButton];
    
    UIButton *professionalLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, startDateLeft.frame.size.width, startDateLeft.frame.size.height)];
    [professionalLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [professionalLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [professionalLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [professionalLeft setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [professionalLeft setTitle:@"专业" forState:UIControlStateNormal];
    _professional = [[UITextField alloc]initWithFrame:CGRectMake(_startDate.frame.origin.x, controlYLength(_education) + 1, _startDate.frame.size.width, _startDate.frame.size.height)];
    [_professional setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_professional setBackgroundColor:color(clearColor)];
    [_professional setLeftView:professionalLeft];
    [_professional setEnabled:NO];
    [_professional setFont:[UIFont systemFontOfSize:13]];
    [_professional setLeftViewMode:UITextFieldViewModeAlways];
    [_professional setBackground:imageNameAndType(@"experience_item_normal", nil)];
    [self.contentView addSubview:_professional];
    
    UIButton *professionalButton = [[UIButton alloc]initWithFrame:_professional.frame];
    [professionalButton setBackgroundColor:color(clearColor)];
    [professionalButton setTag:104];
    [professionalButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:professionalButton];
    
    UIButton *studyAbroadLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, startDateLeft.frame.size.width, startDateLeft.frame.size.height)];
    [studyAbroadLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [studyAbroadLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [studyAbroadLeft.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [studyAbroadLeft setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [studyAbroadLeft setTitle:@"海外学习" forState:UIControlStateNormal];
    _studyAbroad = [[UITextField alloc]initWithFrame:CGRectMake(_startDate.frame.origin.x, controlYLength(_professional) + 20, _startDate.frame.size.width, _startDate.frame.size.height)];
    [_studyAbroad setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_studyAbroad setBackgroundColor:color(clearColor)];
    [_studyAbroad setLeftView:studyAbroadLeft];
    [_studyAbroad setEnabled:NO];
    [_studyAbroad setFont:[UIFont systemFontOfSize:13]];
    [_studyAbroad setLeftViewMode:UITextFieldViewModeAlways];
    [_studyAbroad setBackground:imageNameAndType(@"experience_textimage", nil)];
    [self.contentView addSubview:_studyAbroad];
    
    UISwitch *sch = [[UISwitch alloc]init];
    [sch setCenter:CGPointMake(_studyAbroad.frame.origin.x + _studyAbroad.frame.size.width - sch.frame.size.width/2 - 10, _studyAbroad.frame.origin.y + _studyAbroad.frame.size.height/2)];
    [self.contentView addSubview:sch];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setBackgroundImage:imageNameAndType(@"resume_done_normal", @"png") forState:UIControlStateNormal];
    [doneButton setBackgroundImage:imageNameAndType(@"resume_done_press", @"png") forState:UIControlStateHighlighted];
    [doneButton setBackgroundColor:color(clearColor)];
    [doneButton setFrame:CGRectMake(self.contentView.frame.size.width/6, controlYLength(_studyAbroad) + 30, self.contentView.frame.size.width*2/3, 50)];
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

- (BOOL)clearKeyBoard
{
    BOOL canResignFirstResponder = NO;
    if ([_collegeName isFirstResponder]) {
        [_collegeName resignFirstResponder];
        canResignFirstResponder = YES;
    }
    return canResignFirstResponder;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self clearKeyBoard];
    return YES;
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
