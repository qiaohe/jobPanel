//
//  EduExperience.h
//  Recruitment
//
//  Created by M J on 13-11-5.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EduExperience : NSObject

@property (strong, nonatomic) NSString                  *startDate;
@property (strong, nonatomic) NSString                  *endDate;
@property (strong, nonatomic) NSString                  *collegeName;
@property (strong, nonatomic) NSString                  *education;
@property (strong, nonatomic) NSString                  *professional;
@property (assign, nonatomic) BOOL                      studyAbroad;

+(NSArray*)getRecommendDataWithNum:(NSInteger)num;

@end
