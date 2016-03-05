
#import <Foundation/Foundation.h>
#import "KeyboardButtonModel.h"


@interface KeyboardOperationMapper : NSObject

+ (KeyboardOperationMapper*)sharedInstance;
- (NSString*)mapOperation:(ButtonOperation)buttonOperation;

@end