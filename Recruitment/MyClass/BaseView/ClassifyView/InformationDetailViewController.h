//
//  InformationDetailViewController.h
//  Recruitment
//
//  Created by M J on 13-10-16.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"

@class CompanyDetail;

@interface InformationDetailViewController : BaseUIViewController

@property (strong, nonatomic) UITextView            *appraiseText;
@property (strong, nonatomic) CompanyDetail         *companyDetail;

- (id)initWithObject:(CompanyDetail*)object;

@end


@interface AppraiseStarLevel : UIView<UITabBarDelegate>

@property (strong, nonatomic) NSString              *leftTitle;
@property (strong, nonatomic) NSMutableArray        *levelArray;

- (id)initWithFrame:(CGRect)frame levelNum:(NSInteger)num;

- (void)setLightedStarWithNum:(NSInteger)num;

@end