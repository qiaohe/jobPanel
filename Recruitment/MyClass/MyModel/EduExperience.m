//
//  EduExperience.m
//  Recruitment
//
//  Created by M J on 13-11-5.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "EduExperience.h"

@implementation EduExperience

+(NSArray*)getRecommendDataWithNum:(NSInteger)num
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<num; i++) {
        EduExperience *detail = [[EduExperience alloc]init];
        [array addObject:detail];
    }
    return array;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSInteger randomNum = arc4random()%3;
        switch (randomNum) {
            case 0:{
                _startDate          = @"2007/09/01";
                _endDate            = @"2011/06/25";
                _collegeName        = @"复旦大学";
                _education          = @"本科";
                _professional       = @"工商管理学";
                _studyAbroad        = NO;
                break;
            }case 1:{
                _startDate          = @"2007/09/01";
                _endDate            = @"2011/06/25";
                _collegeName        = @"上海交通大学";
                _education          = @"本科";
                _professional       = @"计算机科学-软件工程";
                _studyAbroad        = NO;
                break;
            }case 2:{
                _startDate          = @"2005/09/01";
                _endDate            = @"2009/06/25";
                _collegeName        = @"斯坦福学院";
                _education          = @"硕士";
                _professional       = @"人文与科学";
                _studyAbroad        = YES;
                break;
            }
            default:
                break;
        }
        
    }
    return self;
}

@end
