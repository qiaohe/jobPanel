//
//  AccountMaintainViewController.h
//  Recruitment
//
//  Created by M J on 13-10-31.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"

@interface AccountMaintainViewController : BaseUIViewController<UITextFieldDelegate>

@property (strong, nonatomic) UITextField                   *name;
@property (strong, nonatomic) UITextField                   *mobile;
@property (strong, nonatomic) UITextField                   *email;
@property (strong, nonatomic) UITextField                   *passWord;
@property (strong, nonatomic) UITextField                   *currentJob;
@property (strong, nonatomic) UITextField                   *currentCompany;
@property (strong, nonatomic) UITextField                   *goalCompany;
@property (strong, nonatomic) UITextField                   *IdCardNum;

@end
