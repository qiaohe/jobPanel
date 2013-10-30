//
//  RecommendJob.h
//  Recruitment
//
//  Created by M J on 13-10-28.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendJob : NSObject

@property (strong, nonatomic) NSMutableArray            *jobArray;
@property (strong, nonatomic) NSString                  *companyLogo;
@property (strong, nonatomic) NSString                  *title;
@property (strong, nonatomic) NSString                  *detail;
@property (strong, nonatomic) NSString                  *location;
@property (strong, nonatomic) NSString                  *creationTime;

@property (strong, nonatomic) NSString                  *companyDetail;
@property (strong, nonatomic) NSString                  *companyDescription;
@property (strong, nonatomic) NSString                  *companyProperty;
@property (strong, nonatomic) NSString                  *companySize;

@property (assign, nonatomic) NSInteger                 collectNum;
@property (strong, nonatomic) NSMutableDictionary       *appraise;

+(NSArray*)getCommentDataWithNum:(NSInteger)num;

@end
