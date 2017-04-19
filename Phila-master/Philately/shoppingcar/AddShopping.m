//
//  AddShopping.m
//  Philately
//
//  Created by gdpost on 15/7/9.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "AddShopping.h"
#import  "RespondParam0020.h"
#import "RespondParam0033.h"
#import "SqlApp.h"

#import "RespondParam0050.h"

@implementation AddShopping
@synthesize addShoppingDelegate;
@synthesize stepCount;





NSMutableArray *typeProducts;// RespondParam0026* typeProduct ;

NSString *productId;

NSMutableDictionary *steps;

UIViewController *viewControld;


-(void)shoppingUnionCheck:(NSString*)mproductId businNo:(NSString*)mbusinNo typeProduct:(NSMutableArray*)typeProduct  delegate:(id) delegate

{
    if (typeProduct==nil || (typeProduct!=nil && [typeProduct count]<=0)) {
        return;
    }
    
    
    viewControld=delegate;
    self.addShoppingDelegate=delegate;
    
    typeProducts=typeProduct;
   
    productId=mproductId;
    
    
     steps=[[NSMutableDictionary alloc] init] ;
    
    SqlApp *sqlApp=[[SqlApp alloc] init];
    NSMutableArray *rows = [sqlApp selectPM_SHOPPINGCHECK_FUNCINFO:mbusinNo];
    for (rowApp *row in rows) {
      NSString *className=row.CLASSNAME;
      NSString *funName= row.FUNCNAME;
        
        
      NSString *seq= row.CALLSEQ;
        [steps setObject:funName forKey:seq ];
        
    }
    
    stepCount=1;
    [self gotoWhere:stepCount];
    
}

-(void ) gotoWhere:(int)step
{
   // dispatch_async(dispatch_get_main_queue(), ^{
        NSString *name= [steps objectForKey:[NSString stringWithFormat:@"%d",step] ];
      
        if ([name isEqualToString:@"shopNumCheck"]) {
            [self  shopNumCheck];
        }else  if ([name isEqualToString:@"shopQualiCheck"])
        {
            [self shopQualiCheck ];
        }else  if ([name isEqualToString:@"stampAddShopping"])
        {
            [self stampAddShopping];
        }
        else  if ([name isEqualToString:@"gxhAddShopping"])
        {
            [self gxhAddShopping];
        }
 
   // });
    

}

-(void)shopNumCheck
{
    
//    说明：购买数量检查
//    
//    1）声明本地变量 MsgReturn msgReturn，初始化为 msgReturn.mErrorMsg.errorCode 为“0000”；
//    2）根据以下KEY获取对应的值：
//    cstmNo	会员编号
//    merchID	商品代号
//    recordNum	循环域开始
//    normsType	商品规格：数组
//    merchNum	购买数量：数组
//    recordNum	循环域结算
//    3）如果选购商品数量为0：
//    a）如果商品规格数量为1（则只有一种规格），则赋值 msgReturn.mErrorMsg.errorCode 为“0017 购买数量最小为1”；
//    b）如果商品规格数量大于1（单件或者四方连），则再判断两者规格是否都为0，如果是，则赋值 msgReturn.mErrorMsg.errorCode 为“0017 购买数量最小为1”；
//    
//    4）调用“会员已购商品查询（JY0020）”交易，上送报文为：
//    上送报文说明：
//    cstmNo	会员编号：取KEY“cstmNo”对应的值
//    merchID	商品代号：取KEY“merchIDo”对应的值
//    5）将交易返回交易的错误对象赋值到本地msgReturn；
//    6）msgReturn.mErrorMsg.errorCode为“0000”则检查：
//    a）已经购物检查：传入的购买数量 + 下发报文对应商品规格的“已购数量（buyNum）” 是否大于 下发报文“限购数量（limitNum）”，如果      是，则msgReturn.mErrorMsg.errorCode赋值“0018 购买数量超过限购数量”；.
//    b）库存检查：传入的购买数量 是否大于 下发报文对应商品规格的“库存数量（stockNum）”，如果是，则msgReturn.mErrorMsg.errorCode赋值“0021 您
//    选购的商品数量已超过库存数量”；
//    7）返回本地变量 msgReturn；
    
  

    bool hasCheck=false;
    for (RespondParam0026 *type in typeProducts ) {
        
        if ( type.isCheck) {
            hasCheck=true;
        }
    }
    
    if(hasCheck==false)
    {
        MsgReturn  *msgReturn=[[MsgReturn alloc ] init ];
        msgReturn.errorCode=@"0999";
        msgReturn.errorDesc=@"请选择规格";
        msgReturn.errorType=@"02";
        [self.addShoppingDelegate addShoppingDelegateCallBack:msgReturn];      
        return;
    }
    
    
    bool hasCheckNum=false;
    for (RespondParam0026 *type in typeProducts ) {
        
        if ( type.checkNum>0) {
            hasCheckNum=true;
        }
    }
    
    if (hasCheckNum) {
        
        [self request0020];
        
    }else
    {
        MsgReturn  *msgReturn=[[MsgReturn alloc ] init ];
        msgReturn.errorCode=@"0017";
        msgReturn.errorDesc=@"购买数量不能小于1";
        msgReturn.errorType=@"02";
        [self.addShoppingDelegate addShoppingDelegateCallBack:msgReturn];
    }

}


