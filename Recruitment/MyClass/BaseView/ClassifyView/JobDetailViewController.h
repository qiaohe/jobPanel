//
//  JobDetailViewController.h
//  Recruitment
//
//  Created by M J on 13-11-6.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"

@class CompanyDetail;
@class JobInformation;

@interface JobDetailViewController : BaseUIViewController

@property (strong, nonatomic) CompanyDetail         *companyDetail;
@property (strong, nonatomic) JobInformation        *jobInformation;

- (id)initWithDetail:(JobInformation*)jobDetail;


@end
