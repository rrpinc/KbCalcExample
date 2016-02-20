
#import <Foundation/Foundation.h>

@interface KeyboardButtonsModel : NSObject

@property (nonatomic, strong) NSArray* buttons;

+ (KeyboardButtonsModel*)standardModel;

@end