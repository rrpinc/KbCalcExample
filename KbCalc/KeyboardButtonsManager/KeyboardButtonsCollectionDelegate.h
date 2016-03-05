
#import <UIKit/UIKit.h>

@protocol KeyboardButtonsCollectionDelegateProtocol <NSObject,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

- (void)updateTrackWithLiteral:(NSString*)literal;
- (void)setTrackWithResult:(NSString*)result;
- (void)setCalculationResult:(NSString*)result;

@end

@class KeyboardButtonsModel;
@protocol KeyboardManagerViewControllerProtocol;

@interface KeyboardButtonsCollectionDelegate : NSObject<KeyboardButtonsCollectionDelegateProtocol>

@property (nonatomic, strong) KeyboardButtonsModel* model;

+ (KeyboardButtonsCollectionDelegate*)buttonCollectionDelegateWithCollectionViewDelegate:(id<KeyboardManagerViewControllerProtocol>)keyboardManagerDelegate;

@end