-(void)shopQualiCheck
{
    
//    说明：购买资格检查
//    
//    1）声明本地变量 MsgReturn msgReturn，初始化为 msgReturn.mErrorMsg.errorCode 为“0000”；
//    2）根据以下KEY获取对应的值：
//    cstmNo	会员编号
//    cstmName	姓名
//    merchID	商品代号
//    recordNum	循环域开始： 新邮预订业务等于1
//    normsType	商品规格：数组
//    merchNum	购买数量：数组
//    recordNum	循环域结束
//    3）调用“新邮预定资格校验（JY0031）”交易，上送报文为：
//    上送报文说明：
//    cstmNo	会员编号：取KEY“cstmNo”对应的值
//    cstmName	姓名：取KEY“cstmName”对应的值
//    merchID	商品代号：取KEY“merchID”对应的值
//    normsType	商品规格：取KEY“normsType”对应的值
//    merchNum	商品购买数量：取KEY“merchNum”对应的值
//    5）将交易返回的信息对象赋值到本地msgReturn，然后返回对象；
    
   
      [self request0031];
    
  

}
-(void)stampAddShopping
{
    
    
//    说明：新邮预订、邮票零售、邮品零售加入购物车
//    
//    1）声明本地变量 MsgReturn msgReturn，初始化为 msgReturn.mErrorMsg.errorCode 为“0000”；
//    2）根据以下KEY获取对应的值：
//    cstmNo	会员编号
//    busiNo	业务代号
//    merchID	商品代号
//    recordNum	循环域开始
//    normsType	商品规格
//    merchNum	商品购买数量
//    recordNum	循环域结束
//    3）调用“加入购物车（JY0033）”交易，上送报文为：
//    上送报文说明：
//    cstmNo	会员编号：取KEY“cstmNo”对应的值
//    busiNo	业务代号：取KEY“busiNo”对应的值
//    merchID	商品代号：取KEY“merchID”对应的值
//    recordNum	循环域开始：：取KEY“ recordNum”对应的值
//    normsType	商品规格：取KEY“normsType”对应的值
//    merchNum	商品购买数量：取KEY“merchNum”对应的值
//    5）将交易返回的信息对象赋值到本地msgReturn，然后返回对象；
    
    [self request0033];
    

}
-(void)gxhAddShopping
{
    
//    说明：个性化定制业务加入购物车
//    1）声明本地变量 MsgReturn msgReturn，初始化为 msgReturn.mErrorMsg.errorCode 为“0000”；
//    2）根据以下KEY获取对应的值：
//    cstmNo	会员编号
//    merchID	商品代号
//    templateId	模板Id
//    picnum	上传的图片数量
//    contentId	附图id
//    original	原图(jpg格式，展示使用)
//    type	图片类型
//    picnum	上传的图片数量
//
//    /**2015/7/18 增加内容****/
//    isEt	是否有边饰
//    sxNo	生肖编号
//    xzNo	星座编号
//    gxhMerchNum 购买数量
//    addMerchNum 加入购物车的商品数量
//    gxhMerchID：商品代号数组
//    gxhBiaozhi：个性化标志数组
//    
//    3）调用“个性化定制信息生成（JY0050）”交易，上送报文为：
//    上送报文说明：
//    cstmNo	会员编号：取KEY“cstmNo”对应的值
//    templateId	模板Id：取KEY“templateId”对应的值
//    recordNum	上传的图片数量：取KEY“recordNum”对应的值
//    contentId	附图id：取KEY“contentId”对应的值
//    original	原图(jpg格式，展示使用)：取KEY“original”对应的值
//    type	图片类型：取KEY“type”对应的值
//    isEt	是否有边饰：取KEY“isEt”对应的值
//    sxNo	生肖编号：取KEY“sxNo”对应的值
//    xzNo	星座编号：取KEY“xzNo”对应的值
//    gxhMerchNum	购买数量：取KEY“gxhMerchNum”对应的值
//    
//    addMerchNum    加入购物车的商品数量：取KEY“addMerchNum”对应的值
//    gxhMerchID    商品编号：取KEY“gxhMerchID”对应的值
//    gxhBiaozhi    个性化标志：取KEY“gxhBiaozhi”对应的值
//    
//    5）将交易返回的信息对象赋值到本地msgReturn，然后返回对象；
    
    
  
    [self request0050];

    
    
    
}


