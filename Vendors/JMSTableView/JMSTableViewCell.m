#import "JMSTableViewCell.h"

@implementation JMSTableViewCell



#pragma mark - Init -

- (id) init
{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self commonInit];
    }
    return self;
}


- (void) commonInit
{
    _isCellActive = YES;
}



#pragma mark - Accessors -

- (CGFloat) height
{
    return 44;
}

- (void) setIsCellActive:(BOOL)isCellActive{
    _isCellActive = isCellActive;
}

@end
