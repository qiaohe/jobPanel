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

static NSInteger indexNum = 0;

- (id)init
{
    self = [super init];
    if (self) {
        _isUnfold = NO;
        indexNum = indexNum%4;

        NSLog(@"indexNum = %d",indexNum);
        
        _trends = [NSMutableArray arrayWithArray:[ContactTrends getCommendData:indexNum]];

        switch (indexNum) {
            case 0:{
                _contactName    = @"潘小强";
                _userPicture  = @"contact_item1";

                _jobArray = [NSMutableArray arrayWithArray:@[@"UI",@"设计",@"前端开发"]];
                _location = @"浦东 上海, 中国";
                break;
            }case 1:{
                _contactName    = @"陈小阳";
                _userPicture  = @"contact_item4";
                _jobArray = [NSMutableArray arrayWithArray:@[@"高级UE设计师"]];
                _location = @"广州";
                break;
            }case 2:{
                _contactName  = @"张小顺";
                _userPicture  = @"contact_item3";
                _jobArray = [NSMutableArray arrayWithArray:@[@"UE设计师",@"UI设计师",@"android高级开发工程师"]];
                _location = @"海淀区 北京, 中国";
                break;
            }case 3:{
                _contactName  = @"马小亮";
                _userPicture  = @"contact_item2";
                _jobArray = [NSMutableArray arrayWithArray:@[@"UE设计师",@"UI设计师",@"android高级开发工程师"]];
                _location = @"新西兰";
                break;
            }
            default:{
                
                break;
            }
                
        }
        _myGrowings = [NSMutableArray arrayWithArray:[MyGrowing getMyGrowsWithNum:indexNum]];
    }
    indexNum ++;
    return self;
}

+ (NSArray*)getContactsWithNum:(NSInteger)num
{
    indexNum = 0;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<num; i++) {
        Contacts *contact = [[Contacts alloc]init];
        [array addObject:contact];
    }
    return array;
}

@end

@interface ContactTrends ()

@end

static NSInteger trendsIndex = 0;

@implementation ContactTrends

- (id)init
{
    self = [super init];
    if (self) {        

        switch (trendsIndex) {
            case 0:{
                _trendsTitle    = @"新职位";
                _trendsDetail   = @"CTO";
                break;
            }case 1:{
                _trendsTitle   = @"新公司";
                _trendsDetail   = @"卓攀科技上海有限公司";
                break;
            }case 2:{
                _trendsTitle   = @"新发展";
                _trendsDetail   = @"独立高级顾问";
                break;
            }case 3:{
                _trendsTitle   = @"新工作地点";
                _trendsDetail   = @"新西兰";
                break;
            }
            default:
                break;
        }
    }
    trendsIndex ++;
    return self;
}

+ (NSArray*)getCommendData:(NSInteger)num
{
    num = num > 1?num:2;
    trendsIndex = 0;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<num; i++) {
        ContactTrends *detail = [[ContactTrends alloc]init];
        [array addObject:detail];
    }
    return array;
}


@end

