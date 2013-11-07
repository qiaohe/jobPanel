//
//  JobInformation.h
//  Recruitment
//
//  Created by M J on 13-10-21.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobInformation : NSObject

@property (strong, nonatomic) NSMutableArray            *jobArray;
@property (strong, nonatomic) NSString                  *jobIcon;
@property (strong, nonatomic) NSString                  *company;
@property (strong, nonatomic) NSString                  *position;
@property (strong, nonatomic) NSString                  *positionNum;
@property (strong, nonatomic) NSString                  *positionDescription;
@property (strong, nonatomic) NSString                  *salary;
@property (strong, nonatomic) NSString                  *location;
@property (strong, nonatomic) NSString                  *title;
@property (strong, nonatomic) NSString                  *detail;
@property (strong, nonatomic) NSString                  *creationTime;

+(NSArray*)getRecommendDataWithNum:(NSInteger)num;

@end
