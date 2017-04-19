/*
	CPSinvokeResponse.h
	The interface definition of properties and methods for the CPSinvokeResponse object.
	Generated by SudzC.com
*/

#import "Soap.h"
	

@interface CPSinvokeResponse : SoapObject
{
	NSString* __return;
	
}
		
	@property (retain, nonatomic) NSString* _return;

	+ (CPSinvokeResponse*) createWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
