//
//  WorkExperience.h
//  Recruitment
//
//  Created by M J on 13-11-5.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkExperience : NSObject

@property (strong, nonatomic) NSString              *workCompany;
@property (strong, nonatomic) NSString              *startDate;
@property (strong, nonatomic) NSString              *endDate;
@property (strong, nonatomic) NSString              *position;
@property (strong, nonatomic) NSString              *positionDescription;

@property (strong, nonatomic) NSString              *industry;
@property (strong, nonatomic) NSString              *companyProperty;
@property (strong, nonatomic) NSString              *companySize;

+(NSArray*)getRecommendDataWithNum:(NSInteger)num;

@end
