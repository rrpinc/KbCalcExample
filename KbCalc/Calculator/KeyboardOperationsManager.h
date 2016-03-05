
#import <Foundation/Foundation.h>

@class KeyboardButtonModel;
@protocol KeyboardButtonsCollectionDelegateProtocol;

@interface KeyboardOperationsManager : NSObject

-(instancetype)initWithActionsDelegate:(id<KeyboardButtonsCollectionDelegateProtocol>)actionsDelegate;
- (void)operationRequestWithModel:(KeyboardButtonModel*)model;
- (NSNumber*)calculate;
@end