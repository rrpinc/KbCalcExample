
#import "KeyboardButtonsModel.h"
#import "KeyboardButtonModel.h"


@implementation KeyboardButtonsModel

+ (KeyboardButtonsModel*)standardModel
{
    KeyboardButtonsModel* model = [KeyboardButtonsModel new];

    model.buttons = @[
            [KeyboardButtonModel buttonModelWithValue:1],
            [KeyboardButtonModel buttonModelWithValue:4],
            [KeyboardButtonModel buttonModelWithValue:7],
            [KeyboardButtonModel buttonModelWithOperationType:ButtonOperationDot],
            
            [KeyboardButtonModel buttonModelWithValue:2],
            [KeyboardButtonModel buttonModelWithValue:5],
            [KeyboardButtonModel buttonModelWithValue:8],
            [KeyboardButtonModel buttonModelWithValue:0],
            
            [KeyboardButtonModel buttonModelWithValue:3],
            [KeyboardButtonModel buttonModelWithValue:6],
            [KeyboardButtonModel buttonModelWithValue:9],
            [KeyboardButtonModel buttonModelWithOperationType:ButtonOperationEnter],
            
            [KeyboardButtonModel buttonModelWithOperationType:ButtonOperationSubtract],
            [KeyboardButtonModel buttonModelWithOperationType:ButtonOperationAdd],
    ];

    return model;

}

@end