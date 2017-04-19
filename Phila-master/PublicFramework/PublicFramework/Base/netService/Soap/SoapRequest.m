/*
 SoapRequest.m
 Implementation of the request object used to manage asynchronous requests.
 Author:	Jason Kichline, andCulture - Harrisburg, Pennsylvania USA
*/

#import "SoapRequest.h"
#import "SoapArray.h"
#import "SoapFault.h"
#import "Soap.h"

#import "ErrorMsg.h"
@implementation SoapRequest

@synthesize handler, url, soapAction, postData, receivedData, username, password, deserializeTo, action, logging, defaultHandler;

// Creates a request to submit from discrete values.
+ (SoapRequest*) create: (SoapHandler*) handler urlString: (NSString*) urlString soapAction: (NSString*) soapAction postData: (NSString*) postData deserializeTo: (id) deserializeTo {
	return [SoapRequest create: handler action: nil urlString: urlString soapAction: soapAction postData: postData deserializeTo: deserializeTo];
}

+ (SoapRequest*) create: (SoapHandler*) handler action: (SEL) action urlString: (NSString*) urlString soapAction: (NSString*) soapAction postData: (NSString*) postData deserializeTo: (id) deserializeTo {
	SoapRequest* request = [[SoapRequest alloc] init];
	request.url = [NSURL URLWithString: urlString];
	request.soapAction = soapAction;
	request.postData = [postData retain];
	request.handler = handler;
	request.deserializeTo = deserializeTo;
	request.action = action;
	request.defaultHandler = nil;
	return [request autorelease];
}

+ (SoapRequest*) create: (SoapHandler*) handler action: (SEL) action service: (SoapService*) service soapAction: (NSString*) soapAction postData: (NSString*) postData deserializeTo: (id) deserializeTo {
	SoapRequest* request = [SoapRequest create: handler action: action urlString: service.serviceUrl soapAction: soapAction postData:postData deserializeTo:deserializeTo];
	request.defaultHandler = service.defaultHandler;
	request.logging = service.logging;
	request.username = service.username;
	request.password = service.password;
	return request;
}



// Sends the request via HTTP.
- (void) send {
	
	// If we don't have a handler, create a default one
	if(handler == nil) {
		handler = [[SoapHandler alloc] init];
	}
	
	// Make sure the network is available
	if([SoapReachability connectedToNetwork] == NO) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults  setValue:ERROR_NOT_NET forKey:@"errorcode"];
        [userDefaults  setValue:ERROR_TEXT_NOT_NET forKey:@"errortxt"];
        [userDefaults synchronize];
        
        NSError* error = [NSError errorWithDomain:@"SoapRequest" code:400 userInfo: [NSDictionary dictionaryWithObjectsAndKeys: @"net cound not connect", NSLocalizedDescriptionKey,nil]];
        [self handleError: error];
        return;
	}
//	
//	// Make sure we can reach the host
//	if([SoapReachability hostAvailable:url.host] == NO) {
//
//		NSError* error = [NSError errorWithDomain:@"SudzC" code:410 userInfo:[NSDictionary dictionaryWithObject:@"The host is not available" forKey:NSLocalizedDescriptionKey]];
//		[self handleError: error];
//      return;
//	}
	
	// Output the URL if logging is enabled
	if(logging) {
		//NSLog(@"Loading: %@", url.absoluteString);
	}
	
    //自定义时间超时
    //[NSTimer scheduledTimerWithTimeInterval:self.defaultTimeout target: self selector: @selector(handleTimer) userInfo:operation repeats:NO];
    
    
	// Create the request
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: url];
    request.timeoutInterval=_requestTimeout;
    
    
	if(soapAction != nil) {
		[request addValue: soapAction forHTTPHeaderField: @"SOAPAction"];
	}
	if(postData != nil) {
		[request setHTTPMethod: @"POST"];
		[request addValue: @"text/xml; charset=utf-8" forHTTPHeaderField: @"Content-Type"];
		[request setHTTPBody: [postData dataUsingEncoding: NSUTF8StringEncoding]];
		if(self.logging) {
			//NSLog(@"%@", postData);
		}
	}
	
	// Create the connection
	conn = [[NSURLConnection alloc] initWithRequest: request delegate: self];
	if(conn) {
		receivedData = [[NSMutableData data] retain];
	} else {
		// We will want to call the onerror method selector here...
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults  setValue:ERROR_SERVICE_IN_ERROR forKey:@"errorcode"];
        [userDefaults  setValue:ERROR_TEXT_SERVICE_FAILED forKey:@"errortxt"];
        [userDefaults synchronize];
        
		if(self.handler != nil) {
			NSError* error = [NSError errorWithDomain:@"SoapRequest" code:404 userInfo: [NSDictionary dictionaryWithObjectsAndKeys: @"Could not create connection", NSLocalizedDescriptionKey,nil]];
			[self handleError: error];
		}
	}
}


