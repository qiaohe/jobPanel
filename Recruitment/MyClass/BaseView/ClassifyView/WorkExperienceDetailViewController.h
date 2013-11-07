//
//  WorkExperienceDetailViewController.h
//  Recruitment
//
//  Created by M J on 13-11-5.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"
#import "DatePickerViewController.h"

typedef NS_OPTIONS(NSInteger, DatePickerType){
    DatePickerStart,
    DatePickerEnd
};

@class WorkExperience;

@interface WorkExperienceDetailViewController : BaseUIViewController<DatePickerDelegate,UITextFieldDelegate>

@property (strong, nonatomic) UITextField               *startDate;
@property (strong, nonatomic) UITextField               *endDate;
@property (strong, nonatomic) UITextField               *companyName;
@property (strong, nonatomic) UITextField               *industry;
@property (strong, nonatomic) UITextField               *companySize;
@property (strong, nonatomic) UITextField               *companyProperty;
@property (strong, nonatomic) UITextField               *position;
@property (strong, nonatomic) UITextField               *positionDescription;

@property (assign, nonatomic) DatePickerType            datePickerType;

@property (strong, nonatomic) WorkExperience            *workExperience;

- (id)initWithWorkExperience:(WorkExperience*)experience;

@end
