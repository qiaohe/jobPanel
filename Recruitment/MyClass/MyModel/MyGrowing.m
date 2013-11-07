//
//  MyGrowing.m
//  Recruitment
//
//  Created by M J on 13-10-22.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "MyGrowing.h"
#import "Utils.h"

@implementation MyGrowing

- (id)init
{
    self = [super init];
    if (self) {
        _title = @"我的成长";
        NSString *currentDate = [Utils stringWithDate:[NSDate date] withFormat:@"yyyy年MM月dd日 / HH:mm"];
        float diff = [[Utils dateWithString:currentDate withFormat:@"yyyy年MM月dd日 / HH:mm"] timeIntervalSince1970] - [[Utils dateWithString:@"2013年01月01日 / 00:00" withFormat:@"yyyy年MM月dd日 / HH:mm"] timeIntervalSince1970];
        double val = floorf(((double)arc4random() / ARC4RANDOM_MAX) * diff) + [[Utils dateWithString:@"2013年01月01日 / 00:00" withFormat:@"yyyy年MM月dd日 / HH:mm"] timeIntervalSince1970];
        switch (arc4random()%3) {
            case 0:
                _image = imageNameAndType(@"grow_item1", nil);
                _detail = @"这是一是首简单的小情歌。。。忙碌了半天的作品。。。";
                break;
            case 1:
                _image = imageNameAndType(@"grow_item2", nil);
                _detail = @"终于搞定了。。。累死啦。。。";
                break;
            case 2:
                _image = imageNameAndType(@"grow_item3", nil);
                _detail = @"哦。搞定了。。。可以睡觉了。。。";
                break;
            default:
                break;
        }
        _date = [Utils stringWithDate:[NSDate dateWithTimeIntervalSince1970:val] withFormat:@"yyyy年MM月dd日 / HH:mm"];
    }
    return self;
}

+ (NSArray*)getMyGrowsWithNum:(NSInteger)num
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<num; i++) {
        MyGrowing *growing = [[MyGrowing alloc]init];
        [array addObject:growing];
    }
    return array;
}

@end