/*个性化定制信息生成0050*/
NSString  *n0050=@"JY0050";
/*个性化定制信息生成0050*/
-(void) request0050{
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 备注:必填*/
    CstmMsg *cstMsg=[CstmMsg sharedInstance];
    [businessparam setValue:cstMsg.cstmNo forKey:@"cstmNo"];
    
    SendParam0050* Ety = typeProducts[0];
    
    /* 商品代号 备注:必填*/
    [businessparam setValue:Ety.templateId forKey:@"templateId"];
    
    /* 上传的图片数量 */
    [businessparam setValue:Ety.picNum forKey:@"recordNum"];
    if ([Ety.recordNum intValue]>0) {
        /* 附图id */
        [businessparam setValue:Ety.contentId forKey:@"contentId"];
        /* 图片URL地址 */
        [businessparam setValue:Ety.original forKey:@"original"];
        /* 图片类型 */
        [businessparam setValue:Ety.type forKey:@"type"];
    }
    
    /* 是否有边饰 */
    [businessparam setValue:Ety.isEt forKey:@"isEt"];
    /* 生肖编号 */
    [businessparam setValue:Ety.sxNo forKey:@"sxNo"];
    /* 星座编号 */
    [businessparam setValue:Ety.xzNo forKey:@"xzNo"];
    /* 购买数量 */
    [businessparam setValue:Ety.gxhMerchNum forKey:@"gxhMerchNum"];
    
    
    /* 加入购物车的商品数量 */
    [businessparam setValue:Ety.addMerchNum forKey:@"addMerchNum"];
    if ([Ety.addMerchNum intValue]>0) {
        /* 商品代号 */
        [businessparam setValue:Ety.gxhBiaozhi forKey:@"gxhBiaozhi"];
        /* 个性化标志 */
        [businessparam setValue:Ety.gxhMerchID forKey:@"gxhMerchID"];
    }
    
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    _sysBaseInfo.isOpenLoading=false;
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0050 business:businessparam delegate:self viewController:viewControld];
}




/*会员已购商品查询0020*/
NSString  *n0020=@"JY0020";
/*会员已购商品查询0020*/
-(void) request0020{
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 备注:必填*/
    CstmMsg *cstMsg=[CstmMsg sharedInstance];
    [businessparam setValue:cstMsg.cstmNo forKey:@"cstmNo"];
    /* 商品代号 备注:必填*/
    [businessparam setValue:[NSString stringWithFormat:@"%@", productId]  forKey:@"merchID"];
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
      _sysBaseInfo.isOpenLoading=true;
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0020 business:businessparam delegate:self viewController:viewControld];
}




