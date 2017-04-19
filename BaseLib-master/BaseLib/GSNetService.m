//
//  GSNetService.m
//  iFreePoster
//
//  Created by Yangtsing.Zhang on 13-7-23.
//  Copyright (c) 2013年 URoad. All rights reserved.
//

#import "GSNetService.h"
#import "JSONKit.h"
#import "ErrorMsg.h"
#import "WebConfig.h"
#import "NSString+Base64.h"
@implementation GSNetService
{
   
    NSString *actionIDkey;
}




static GSNetService *objName = nil;

+ (GSNetService *) sharedInstance{
    static dispatch_once_t oneToken = 0;
    dispatch_once(&oneToken, ^{
        objName = [[super allocWithZone: NULL] init];
    });
    return objName;
}



-(void)sendMsg:(NSMutableDictionary*)prama toServerOnFormName:(NSString*)formName withDelegate:(id)delegate{
    
    
    //NSLog(@"outer sendMsg");
    [self sendMsg2:prama toServerOnFormName:formName withDelegate:delegate userNameRequired:YES userPasswordRequired:YES customerIDRequired:NO];
}




-(void)sendMsg2:(NSMutableDictionary*)prama toServerOnFormName:(NSString*)formName withDelegate:(id)delegate userNameRequired:(BOOL)userNameRequired userPasswordRequired:(BOOL)userPasswordRequired customerIDRequired:(BOOL)customerIDRequired{

    
    NSData *a=[formName base64DecodedData];
    
    
}




#pragma mark - netService callBack

-(void)serviceCallback:(id)response{
    
}

-(BOOL)serverReturnError:(id)response{
    BOOL errorOccured=NO;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([response objectForKey:@"faultcode"]) {
            errorOccured=YES;
        }
    }else
        errorOccured=NO;
    return errorOccured;
}
@end
