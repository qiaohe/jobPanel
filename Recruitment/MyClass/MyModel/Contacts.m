//
//  Contacts.m
//  Recruitment
//
//  Created by M J on 13-10-16.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "Contacts.h"
#import "MyGrowing.h"

@implementation Contacts

- (id)init
{
    self = [super init];
    if (self) {
        _isUnfold = NO;
        NSInteger index = (arc4random() % 3 ) + 1;
        switch (index) {
            case 1:{
                _title    = @"UI Design";
                _userPicture  = @"contact_item1";
                _jobArray = [NSMutableArray arrayWithArray:@[@"UI",@"设计",@"前端开发"]];
                _location = @"浦东 上海, 中国";
                break;
            }case 2:{
                _userPicture  = @"contact_item2";
                _jobArray = [NSMutableArray arrayWithArray:@[@"高级UE设计师"]];
                _location = @"普陀区 上海, 中国";
                break;
            }case 3:{
                _userPicture  = @"contact_item3";
                _jobArray = [NSMutableArray arrayWithArray:@[@"UE设计师",@"UI设计师",@"android高级开发工程师"]];
                _location = @"海淀区 北京, 中国";
                break;
            }
            default:{
                
                break;
            }
                
        }
        _myGrowings = [NSMutableArray arrayWithArray:[MyGrowing getMyGrowsWithNum:index]];
    }
    return self;
}

+ (NSArray*)getContactsWithNum:(NSInteger)num
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<num; i++) {
        Contacts *contact = [[Contacts alloc]init];
        [array addObject:contact];
    }
    return array;
}

@end