/*新邮预定资格校验0031*/
NSString  *n0031=@"JY0031";
/*新邮预定资格校验0031*/
-(void) request0031{
    
    
        
        RespondParam0026 *p =typeProducts[0];
        
        CstmMsg *cstmsg=[CstmMsg sharedInstance];
        NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
        /* 会员编号 备注:必填*/
        [businessparam setValue:cstmsg.cstmNo forKey:@"cstmNo"];
        /* 姓名 备注:必填*/
        [businessparam setValue:cstmsg.cstmName forKey:@"cstmName"];
        /* 商品代号 备注:必填*/
        [businessparam setValue:p.merchID forKey:@"merchID"];
        /* 商品规格 备注:必填*/
        [businessparam setValue:p.normsType forKey:@"normsType"];
        /* 商品购买数量 备注:必填*/
        [businessparam setValue:[NSString stringWithFormat:@"%d",p.checkNum ] forKey:@"merchNum"];
        
        CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
        SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
        
        StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
     _sysBaseInfo.isOpenLoading=true;
        [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0031 business:businessparam delegate:self viewController:viewControld];
    
    
}


/*加入购物车0033*/
NSString  *n0033=@"JY0033";
/*加入购物车0033*/
-(void) request0033{
 
        
    RespondParam0026 *p =typeProducts[0];
        
    CstmMsg *cstmsg=[CstmMsg sharedInstance];
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 备注:必填*/
    [businessparam setValue:cstmsg.cstmNo forKey:@"cstmNo"];
    /* 业务代号 备注:必填*/
    [businessparam setValue:p.busiNo forKey:@"busiNo"];
    /* 商品代号 备注:必填*/
    [businessparam setValue:p.merchID forKey:@"merchID"];
    
    
    /* 记录数 备注:*/
    [businessparam setValue:[NSString stringWithFormat:@"%d", [typeProducts count]]  forKey:@"recordNum"];
    
    
    NSMutableArray *types=[[NSMutableArray alloc] init];
     NSMutableArray *checkNums=[[NSMutableArray alloc] init];
        for ( RespondParam0026 *type in  typeProducts ) {
            [types addObject:type.normsType];
            [checkNums addObject:[NSString stringWithFormat:@"%d",type.checkNum]  ];
            
        }
    /* 商品规格 备注:必填*/
    [businessparam setValue:types forKey:@"normsType"];
    
    /* 商品购买数量 备注:必填*/
    [businessparam setValue:checkNums forKey:@"merchNum"];
            
            
    /* 记录数 备注:*/
        
        CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
        SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
        
        StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
     _sysBaseInfo.isOpenLoading=false;
        [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0033 business:businessparam delegate:self viewController:viewControld];
  
    
}



