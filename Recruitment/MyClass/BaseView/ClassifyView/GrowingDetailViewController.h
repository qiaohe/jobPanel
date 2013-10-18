//
//  GrowingDetailViewController.h
//  Recruitment
//
//  Created by M J on 13-10-14.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"

@interface GrowingDetailViewController : BaseUIViewController<UITextFieldDelegate,UITextViewDelegate>

@property (strong, nonatomic) UILabel                       *dateLabel;
@property (strong, nonatomic) UIImageView                   *userPicture;
@property (strong, nonatomic) UITextField                   *titleText;
@property (strong, nonatomic) UITextView                    *detailText;

@end
