//
//  IndustryInformation.m
//  Recruitment
//
//  Created by M J on 13-11-6.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "IndustryInformation.h"

@implementation IndustryInformation


+(NSArray*)getRecommendDataWithNum:(NSInteger)num
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<num; i++) {
        IndustryInformation *detail = [[IndustryInformation alloc]init];
        [array addObject:detail];
    }
    return array;
}

- (id)init
{
    self = [super init];
    if (self) {
        static NSInteger index = 0;
        index = index % 3;
        switch (index) {
            case 0:{
                _title      = @"中国改革注册资本登记制度 降低准入门槛";
                _picture    = @"information_item1";
                _detail     = [NSString stringWithFormat:@"%@\r%@\r%@",@"中国国务院周日宣布，将改革公司注册资本登记制度，取消部分新成立公司的注册资本登记条件。",@"吴敬琏：下一次改革关键是政治体制 ",@"专栏：中国改革的“深水区”究竟在哪里？"];
                _location   = @"普陀区,上海";
                break;
            }case 1:{
                _title      = @"更新：中国央行推出商业银行贷款基础利率";
                _picture    = @"information_item2";
                _detail     = @"中国央行周五针对商业银行的最优质公司客户推出了一种新的优惠贷款利率，朝着利率市场化迈出了关键一步。建行按贷款基础利率与两家公司签署贷款协议.";
                _location   = @"徐汇区,上海";
                break;
            }case 2:{
                _title      = @"东风汽车对与标致雪铁龙的谈判持谨慎态度";
                _picture    = @"information_item3";
                _detail     = @"东风汽车公司总经理朱福寿周六暗示，公司在继续就投资标致雪铁龙谈判时将谨慎行事。知情人士称，最近几个月东风汽车一直在讨论收购标致雪铁龙不超过30%的股权。";
                _location   = @"海淀区,北京";
                break;
            }case 3:{
                _title      = @"徽商银行拟通过香港IPO筹资至多13亿美元";
                _picture    = @"information_item4";
                _detail     = @"知情人士上周六表示，徽商银行计划通过香港首次公开募股筹资至多13亿美元，并将从周二开始接受认购。该行成为近几周来第二家进行股权融资的小型中资银行。";
                _location   = @"浦东新区,上海";
                break;
            }
            default:
                break;
        }
        index ++;
    }
    return self;
}


@end
