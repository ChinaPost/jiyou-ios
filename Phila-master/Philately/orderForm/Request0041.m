//
//  Request0041.m
//  Philately
//
//  Created by gdpost on 15/7/14.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "Request0041.h"
#import "ProductOrderForm.h"

@implementation Request0041

@synthesize  delegate;

/*订单详情0041*/
NSString  *nn0041=@"JY0041";
/*订单详情0041*/
-(void) request0041:(NSString *)orderNo
{

    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 备注:必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    /* 订单号 备注:必填*/
    [businessparam setValue:orderNo forKey:@"orderNo"];
    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:nn0041 business:businessparam delegate:self viewController:self];
    
    
}




-(void) ReturnError:(MsgReturn*)msgReturn
{
    NSLog(@"sa");
}


-(void) ReturnData:(MsgReturn*)msgReturn
{
    
    /*订单详情0041*/
    if ([msgReturn.formName isEqualToString:nn0041]){
        
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        [delegate jy0041Result:returnDataBody];
//   
//        RespondParam0041 *commonItem=[[RespondParam0041 alloc]init];
//        /* 订单号 备注:*/
//        commonItem.orderNo=[returnDataBody objectForKey:@"orderNo"];
//        /* 业务代号 备注:*/
//        commonItem.busiNo=[returnDataBody objectForKey:@"busiNo"];
//        /* 渠道代号 备注:*/
//        commonItem.channelNo=[returnDataBody objectForKey:@"channelNo"];
//        /* 支付方式 备注:*/
//        commonItem.payType=[returnDataBody objectForKey:@"payType"];
//        /* 下单日期 备注:*/
//        commonItem.bookDate=[returnDataBody objectForKey:@"bookDate"];
//        /* 处理机构 备注:*/
//        commonItem.dealBrch=[returnDataBody objectForKey:@"dealBrch"];
//        /* 支付状态 备注:*/
//        commonItem.payStatus=[returnDataBody objectForKey:@"payStatus"];
//        /* 处理状态 备注:*/
//        commonItem.dealStatus=[returnDataBody objectForKey:@"dealStatus"];
//        /* 配送方式 备注:自提方式：自提网点代号 、自提码生效；
//         寄递方式：收件人信息 生效*/
//        commonItem.shipType=[returnDataBody objectForKey:@"shipType"];
//        /* 自提网点代号 备注:*/
//        commonItem.brchNo=[returnDataBody objectForKey:@"brchNo"];
//        /* 自提码 备注:*/
//        commonItem.toTheCode=[returnDataBody objectForKey:@"toTheCode"];
//        /* 收货人姓名 备注:收件人信息*/
//        commonItem.recvName=[returnDataBody objectForKey:@"recvName"];
//        /* 详细地址 备注:*/
//        commonItem.detailAddress=[returnDataBody objectForKey:@"detailAddress"];
//        /* 收件手机号码 备注:*/
//        commonItem.mobileNo=[returnDataBody objectForKey:@"mobileNo"];
//        /* 邮编 备注:*/
//        commonItem.postCode=[returnDataBody objectForKey:@"postCode"];
//        /* 订单总金额 备注:*/
//        commonItem.orderAmt=[[returnDataBody objectForKey:@"orderAmt"] floatValue];
//        /* 商品总金额 备注:*/
//        commonItem.merchAmt=[[returnDataBody objectForKey:@"merchAmt"] floatValue];
//        /* 配送费用 备注:*/
//        commonItem.shipFee=[[returnDataBody objectForKey:@"shipFee"] floatValue];
//        /* 已付金额 备注:*/
//        commonItem.hasPayMoney=[[returnDataBody objectForKey:@"hasPayMoney"] floatValue];
//        /* 订单备注信息 备注:*/
//        commonItem.orderRemark=[returnDataBody objectForKey:@"orderRemark"];
//        /* 发票开具类型 备注:不开、个人、单位*/
//        commonItem.invoiceType=[returnDataBody objectForKey:@"invoiceType"];
//        /* 发票抬头 备注:当发票类型为“单位”时生效*/
//        commonItem.invoiceTitle=[returnDataBody objectForKey:@"invoiceTitle"];
//        /* 预处理单号 备注:个性化定制业务才有预处理单号*/
//        commonItem.prepNumber=[returnDataBody objectForKey:@"prepNumber"];
//        /* 操作类型 备注:支付、取消、换货等*/
//        commonItem.operationType=[returnDataBody objectForKey:@"operationType"];
//        /* 操作截止日期 备注:*/
//        commonItem.operationEndDate=[returnDataBody objectForKey:@"operationEndDate"];
//        /* 处理时间 备注:yymmddhhmmss*/
//        commonItem.dealTime=[returnDataBody objectForKey:@"dealTime"];
//        /* 处理类型 备注:*/
//        commonItem.dealType=[returnDataBody objectForKey:@"dealType"];
//        /* 处理内容 备注:*/
//        commonItem.dealContent=[returnDataBody objectForKey:@"dealContent"];
//        /* 处理人 备注:*/
//        commonItem.dealPerson=[returnDataBody objectForKey:@"dealPerson"];
//        /* 事件类型 备注:退款、补款、摇号、换货*/
//        commonItem.eventType=[returnDataBody objectForKey:@"eventType"];
//        /* 事件状态 备注:未审核、审核通过、审核不通过等*/
//        commonItem.eventStatus=[returnDataBody objectForKey:@"eventStatus"];
//        /* 事件描述 备注:*/
//        commonItem.eventDesc=[returnDataBody objectForKey:@"eventDesc"];
//        /* 支付流水 备注:*/
//        commonItem.paySeq=[returnDataBody objectForKey:@"paySeq"];
//        /* 支付流水状态 备注:支付、退款、补款*/
//        commonItem.paySeqStatus=[returnDataBody objectForKey:@"paySeqStatus"];
//        /* 金额 备注:*/
//        commonItem.payMoney=[[returnDataBody objectForKey:@"payMoney"] floatValue];
//        /* 流水操作状态 备注:*/
//        commonItem.payOperStatus=[returnDataBody objectForKey:@"payOperStatus"];
//        /* 操作时间 备注:*/
//        commonItem.payDealTime=[returnDataBody objectForKey:@"payDealTime"];
//        /* 银行流水 备注:*/
//        commonItem.bankSeq=[returnDataBody objectForKey:@"bankSeq"];
//        /* 备注 备注:*/
//        commonItem.payRemark=[returnDataBody objectForKey:@"payRemark"];
//        
//        
//        
//        /* 子订单数量 备注:循环域开始*/
//        commonItem.subOrderNum=[[returnDataBody objectForKey:@"subOrderNum"] intValue];
//        for (int i=0; i<commonItem.subOrderNum; i++) {
//            
//            RespondParam0041 *commonItem1=[[RespondParam0041 alloc]init];
//            
//            /* 子订单号 备注:*/
//            commonItem1.subOrderNo1=[returnDataBody objectForKey:@"subOrderNo1"][i];
//            /* 子订单状态 备注:*/
//            commonItem1.subOrderStatus=[returnDataBody objectForKey:@"subOrderStatus"][i];
//            /* 子订单总金额 备注:*/
//            commonItem1.subOrderAmt=[[returnDataBody objectForKey:@"subOrderAmt"][i] floatValue];
//            /* 商品总金额 备注:*/
//            commonItem1.subMerchAmt=[[returnDataBody objectForKey:@"subMerchAmt"][i] floatValue];
//            /* 配送费用 备注:*/
//            commonItem1.subShipFee=[[returnDataBody objectForKey:@"subShipFee"][i] floatValue];
//            /* 子订单数量 备注:循环域结束*/
//            // commonItem.subOrderNum=[[returnDataBody objectForKey:@"subOrderNum"] intValue];
//            
//            
//        }
//        
//        /* 子订单号 备注:*/
//        commonItem.subOrderNo2=[returnDataBody objectForKey:@"subOrderNo2"];
//        for (int i=0; i<commonItem.subOrderNo2; i++) {
//            
//            RespondParam0041 *commonItem2=[[RespondParam0041 alloc]init];
//            /* 处理时间 备注:yymmddhhmmss*/
//            commonItem2.subdealTime=[returnDataBody objectForKey:@"subdealTime"][i];
//            /* 处理类型 备注:*/
//            commonItem2.subdealType=[returnDataBody objectForKey:@"subdealType"][i];
//            /* 处理内容 备注:*/
//            commonItem2.subdealContent=[returnDataBody objectForKey:@"subdealContent"][i];
//            /* 处理人 备注:*/
//            commonItem2.subdealPerson=[returnDataBody objectForKey:@"subdealPerson"][i];
//            /* 子订单号 备注:*/
//            commonItem2.subOrderNo3=[returnDataBody objectForKey:@"subOrderNo3"][i];
//            /* 物流公司 备注:*/
//            commonItem2.logistCompany=[returnDataBody objectForKey:@"logistCompany"][i];
//            /* 物流单号 备注:yymmddhhmmss*/
//            commonItem2.logistNum=[returnDataBody objectForKey:@"logistNum"][i];
//            /* 处理时间 备注:yymmddhhmmss*/
//            commonItem2.logistDealTime=[returnDataBody objectForKey:@"logistDealTime"][i];
//            /* 商品代号 备注:*/
//            commonItem2.merchID=[returnDataBody objectForKey:@"merchID"][i];
//            /* 图片ID 备注:*/
//            commonItem2.merchPicID=[returnDataBody objectForKey:@"merchPicID"][i];
//            /* 商品名称 备注:*/
//            commonItem2.merchName=[returnDataBody objectForKey:@"merchName"][i];
//            /* 商品规格 备注:*/
//            commonItem2.normsType=[returnDataBody objectForKey:@"normsType"][i];
//            /* 模式单价 备注:*/
//            commonItem2.normsPrice=[[returnDataBody objectForKey:@"normsPrice"][i] floatValue];
//            /* 商品购买数量 备注:*/
//            commonItem2.merchNum=[[returnDataBody objectForKey:@"merchNum"][i] intValue];
//        }
//        
        
    }

}



@end
