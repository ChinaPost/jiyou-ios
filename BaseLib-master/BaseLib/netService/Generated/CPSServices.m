/*
	CPSServices.m
	Creates a list of the services available with the CPS prefix.
	Generated by SudzC.com
*/
#import "CPSServices.h"

@implementation CPSServices

@synthesize logging, server, defaultServer;

@synthesize serverImplService;


#pragma mark Initialization

-(id)initWithServer:(NSString*)serverName{
	if(self = [self init]) {
		self.server = serverName;
	}
	return self;
}

+(CPSServices*)service{
	return (CPSServices*)[[[CPSServices alloc] init] autorelease];
}

+(CPSServices*)serviceWithServer:(NSString*)serverName{
	return (CPSServices*)[[[CPSServices alloc] initWithServer:serverName] autorelease];
}

#pragma mark Methods

-(void)setLogging:(BOOL)value{
	logging = value;
	[self updateServices];
}

-(void)setServer:(NSString*)value{
	[server release];
	server = [value retain];
	[self updateServices];
}

-(void)updateServices{

	[self updateService: self.serverImplService];
}

-(void)updateService:(SoapService*)service{
	service.logging = self.logging;
	if(self.server == nil || self.server.length < 1) { return; }
	service.serviceUrl = [service.serviceUrl stringByReplacingOccurrencesOfString:defaultServer withString:self.server];
}

#pragma mark Getter Overrides


-(CPSServerImplService*)serverImplService{
	if(serverImplService == nil) {
		serverImplService = [[CPSServerImplService alloc] init];
	}
	return serverImplService;
}


@end
			