
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ButtonOperation)
{
    ButtonOperationDefault,
    ButtonOperationAdd,
    ButtonOperationSubtract,
    ButtonOperationDot,
    ButtonOperationEnter
};

@interface KeyboardButtonModel : NSObject

@property (nonatomic, copy) NSString* labelValue;
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, assign) ButtonOperation operation;

+ (KeyboardButtonModel*)buttonModelWithValue:(NSInteger)value;
+ (KeyboardButtonModel*)buttonModelWithOperationType:(ButtonOperation)buttonOperation;

@end
