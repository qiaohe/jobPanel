//
//  CompanyDetail.m
//  Recruitment
//
//  Created by M J on 13-10-25.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "CompanyDetail.h"

@implementation CompanyDetail

+(NSArray*)getCommentDataWithNum:(NSInteger)num
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<num; i++) {
        CompanyDetail *detail = [[CompanyDetail alloc]init];
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
                _title              = @"网易";
                _companyLogo        = @"information_item1";
                _jobArray           = [NSMutableArray arrayWithArray:@[@"UI",@"设计",@"前端开发"]];
                _location           = @"浦东 上海, 中国";
                _companyDetail      = @"做有态度的门户网站(网聚人的力量)";
                _companyDescription = @"网易公司（NASDAQ：NTES），是中国主要门户网站，和新浪网、搜狐网、腾讯网并称为“中国四大门户”。网易在开发互联网应用、服务及其它技术方面始终保持中国内业界的领先地位。自1997年6月创立以来，凭借先进的技术和优质的服务，网易深受广大网民的欢迎，曾两次被中国互联网络信息中心（CNNIC）评选为中国十佳网站之首。目前提供网络游戏、电子邮件、新闻、博客、搜索引擎、论坛、虚拟社区等服务。";
                _companyProperty    = @"门户网站";
                _companySize        = @"大型(1000人以上)";
                _collectNum         = 250;
                _appraise           = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"",@""
                                       , nil];
                break;
            }case 2:{
                _title              = @"腾讯";
                _companyLogo  = @"information_item2";
                _jobArray = [NSMutableArray arrayWithArray:@[@"高级UE设计师"]];
                _location = @"普陀区 上海, 中国";
                _companyDetail      = @"打造精彩在线生活(通过互联网服务提升人类生活品质)";
                _companyDescription = @"腾讯公司（腾讯控股有限公司）成立于1998年11月，是目前中国最大的互联网综合服务提供商之一，也是中国服务用户最多的互联网企业之一。成立十多年以来一直秉承一切以用户价值为依归的经营理念，始终处于稳健、高速发展的状态。把为用户提供“一站式在线生活服务”作为战略目标，提供互联网增值服务、移动及电信增值服务和网络广告服务。通过即时通信QQ、腾讯网、腾讯游戏、QQ空间、腾讯微博、搜搜、拍拍、财付通、微信等中国领先的网络平台，腾讯打造了中国最大的网络社区，满足互联网用户沟通、资讯、娱乐和电子商务等方面的需求。";
                _companyProperty    = @"门户网站";
                _companySize        = @"大型(1000人以上)";
                _collectNum         = 380;
                _appraise           = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"",@""
                                       , nil];
                break;
            }case 3:{
                _title              = @"新浪";
                _companyLogo  = @"information_item3";
                _jobArray = [NSMutableArray arrayWithArray:@[@"高级Java工程师"]];
                _location = @"徐汇区 上海, 中国";
                _companyDetail      = @"一切由你开始";
                _companyDescription = @"新浪（NASDAQ:SINA)，是一家网络公司的名称， 和搜狐、网易、腾讯并称为“中国四大门户网站”。以服务大中华地区与海外华人为己任，新浪拥有多家地区性网站，通过旗下五大业务主线为用户提供网络服务，网下的北京新浪、香港新浪、台北新浪、北美新浪等覆盖全球华人社区的全球最大中文门户网站。2012年11月新浪注册用户突破4亿。许良杰为首席技术官(CTO)兼联席总裁。";
                _companyProperty    = @"门户网站";
                _companySize        = @"大型(1000人以上)";
                _collectNum         = 490;
                _appraise           = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"",@""
                                       , nil];
                break;
            }case 4:{
                _title              = @"搜狐";
                _companyLogo  = @"information_item4";
                _jobArray = [NSMutableArray arrayWithArray:@[@"UE设计师",@"UI设计师",@"android高级开发工程师"]];
                _location = @"海淀区 北京, 中国";
                _companyDetail      = @"中国最大的门户网站(足及生活每一天)";
                _companyDescription = @"1995年搜狐创始人张朝阳从美国麻省理工学院毕业回到中国，利用风险投资创建了爱特信信息技术有限公司，1998年正式推出搜狐网。2000年搜狐在美国纳斯达克证券市场上市。搜狐公司是2008北京奥运会互联网内容服务赞助商，是中国最领先的新媒体、通信及移动增值服务公司，是中文世界最强劲的互联网品牌。“搜狐”在中国是家喻户晓的名字。是中国网民上网冲浪的首选门户网站。作为中国互联网门户网站的领航者，搜狐将继续引领和探索中国特色互联网媒体之路，让丰富资讯为亿万网民服务。尽管搜狐在首页标题声称自己是中国最大的门户网站，但其Alexa排名却低于同类门户网站新浪和网易。2011年4月22日搜狐荣获2010-2011年度中国最具影响力互联网企业奖。2011年9月13日，《财富》杂志公布2011年全球“100家增长最快的公司”，搜狐排名第89位。";
                _companyProperty    = @"门户网站";
                _companySize        = @"大型(1000人以上)";
                _collectNum         = 500;
                _appraise           = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"",@""
                                       , nil];
                break;
            }
            default:
                break;
        }
    }
    return self;
}


@end
