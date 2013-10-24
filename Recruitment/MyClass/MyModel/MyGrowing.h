//
//  MyGrowing.h
//  Recruitment
//
//  Created by M J on 13-10-22.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyGrowing : NSObject

@property (strong, nonatomic) NSString              *date;
@property (strong, nonatomic) NSString              *title;
@property (strong, nonatomic) NSString              *detail;
@property (strong, nonatomic) UIImage               *image;

+ (NSArray*)getMyGrowsWithNum:(NSInteger)num;

@end
