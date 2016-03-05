
#import "KeyboardOperationsManager.h"
#import "KeyboardButtonModel.h"
#import "KeyboardButtonsCollectionDelegate.h"

static const int PositiveOperatorValue = 1;
static const int NegativeOperatorValue = -1;

@interface KeyboardOperationsManager()

@property (nonatomic, weak) id<KeyboardButtonsCollectionDelegateProtocol> actionsDelegate;

@property (nonatomic, strong) NSNumber* firstOperand;
@property (nonatomic, strong) NSNumber* secondOperand;
@property (nonatomic, strong) NSNumberFormatter* numberFormatter;
@property (nonatomic, copy) NSString* workingOperandString;
@property (nonatomic, copy) NSString* firstOperandString;
@property (nonatomic, copy) NSString* secondOperandString;
@property (nonatomic, assign) int firstOperator;
@property (nonatomic, assign) int secondOperator;
@property (nonatomic, assign) BOOL didPostResult;

@end

@implementation KeyboardOperationsManager

-(instancetype)initWithActionsDelegate:(id<KeyboardButtonsCollectionDelegateProtocol>)actionsDelegate
{
    self = [super init];
    if (!self)
        return nil;

    _actionsDelegate = actionsDelegate;
    _workingOperandString = @"";

    _numberFormatter = [NSNumberFormatter new];
    _numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    _firstOperator = PositiveOperatorValue;

    return self;
}

- (void)operationRequestWithModel:(KeyboardButtonModel*)model
{
    model.operation != ButtonOperationDefault ?
            [self handleOperatorInputWithModel:model] :
            [self handleOperandInputWithModel:model];
}

- (void)handleOperandInputWithModel:(KeyboardButtonModel*)model
{
    NSString* tempWorkingString = [self.workingOperandString stringByAppendingString:model.labelValue];
    NSNumber* operand = [self.numberFormatter numberFromString:tempWorkingString];
    if (!operand)
        return;

    self.workingOperandString = tempWorkingString;
    [self addOperandWithLiteral:model.labelValue];
}

- (void)handleOperatorInputWithModel:(KeyboardButtonModel*)model
{
    if (model.operation == ButtonOperationEnter)
    {
        [self handleEnterOperation];
    }
    if (model.operation == ButtonOperationAdd)
    {
        [self handleAddOperation];
    }
    if (model.operation == ButtonOperationSubtract)
    {
        [self handleSubtractOperation];
    }
    if (model.operation == ButtonOperationDot)
    {
        [self handleDotOperation];
    }
}

- (NSString*)prettyResult
{
    NSNumber* result = [self calculate];
    return [NSString stringWithFormat:@"%@", result];
}

- (NSNumber*)calculate
{
    self.firstOperand = [self.numberFormatter numberFromString:self.firstOperandString];
    self.secondOperand = [self.numberFormatter numberFromString:self.secondOperandString];

    double result = self.firstOperator * [self.firstOperand doubleValue] + self.secondOperator * [self.secondOperand doubleValue];
    
    self.firstOperandString = [@(result) stringValue];
    self.workingOperandString = @"";
    self.firstOperator = PositiveOperatorValue;
    self.secondOperator = PositiveOperatorValue;
    self.didPostResult = YES;
    return @(result);
}

#pragma mark - Verifiers

- (BOOL)isLegalMidOperation
{
    return self.workingOperandString && !self.firstOperandString && !self.secondOperandString;
}

- (BOOL)isLegalConsecutiveOperation
{
    return self.firstOperandString && self.secondOperandString && !self.didPostResult;
}

#pragma mark - Operation Handlers

- (void)handleConsecutiveOperation
{
    self.didPostResult = NO;
    self.secondOperandString = @"";
    [self.actionsDelegate setTrackWithResult:self.firstOperandString];
}

- (void)handleEnterOperation
{
    if (self.firstOperandString && self.workingOperandString)
    {
        self.secondOperandString = self.workingOperandString;
        [self.actionsDelegate setCalculationResult:[self prettyResult]];
    }
}

- (void)handleDotOperation
{
    if (self.workingOperandString && ![self.workingOperandString containsString:@"."])
    {
        self.workingOperandString = [self.workingOperandString stringByAppendingString:@"."];
    }
}

- (void)handleSubtractOperation
{
    if (!self.workingOperandString && !self.firstOperandString)
    {
        self.firstOperator = NegativeOperatorValue;
        return;
    }
    
    if ([self isLegalMidOperation])
    {
        self.firstOperandString = self.workingOperandString;
        self.workingOperandString = @"";
        [self postSubtractOperation];
        return;
    }
    
    if ([self isLegalConsecutiveOperation])
    {
        [self handleEnterOperation];
        [self postSubtractOperation];
    }
    
    if (self.didPostResult)
    {
        [self handleConsecutiveOperation];
        [self postSubtractOperation];
    }
}

- (void)handleAddOperation
{
    if ([self isLegalMidOperation])
    {
        self.firstOperandString = self.workingOperandString;
        self.workingOperandString = @"";
        self.secondOperator = PositiveOperatorValue;
        [self postAddOperation];
    }
    
    if ([self isLegalConsecutiveOperation])
    {
        [self handleEnterOperation];
        [self postAddOperation];
    }
    
    if (self.didPostResult)
    {
        [self handleConsecutiveOperation];
        [self postAddOperation];
    }
}

- (void)postSubtractOperation
{
    self.secondOperator = NegativeOperatorValue;
    [self.actionsDelegate updateTrackWithLiteral:@"-"];
}

- (void)postAddOperation
{
    [self.actionsDelegate updateTrackWithLiteral:@"+"];
}

- (void)addOperandWithLiteral:(NSString*)literal
{
    if ([self.workingOperandString containsString:@"."])
    {
        [self.actionsDelegate updateTrackWithLiteral:[NSString stringWithFormat:@".%@", literal]];
        return;
    }
    [self.actionsDelegate updateTrackWithLiteral:literal];
}

@end