
#import "KeyboardButtonCollectionViewCell.h"
#import "KeyboardButtonModel.h"

@interface KeyboardButtonCollectionViewCell()

@property (nonatomic, strong) UILabel* label;

@end

@implementation KeyboardButtonCollectionViewCell

- (void)prepareForReuse
{
    if (self.label)
        [self.label removeFromSuperview];
}

- (void)populateWithModel:(KeyboardButtonModel*)model
{
    self.label = [UILabel new];
    [self.label setFont:[UIFont systemFontOfSize:25.0f weight:0.4f]];

    self.label.text = model.labelValue;
    if (model.operation == ButtonOperationAdd || model.operation == ButtonOperationSubtract)
    {
        [self applyOppView];
    }
    else
    {
        [self applyNumericView];
    }
    
    [self addLabelToView];
}

- (void)addLabelToView
{
    [self.contentView addSubview:self.label];
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:@[[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]]];
    
    [self setNeedsUpdateConstraints];
}

- (void)applyNumericView
{
    self.backgroundColor =
        [UIColor colorWithRed:213/255.0f green:213/255.0f blue:213/255.0f alpha:1.0f];
}

- (void)applyOppView
{
    self.backgroundColor = [UIColor orangeColor];
}


@end
