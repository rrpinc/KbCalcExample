
#import "KeyboardOperationMapper.h"

static KeyboardOperationMapper* sharedInstance = nil;

@interface KeyboardOperationMapper()

@property (nonatomic, strong) NSDictionary* operationsMap;

@end

@implementation KeyboardOperationMapper

+ (KeyboardOperationMapper*)sharedInstance
{
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [KeyboardOperationMapper new];
        sharedInstance.operationsMap =
        @{      @"+":@(ButtonOperationAdd),
                @"-":@(ButtonOperationSubtract),
                @".":@(ButtonOperationDot),
                @"<-":@(ButtonOperationEnter)
                };
    });

    return sharedInstance;
}

- (NSString*)mapOperation:(ButtonOperation)buttonOperation
{
    for (NSString* oppKey in self.operationsMap.allKeys)
    {
        if (([self.operationsMap[oppKey] longLongValue]) == buttonOperation)
            return oppKey;
    }
    return nil;
}

@end