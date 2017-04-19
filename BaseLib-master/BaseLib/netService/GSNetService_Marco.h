//
//  GSNetService_Marco.h
//  iFreePoster
//
//  Created by Yangtsing.Zhang on 13-7-30.
//  Copyright (c) 2013年 URoad. All rights reserved.
//

#ifndef iFreePoster_GSNetService_Marco_h
#define iFreePoster_GSNetService_Marco_h

#if defined  (__USE_SIMULATOR_SERVER__) && __USE_SIMULATOR_SERVER__ //使用模拟器后台

//模拟器网关parm 报文头
#define SNDMSG_HEAD_DIC [NSDictionary dictionaryWithObjectsAndKeys: @"0000000",@"H_BRCH_NO" \
,@"00",@"H_OPER_NO",@"10000176",@"H_SEQ_NO" \
,@"192.168.234.128",@"H_IP_ADDR",@"pts_38",@"H_TTY" \
,@"",@"H_AUTH_OPER_NO",@"",@"H_CHANNEL_TRACE",@"06",@"H_CHANNEL_NO" \
,@"52503500",@"H_BRCH_NO_NEW",@"XU00",@"H_OPER_NO_NEW" \
,@"0000",@"H_SFILE_NUM", nil]

#else

//测试网关parm 报文头部
#define SNDMSG_HEAD_DIC [NSDictionary dictionaryWithObjectsAndKeys: @"0000000",@"H_BRCH_NO" \
,@"00",@"H_OPER_NO",@"10000176",@"H_SEQ_NO" \
,@"127.0.0.1",@"H_IP_ADDR",@"pts_38",@"H_TTY" \
,@"",@"H_AUTH_OPER_NO",@"",@"H_CHANNEL_TRACE",@"06",@"H_CHANNEL_NO" \
,@"51080100",@"H_BRCH_NO_NEW",@"XU00",@"H_OPER_NO_NEW" \
,@"0000",@"H_SFILE_NUM", nil]

#endif


#define SNDMSG_HEAD_KEY    @"SNDMSG_HEAD"
#define ACTION_KEY         @"action"
#define ACTION_ID_KEY      @"actionId"
#define BUSINESS_PARAM_KEY @"businessParam"
#define FORM_NAME_KEY      @"formName"
#define USER_NAME_KEY      @"username"
#define PASSWORD_KEY       @"password"
#define PARAM_KEY          @"param"
#define ACTION_ID          @"router_144"

#define ACTION_ID_NONE @"router_59_none"

//#define ACTION_ID_NONE @"router_144_none"

#endif
