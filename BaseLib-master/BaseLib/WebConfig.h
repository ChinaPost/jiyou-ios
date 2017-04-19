//
//  WebConfig.h
//  PublicLibUI
//
//  Created by gdpost on 15/5/21.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#ifndef PublicLibUI_WebConfig_h
#define PublicLibUI_WebConfig_h

static const NSString *NAMESPACE=@"http://service.chinapost.com/";
static const NSString *USER=@"chinapost";
static const NSString *PASSWORD=@"chinapostp@ssword";
static const NSString *method_name=@"invoke";



static const NSString *url_portal=@"http://";
static const NSString *url_webservice_path=@"/services/ChinaPostService";
static const int TIMEOUT=31000;


//便民121.8.157.221:9090   邮票192.168.248.90:9011 （公网地址：61.144.23.88)  211.156.198.93
//static const NSString *server_url=@"211.156.198.93";//215环境  //164测试环境  121.8.157.202:9090

//static const NSString *server_url=@"211.156.200.140";//生产环境
static const NSString *server_url=@"mobile.11185.cn";//生产环境


//
#endif
