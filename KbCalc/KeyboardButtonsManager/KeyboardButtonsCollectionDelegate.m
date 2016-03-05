
#import "KeyboardButtonsCollectionDelegate.h"
#import "KeyboardButtonsModel.h"
#import "KeyboardButtonModel.h"
#import "KeyboardButtonCollectionViewCell.h"
#import "KeyboardViewController.h"
#import "KeyboardOperationsManager.h"

static NSString* const CellReuseIdentifier = @"CellButtonReuseIdentifier";

@interface KeyboardButtonsCollectionDelegate()

@property (nonatomic, weak) id<KeyboardManagerViewControllerProtocol> keyboardManagerDelegate;
@property (nonatomic, strong) KeyboardOperationsManager* operationsManager;

@end

@implementation KeyboardButtonsCollectionDelegate

#pragma mark - Factory

+ (KeyboardButtonsCollectionDelegate*)buttonCollectionDelegateWithCollectionViewDelegate:(id<KeyboardManagerViewControllerProtocol>)keyboardManagerDelegate
{
    KeyboardButtonsCollectionDelegate* delegate = [KeyboardButtonsCollectionDelegate new];
    delegate.model = [KeyboardButtonsModel standardModel];
    delegate.keyboardManagerDelegate = keyboardManagerDelegate;
    delegate.operationsManager = [[KeyboardOperationsManager alloc] initWithActionsDelegate:delegate];
    
    [delegate.keyboardManagerDelegate registerClass:[KeyboardButtonCollectionViewCell class]forCellReuseIdentifier:CellReuseIdentifier];
    return delegate;
}

#pragma mark - KeyboardButtonsCollectionDelegateProtocol

- (void)updateTrackWithLiteral:(NSString*)literal
{
    [self.keyboardManagerDelegate updateTrackWithLiteral:literal];
}

- (void)setTrackWithResult:(NSString*)result
{
    [self.keyboardManagerDelegate setTrackWithLiteral:result];
}

- (void)setCalculationResult:(NSString*)result
{
    [self.keyboardManagerDelegate setCalculationResult:result];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    KeyboardButtonModel* model = (KeyboardButtonModel*)self.model.buttons[indexPath.item];
    [self.operationsManager operationRequestWithModel:model];
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.buttons.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    KeyboardButtonModel* model = self.model.buttons[indexPath.item];
    KeyboardButtonCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellReuseIdentifier
                                                                                       forIndexPath:indexPath];

    [cell populateWithModel:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    CGRect buttonsContainer = [self.keyboardManagerDelegate keyboardButtonsContainer].frame;
    
    NSLog(@"Collection Frame: (%lf,%lf,%lf,%lf) ",buttonsContainer.origin.x,buttonsContainer.origin.y, buttonsContainer.size.width, buttonsContainer.size.height);
    
    KeyboardButtonModel* model = self.model.buttons[indexPath.item];
    if (model.operation == ButtonOperationAdd || model.operation == ButtonOperationSubtract)
    {
        return CGSizeMake(buttonsContainer.size.width/3.4, buttonsContainer.size.height/3);
    }

    return CGSizeMake(buttonsContainer.size.width/3.4, buttonsContainer.size.height/6);
}

@end
