

#import <Foundation/Foundation.h>
#import "GSNetService.h"

typedef enum{    //转义范畴
    GDD=0,//GDD文件
    GDS=1,//GDS文件
    SYSTEMPERR = 2, //错误信息
    CONFIGFILE = 3 //配置文件
}CONFIGFILETYPE;


@protocol GSConfigManagerDelegate;

@interface GSConfigManager : NSObject<GSNetServiceDelegate>
AS_SINGLETON(GSConfigManager)

/**
 *  从配置文件获取内容
 *
 *  @param key 配置文件中的key
 *
 *  @return 得到对应key返回的值
 */
-(NSString*)findValueFromConfigFileByKey:(NSString*)key;

/**
 *  将后台返回的错误信息转义成SYSTEMERRORIP文件里的意思
 *
 *  @param originalValue 后台返回的错误信息的值
 *
 *  @return 经过转义之后得到的值
 */
-(NSString*)findValueFromSystemErrorIpByOriginalValue:(NSString*)originalValue;

@property(assign)bool isGetOrgan;
@property (nonatomic,retain)id<GSConfigManagerDelegate>delegate;
@property (nonatomic,strong)NSString *organizationNo;//机构代号、业务开办局
@property (nonatomic,strong)NSString *operationId;//柜员号
@property (nonatomic,strong)void(^queryMessageHeaderResult)(NSString*);
@property (nonatomic,strong)void(^getMainPageMenuButtonArray)(id);

@property (nonatomic,retain)NSArray*SystemErrorArray;

/**
 *  获取配置文件路径
 *
 *  @return 返回路径
 */
- (NSString *)getConfigFilePath:(CONFIGFILETYPE)type;
@end

@protocol GSConfigManagerDelegate <NSObject>

-(void)resultAboutMainPageButtons:(id)data;

@end
