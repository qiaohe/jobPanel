//
//  JobInformation.m
//  Recruitment
//
//  Created by M J on 13-10-21.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "JobInformation.h"

@implementation JobInformation


+(NSArray*)getCommentDataWithNum:(NSInteger)num
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<num; i++) {
        JobInformation *detail = [[JobInformation alloc]init];
        [array addObject:detail];
    }
    return array;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSInteger index = (arc4random() % 4 ) + 1;
        switch (index) {
            case 1:{
                _title    = @"UI设计";
                _jobIcon  = @"information_item1";
                _jobArray = [NSMutableArray arrayWithArray:@[@"UI",@"设计",@"前端开发"]];
                _location = @"浦东 上海, 中国";
                break;
            }case 2:{
                _jobIcon  = @"information_item2";
                _jobArray = [NSMutableArray arrayWithArray:@[@"高级UE设计师"]];
                _location = @"普陀区 上海, 中国";
                break;
            }case 3:{
                _jobIcon  = @"information_item3";
                _jobArray = [NSMutableArray arrayWithArray:@[@"高级Java工程师"]];
                _location = @"徐汇区 上海, 中国";
                break;
            }case 4:{
                _jobIcon  = @"information_item4";
                _jobArray = [NSMutableArray arrayWithArray:@[@"UE设计师",@"UI设计师",@"android高级开发工程师"]];
                _location = @"海淀区 北京, 中国";
                break;
            }
            default:
                break;
        }
    }
    return self;
}


@end
