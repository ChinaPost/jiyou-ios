//
//  Sql.h
//  Philately
//
//  Created by gdpost on 15/6/25.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "ErrorObject.h"
@interface Sql : NSObject
{

 sqlite3 *db;
}

-(BOOL) openDB;
-(ErrorObject*) selectPM_CODEERRORMSG:(NSString*) code;
-(ErrorObject*) selectPM_DESCERRORMSG:(NSString*) code;
-(NSString*) selectPM_SIGNSERVICE_CONFIGVERSION;
@end

@interface row : NSObject


@property (strong, nonatomic) NSString  * SERVICEID;
@property (strong, nonatomic) NSString  *SERVICEKEY;
@property (strong, nonatomic) NSString  *SERVICECODE;
@property (strong, nonatomic) NSString  *SERVICENAME;
@property (strong, nonatomic) NSString  *SERVICENAME_BACKUP1;
@property (strong, nonatomic) NSString  *SERVICENAME_BACKUP2;
@property (strong, nonatomic) NSString  *SERVICENAME_BACKUP3;

@property (strong, nonatomic) NSString  *ERRORCODE;
@property (strong, nonatomic) NSString *ERRORDESC;
@property (strong, nonatomic) NSString *ERRORTYPE;



@property (strong, nonatomic) NSString * CHANGEDESC;
@end

//  0  "SERVICEID"  TEXT(100) NOT NULL,
//   1 "SERVICEKEY"  TEXT(100),
//  2  "SERVICECODE"  TEXT(100),
//   3 "SERVICENAME"  TEXT(300),
//   4 "SERVICENAME_BACKUP1"  TEXT(300),
//   5 "SERVICENAME_BACKUP2"  TEXT(300),
//   6  "SERVICENAME_BACKUP3"  TEXT(300)