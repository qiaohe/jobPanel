//
//  IndustryInformation.h
//  Recruitment
//
//  Created by M J on 13-11-6.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndustryInformation : NSObject

@property (strong, nonatomic) NSString                  *picture;
@property (strong, nonatomic) NSString                  *title;
@property (strong, nonatomic) NSString                  *detail;
@property (strong, nonatomic) NSString                  *location;
@property (strong, nonatomic) NSString                  *description;

+(NSArray*)getRecommendDataWithNum:(NSInteger)num;

@end