//时间超时定义
-(void) handleTimer
{
//    [operationCopy connection:[NSError errorWithDomain:@"时间超时！" code:256 userInfo:nil]];
}

-(void)handleError:(NSError*)error{
    if(self.logging) {
        NSLog(@"SoapRequet handleError: Error: %d %@",error.code, error.localizedDescription);
    }
    
	SEL onerror = @selector(onerror:);
	if(self.action != nil) { onerror = self.action; }
	if([self.handler respondsToSelector: onerror]) {
		[self.handler performSelector: onerror withObject: error];
	} else {
		if(self.defaultHandler != nil && [self.defaultHandler respondsToSelector:onerror]) {
			[self.defaultHandler performSelector:onerror withObject: error];
		}
	}
	if(self.logging) {
		NSLog(@"Error: %d %@",error.code, error.localizedDescription);
	}
}

-(void)handleFault:(SoapFault*)fault{
	if([self.handler respondsToSelector:@selector(onfault:)]) {
		[self.handler onfault: fault];
	} else if(self.defaultHandler != nil && [self.defaultHandler respondsToSelector:@selector(onfault:)]) {
		[self.defaultHandler onfault:fault];
	}
	if(self.logging) {
		NSLog(@"Fault: %@", fault);
	}
}

// Called when the HTTP socket gets a response.
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.receivedData setLength:0];
}

// Called when the HTTP socket received data.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)value {
    [self.receivedData appendData:value];
}

// Called when the HTTP request fails.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[conn release];
	conn = nil;
	self.receivedData = nil;
   
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults  setValue:ERROR_TIMEOUT_ERROR forKey:@"errorcode"];
    [userDefaults  setValue:ERROR_TIMEOUT forKey:@"errortxt"];
    [userDefaults synchronize];
	[self handleError:error];
}

// Called when the connection has finished loading.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSError* error;
	if(self.logging == YES) {
		NSString* response = [[NSString alloc] initWithData: self.receivedData encoding: NSUTF8StringEncoding];
		//NSLog(@"%@", response);
		[response release];
	}

	CXMLDocument* doc = [[CXMLDocument alloc] initWithData: self.receivedData options: 0 error: &error];
	if(doc == nil) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults  setValue:ERROR_DATA_FORMAT_ERROR forKey:@"errorcode"];
        [userDefaults  setValue:ERROR_DATA_FORMAT_ERROR_STRING forKey:@"errortxt"];
        [userDefaults synchronize];
        
		[self handleError:error];
		return;
	}

	id output = nil;
	SoapFault* fault = [SoapFault faultWithXMLDocument: doc];

	if([fault hasFault]) {
		if(self.action == nil) {
			[self handleFault: fault];
		} else {
			if(self.handler != nil && [self.handler respondsToSelector: self.action]) {
				[self.handler performSelector: self.action withObject: fault];
			} else {
				//NSLog(@"SOAP Fault: %@", fault);
			}
		}
	} else {
		CXMLNode* element = [[Soap getNode: [doc rootElement] withName: @"soap:Body"] childAtIndex:0];
		if(deserializeTo == nil) {
			output = [Soap deserialize:element];
		} else {
			if([deserializeTo respondsToSelector: @selector(initWithNode:)]) {
				element = [element childAtIndex:0];
				output = [deserializeTo initWithNode: element];
			} else {
				NSString* value = [[[element childAtIndex:0] childAtIndex:0] stringValue];
				output = [Soap convert: value toType: deserializeTo];
			}
		}
		
		if(self.action == nil) { self.action = @selector(onload:); }
		if(self.handler != nil && [self.handler respondsToSelector: self.action]) {
 			[self.handler performSelector: self.action withObject: output];
		} else if(self.defaultHandler != nil && [self.defaultHandler respondsToSelector:@selector(onload:)]) {
			[self.defaultHandler onload:output];
		}
	}

	self.handler = nil;
	[doc release];
	[conn release];
	conn = nil;
	self.receivedData = nil;
}

// Called if the HTTP request receives an authentication challenge.
-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	if([challenge previousFailureCount] == 0) {
		NSURLCredential *newCredential;
        newCredential=[NSURLCredential credentialWithUser:self.username password:self.password persistence:NSURLCredentialPersistenceNone];
        [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
		NSError* error = [NSError errorWithDomain:@"SoapRequest" code:403 userInfo: [NSDictionary dictionaryWithObjectsAndKeys: @"Could not authenticate this request", NSLocalizedDescriptionKey,nil]];
		[self handleError:error];
    }
}

// Cancels the HTTP request.
- (BOOL) cancel {
	if(conn == nil) { return NO; }
	[conn cancel];
	[conn release];
	conn = nil;
	return YES;
}

// Deallocates the object
- (void) dealloc {
	[defaultHandler release];
	[url release];
	[soapAction release];
	[username release];
	[password release];
	[deserializeTo release];
	[postData release];
	[super dealloc];
}

@end