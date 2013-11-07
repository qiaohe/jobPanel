//
//  EduExperienceDetailViewController.h
//  Recruitment
//
//  Created by M J on 13-11-5.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"
#import "WorkExperienceDetailViewController.h"
#import "EduExperience.h"

@interface EduExperienceDetailViewController : BaseUIViewController<DatePickerDelegate,UITextFieldDelegate>

@property (strong, nonatomic) UITextField               *startDate;
@property (strong, nonatomic) UITextField               *endDate;
@property (strong, nonatomic) UITextField               *collegeName;
@property (strong, nonatomic) UITextField               *education;
@property (strong, nonatomic) UITextField               *professional;
@property (strong, nonatomic) UITextField               *studyAbroad;

@property (assign, nonatomic) DatePickerType            datePickerType;

@property (strong, nonatomic) EduExperience             *eduExperience;

@end
