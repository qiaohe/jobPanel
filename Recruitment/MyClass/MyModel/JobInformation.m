//
//  JobInformation.m
//  Recruitment
//
//  Created by M J on 13-10-21.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "JobInformation.h"

@implementation JobInformation


+(NSArray*)getRecommendDataWithNum:(NSInteger)num
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
        _salary = [NSString stringWithFormat:@"%d万",index];
        switch (index) {
            case 1:{
                _company  = @"网易";
                _position = @"PHP开发";
                _positionNum = @"332588";
                _jobIcon  = @"information_item1";
                _jobArray = [NSMutableArray arrayWithArray:@[@"UI",@"设计",@"前端开发"]];
                _location = @"浦东 上海, 中国";
                _positionDescription = [NSString stringWithFormat:@"%@ %@\n%@\n%@\n%@",_positionNum,@"",@"Location China, Shanghai",@"Job Category Customer Service & Support",@"Division Services & Support"];
                break;
            }case 2:{
                _company  = @"腾讯";
                _position = @"微信团队运营与维护";
                _positionNum = @"467329";
                _jobIcon  = @"information_item2";
                _jobArray = [NSMutableArray arrayWithArray:@[@"高级UE设计师"]];
                _location = @"普陀区 上海, 中国";
                _positionDescription = [NSString stringWithFormat:@"%@\n%@",@"JOB DESCRIPTION:",@"This position represents Microsoft and provides technical support to Microsoft Enterprise Premier Customers across the Asia region with the high customer satisfaction. The candidate is required to be able to identify the root cause and provide our customer with the solution in a timely manner for mission critical issues of Microsoft Windows Server OS."];
                break;
            }case 3:{
                _company  = @"搜狐";
                _position = @"Html游戏开发";
                _positionNum = @"583477";
                _jobIcon  = @"information_item3";
                _jobArray = [NSMutableArray arrayWithArray:@[@"高级Java工程师"]];
                _location = @"徐汇区 上海, 中国";
                _positionDescription = [NSString stringWithFormat:@"%@\r%@\r%@\n%@\n%@\n%@",@"Main Responsibilities:",@"Customer Issue Resolution & Responsiveness",@"- Drive the communication with the customer to ensure the customer has confidence on problem resolution provided by Microsoft",@"- Define and understand the customer issue by creating the adequate reproduction scenarios.",@"- Research, troubleshoot, develop and implement a workaround (if needed) and gain agreement from customer on problem resolving.",@"- Act as the second tier support to take the escalation and solve the customer issue from subsidiary."];
                break;
            }case 4:{
                _company  = @"新浪";
                _position = @"Android高级开发工程师";
                _positionNum = @"101124";
                _jobIcon  = @"information_item4";
                _jobArray = [NSMutableArray arrayWithArray:@[@"UE设计师",@"UI设计师",@"android高级开发工程师"]];
                _location = @"海淀区 北京, 中国";
                _positionDescription = [NSString stringWithFormat:@"%@\r%@\n%@",@"Effective Communication & Collaboration",@"- Identify the right resource to collaborate with for tough & political hot problem.",@"- Collaborate with cross-group peers both"];
                break;
            }
            default:
                break;
        }
        
    }
    return self;
}


@end
