//
//  RegisterViewController.h
//  Recruitment
//
//  Created by M J on 13-10-12.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"

@interface RegisterViewController : BaseUIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UIButton              *userPicture;
@property (strong, nonatomic) UIView                *currentSubview;

@property (strong, nonatomic) UITextField           *userName;
@property (strong, nonatomic) UITextField           *phoneNum;
@property (strong, nonatomic) UITextField           *email;
@property (strong, nonatomic) UITextField           *password;

@property (strong, nonatomic) UITextField           *currentPosition;
@property (strong, nonatomic) UITextField           *currentCompany;
@property (strong, nonatomic) UITextField           *goalCompany;

@end
