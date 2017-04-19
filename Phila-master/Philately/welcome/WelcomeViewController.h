//
//  WelcomeViewController.h
//  Philately
//
//  Created by gdpost on 15/6/17.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PublicFramework/ServiceInvoker.h>

@interface WelcomeViewController : UIViewController<ServiceInvokerDelegate,UIAlertViewDelegate>
{
    NSString *appUrl;
    NSString *oldVersionEnable;
}

@end