-(void) ReturnError:(MsgReturn*)msgReturn
{
    if (self.addShoppingDelegate) {
        [self.addShoppingDelegate addShoppingDelegateCallBackError:msgReturn];
    }
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    
    NSMutableArray *listData=[[NSMutableArray alloc]init];
    /*会员已购商品查询0020*/
    if ([msgReturn.formName isEqualToString:n0020]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        RespondParam0020 *commonItem=[[RespondParam0020 alloc]init];
        /* 返回的记录数 备注:循环域开始*/
        commonItem.recordNum=[[returnDataBody objectForKey:@"recordNum"] intValue];
        
        for (int i=0; i<commonItem.recordNum; i++) {
            
        
        /* 商品规格 备注:单张、四方连*/
        commonItem.merchNorms=[returnDataBody objectForKey:@"merchNorms"][i];
            
            
        /* 已购数量 备注:*/
        commonItem.buyNum=[[returnDataBody objectForKey:@"buyNum"][i] intValue];
        /* 库存数量 备注:*/
        commonItem.stockNum=[[returnDataBody objectForKey:@"stockNum"][i] intValue];
        /* 限购数量 备注:*/
        commonItem.limitNum=[[returnDataBody objectForKey:@"limitNum"][i] intValue];
        /* 返回的记录数 备注:循环域结束*/
     
            
            
            for (RespondParam0026 *p in typeProducts) {
                
                if ([p.normsType isEqualToString:commonItem.merchNorms]) {
                    
                        if(p.checkNum+commonItem.buyNum >commonItem.limitNum)
                        {
                            MsgReturn  *msgReturn=[[MsgReturn alloc ] init ];
                            msgReturn.errorCode=@"0018";
                             msgReturn.errorDesc=@"购买数量超过限购数量";
                             msgReturn.errorType=@"02";
                            //return  msgReturn;
                            [self.addShoppingDelegate addShoppingDelegateCallBack:msgReturn];
                              return;
                        }
                        
                        else if(p.checkNum >commonItem.stockNum)
                        {
                            MsgReturn  *msgReturn=[[MsgReturn alloc ] init ];
                            msgReturn.errorCode=@"0021";
                            msgReturn.errorDesc=@"您选购的商品数量已超过库存数量";
                             msgReturn.errorType=@"02";
                            [self.addShoppingDelegate addShoppingDelegateCallBack:msgReturn];
                            return;
                            
                        }else
                        {
//                            MsgReturn  *msgReturn=[[MsgReturn alloc ] init ];
//                            msgReturn.errorCode=@"0000";
//                            msgReturn.errorDesc=@"";
//                             msgReturn.errorType=@"02";
//                            [self.addShoppingDelegate addShoppingDelegateCallBack:msgReturn];
                            
                            
                           
                        }
                    

                }
                
            }
            
      }
        
        stepCount++;
        [self gotoWhere:stepCount];
        
        //    a）已经购物检查：传入的购买数量 + 下发报文对应商品规格的“已购数量（buyNum）” 是否大于 下发报文“限购数量（limitNum）”，如果      是，则msgReturn.mErrorMsg.errorCode赋值“0018 购买数量超过限购数量”；.
        //    b）库存检查：传入的购买数量 是否大于 下发报文对应商品规格的“库存数量（stockNum）”，如果是，则msgReturn.mErrorMsg.errorCode赋值“0021 您
        //    选购的商品数量已超过库存数量”；
        
    }
    
    
    
    
   // NSMutableArray *listData=[[NSMutableArray alloc]init];
    /*新邮预定资格校验0031*/
    if ([msgReturn.formName isEqualToString:n0031]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnBody=[returnData objectForKey:@"returnBody"];
        
        
//        MsgReturn  *msgReturn=[[MsgReturn alloc ] init ];
//        msgReturn.errorCode=@"0000";
//        msgReturn.errorDesc=@"新邮预定资格校验成功";
//         msgReturn.errorType=@"02";
//        [self.addShoppingDelegate addShoppingDelegateCallBack:msgReturn];
    
        stepCount++;
        [self gotoWhere:stepCount];
    }
    
    
    //NSMutableArray *listData=[[NSMutableArray alloc]init];
    /*加入购物车0033*/
    if ([msgReturn.formName isEqualToString:n0033]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        RespondParam0033 *commonItem1=[[RespondParam0033 alloc]init];
        
        if ([returnDataBody objectForKey:@"merchID"]==nil) {
            
            return;
        }
        
        /* 返回的记录数 备注:2015/7/2新增整个循环域内容：
         循环域开始*/
        commonItem1.recordNum=[[returnDataBody objectForKey:@"recordNum"] intValue];
        
        
        NSMutableDictionary *merchIDs=[[NSMutableDictionary alloc] init ];
        
        for (int i=0; i<commonItem1.recordNum; i++) {
            
        RespondParam0033 *commonItem=[[RespondParam0033 alloc]init];
        /* 购物车代号 备注:*/
        commonItem.shoppingCartID=[returnDataBody objectForKey:@"shoppingCartID"][i];
        /* 业务代号 备注:*/
        commonItem.busiNo=[returnDataBody objectForKey:@"busiNo"][i];
        /* 商品代号 备注:*/
        commonItem.merchID=[returnDataBody objectForKey:@"merchID"][i];
        /* 图片URL 备注:*/
        commonItem.merchPicID=[returnDataBody objectForKey:@"merchPicID"][i];
        /* 商品名称 备注:*/
        commonItem.merchName=[returnDataBody objectForKey:@"merchName"][i];
        /* 所属机构 备注:店铺名称*/
        commonItem.brchNo=[returnDataBody objectForKey:@"brchNo"][i];
        /* 商品规格 备注:单张、四方连*/
        commonItem.normsType=[returnDataBody objectForKey:@"normsType"][i];
        /* 购买价格 备注:*/
        commonItem.buyPrice=[[returnDataBody objectForKey:@"buyPrice"][i] floatValue];
        /* 创建时间 备注:*/
        commonItem.gmtCreate=[returnDataBody objectForKey:@"gmtCreate"][i];
        /* 修改时间 备注:*/
        commonItem.gmtModify=[returnDataBody objectForKey:@"gmtModify"][i];
        /* 是否实名验证商品 备注:2015/6/30新增：
         0：需要
         1：不需要*/
        commonItem.needAutonym=[returnDataBody objectForKey:@"needAutonym"][i];
        /* 是否手机验证码商品 备注:2015/6/30新增：
         0：需要
         1：不需要*/
        commonItem.needVerification=[returnDataBody objectForKey:@"needVerification"][i];
        /* 是否支持寄递 备注:2015/6/30新增：
         0：支持
         1：不支持*/
        commonItem.canPost=[returnDataBody objectForKey:@"canPost"][i];
        /* 返回的记录数 备注:循环域结束*/
       // commonItem.recordNum=[returnDataBody objectForKey:@"recordNum"];
            
            
            
            [merchIDs setObject:commonItem forKey: commonItem.merchID];
            
             }
      
        MsgReturn  *msgReturn=[[MsgReturn alloc ] init ];
        msgReturn.errorCode=@"0023";
        msgReturn.errorDesc=@"加入购物车成功";
         msgReturn.errorType=@"02";
        NSMutableDictionary *counts=[[NSMutableDictionary alloc] init];
        [counts setObject:[NSString stringWithFormat:@"%d", [merchIDs count]] forKey:@"count"];
        msgReturn.map=counts;
        [self.addShoppingDelegate addShoppingDelegateCallBack:msgReturn];
    }
    /*个性化定制信息生成0050*/
   
    if ([msgReturn.formName isEqualToString:n0050]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        RespondParam0050 *commonItem=[[RespondParam0050 alloc]init];
        /* 返回的记录数 备注:循环域开始*/
//        int recordNum=[[returnDataBody objectForKey:@"recordNum"] intValue];
//        for (int i=0; i<recordNum; i++) {
//            commonItem.shoppingCartID =[returnDataBody objectForKey:@"shoppingCartID"];
//            commonItem.busiNo =[returnDataBody objectForKey:@"busiNo"];
//            commonItem.merchID =[returnDataBody objectForKey:@"merchID"];
//            commonItem.merchPicID =[returnDataBody objectForKey:@"merchPicID"];
//            commonItem.merchName =[returnDataBody objectForKey:@"merchName"];
//            commonItem.brchNo =[returnDataBody objectForKey:@"brchNo"];
//            commonItem.normsType =[returnDataBody objectForKey:@"normsType"];
//            commonItem.buyPrice =[returnDataBody objectForKey:@"buyPrice"];
//            commonItem.buyNum =[returnDataBody objectForKey:@"buyNum"];
//            commonItem.limitBuy =[returnDataBody objectForKey:@"limitBuy"];
//            commonItem.gmtCreate =[returnDataBody objectForKey:@"gmtCreate"];
//            commonItem.gmtModify =[returnDataBody objectForKey:@"gmtModify"];
//            commonItem.needAutonym =[returnDataBody objectForKey:@"needAutonym"];
//            commonItem.needVerification =[returnDataBody objectForKey:@"needVerification"];
//            commonItem.canPost =[returnDataBody objectForKey:@"canPost"];
//        }
     
        
        
        [self.addShoppingDelegate addShoppingDelegateCallBack:msgReturn];
        
    }
}






@end




