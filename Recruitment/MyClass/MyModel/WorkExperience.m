//
//  WorkExperience.m
//  Recruitment
//
//  Created by M J on 13-11-5.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "WorkExperience.h"

@implementation WorkExperience


+(NSArray*)getRecommendDataWithNum:(NSInteger)num
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<num; i++) {
        WorkExperience *detail = [[WorkExperience alloc]init];
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
                _workCompany                = @"网易公司（NASDAQ：NTES）";
                _startDate                  = @"2010/05/11";
                _endDate                    = @"2011/07/23";
                _position                   = @"游戏开发工程师";
                _positionDescription        = @"";
                _industry                   = @"游戏开发";
                _companyProperty            = @"门户网站";
                _companySize                = @"大型(1000人以上)";
                break;
            }case 1:{
                _workCompany                = @"腾讯公司（腾讯控股有限公司）";
                _startDate                  = @"2009/06/11";
                _endDate                    = @"2013/01/22";
                _position                   = @"运营主管";
                _positionDescription        = @"";
                _industry                   = @"管理";
                _companyProperty            = @"门户网站";
                _companySize                = @"大型(1000人以上)";
                break;
            }case 2:{
                _workCompany                = @"搜狐网";
                _startDate                  = @"2011/06/11";
                _endDate                    = @"2013/10/01";
                _position                   = @"移动客户端开发";
                _positionDescription        = @"ios、android移动端应用开发";
                _industry                   = @"软件开发";
                _companyProperty            = @"门户网站";
                _companySize                = @"大型(1000人以上)";
                break;
            }
            default:
                break;
        }
        
    }
    return self;
}

@end
