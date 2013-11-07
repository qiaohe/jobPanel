//
//  MyResumeDetail.h
//  Recruitment
//
//  Created by M J on 13-10-18.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyResumeDetail : NSObject

@property (strong, nonatomic) NSString                  *resumeName;
@property (strong, nonatomic) UIImage                   *userPicture;
@property (strong, nonatomic) NSString                  *name;
@property (strong, nonatomic) NSString                  *currentJob;
@property (strong, nonatomic) NSString                  *currentCompany;
@property (strong, nonatomic) NSString                  *birthDate;
@property (strong, nonatomic) NSMutableArray            *jobArray;
@property (strong, nonatomic) NSString                  *location;
@property (strong, nonatomic) NSString                  *creationTime;
@property (strong, nonatomic) NSMutableArray            *commentDataSource;

+(NSArray*)getRecommendDataWithNum:(NSInteger)num;

@end
