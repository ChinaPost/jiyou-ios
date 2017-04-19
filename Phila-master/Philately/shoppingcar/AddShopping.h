//
//  AddShopping.h
//  Philately
//
//  Created by gdpost on 15/7/9.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "RespondParam0026.h"

@protocol AddShoppingDelegate;

@interface AddShopping : NSObject<StampTranCallDelegate>

{
   

}


@property (nonatomic) int stepCount;
@property (strong,nonatomic) id<AddShoppingDelegate> addShoppingDelegate;
-(void)shoppingUnionCheck:(NSString*)mproductId businNo:(NSString*)mbusinNo typeProduct:(NSMutableArray*)typeProduct  delegate:(id<AddShoppingDelegate>) delegate;

-(void)shopNumCheck;
-(void)shopQualiCheck;
-(void)stampAddShopping;
-(void)gxhAddShopping;

@end


@protocol AddShoppingDelegate <NSObject>

-(void)addShoppingDelegateCallBack:(MsgReturn*)msgReturn;
-(void)addShoppingDelegateCallBackError:(MsgReturn*)msgReturn;

@end
