//
//  CompanyDetailViewController.h
//  Recruitment
//
//  Created by M J on 13-11-1.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"
#import "IndustryInformation.h"

#define             CompanyText         [NSString stringWithFormat:@"%@\n%@\n\r%@\n\r    %@\n\r%@\n\r    %@",@"观点：中国存款利率尚不宜放开",@"专栏：中国的利率市场化假象",@"东风汽车对与标致雪铁龙的谈判持谨慎态度",@"东风汽车公司总经理朱福寿周六暗示，公司在继续就投资标致雪铁龙谈判时将谨慎行事。知情人士称，最近几个月东风汽车一直在讨论收购标致雪铁龙不超过30%的股权。",@"徽商银行拟通过香港IPO筹资至多13亿美元",@"知情人士上周六表示，徽商银行计划通过香港首次公开募股筹资至多13亿美元，并将从周二开始接受认购。该行成为近几周来第二家进行股权融资的小型中资银行。"]

@interface CompanyDetailViewController : BaseUIViewController

@property (strong, nonatomic) IndustryInformation           *information;

- (id)initWithIndustryInformation:(IndustryInformation*)information;

@end
