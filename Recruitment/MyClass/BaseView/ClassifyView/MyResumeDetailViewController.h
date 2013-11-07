//
//  MyResumeDetailViewController.h
//  Recruitment
//
//  Created by M J on 13-10-18.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"
#import "TextEditViewController.h"
#import "ImagePickerViewController.h"

@class MyResumeDetail;

@interface MyResumeDetailViewController : BaseUIViewController<TextEditDelegate,ImagePickerViewControllerDelegate>{
    ImagePickerViewController *imagePicker;
}

@property (strong, nonatomic) UITextField               *name;
@property (strong, nonatomic) UITextField               *birthDate;
@property (strong, nonatomic) UITextField               *currentJob;
@property (strong, nonatomic) UITextField               *currentCompany;
@property (strong, nonatomic) UITextField               *location;
@property (strong, nonatomic) MyResumeDetail            *myResume;

- (id)initWithResumeDetail:(MyResumeDetail*)resumeDetail;

@end
