
#import "KeyboardButtonModel.h"
#import "KeyboardOperationMapper.h"

@implementation KeyboardButtonModel

+ (KeyboardButtonModel*)buttonModelWithValue:(NSInteger)value
{
    KeyboardButtonModel* model = [KeyboardButtonModel new];
    model.labelValue = [NSString stringWithFormat:@"%li", (long)value];
    model.value = value;
    model.operation = ButtonOperationDefault;
    return model;
}

+ (KeyboardButtonModel*)buttonModelWithOperationType:(ButtonOperation)buttonOperation
{
    KeyboardButtonModel* model = [KeyboardButtonModel new];
    model.operation = buttonOperation;
    model.labelValue = [[KeyboardOperationMapper sharedInstance] mapOperation:buttonOperation];
    return model;
}

@end
