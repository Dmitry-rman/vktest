#import "JMSTableSectionHeaderCell.h"
#import "UILabel+LinesCount.h"

@interface JMSTableSectionHeaderCell()
@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UIView * bottomSeparatorView;
@property (nonatomic, readonly) CGFloat labelWidth, labelMargin;
@end

@implementation JMSTableSectionHeaderCell
@synthesize isCellActive = _isCellActive;

- (id) init
{
    if (self = [super init]) {
        [self initializeUI];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initializeUI];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initializeUI];
    }
    return self;
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initializeUI];
    }
    return self;
}

- (void) initializeUI
{
    self.titleLabel = [[UILabel alloc] initWithFrame:(CGRect) {
        .origin = {
            self.labelMargin,
            0
        },
        .size = {
            self.labelWidth,
            self.contentView.frame.size.height
        }
    }];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.preferredMaxLayoutWidth = self.labelWidth;
    self.verticalPadding = 6;
    //self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:self.titleLabel];
    
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    _iconImageView.hidden = YES;
    [self.contentView addSubview:_iconImageView];
    
    _bottomSeparatorIsVisible = NO;
    _customHeightEnabled = NO;
    
    _bottomSeparatorView = [[UIView alloc] initWithFrame:CGRectZero];
    _bottomSeparatorView.backgroundColor = [UIColor lightGrayColor];
    _bottomSeparatorView.hidden = YES;
    [self.contentView addSubview:_bottomSeparatorView];
    
    
    _topPadding = 0;
    _iconSize = 16;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void) updateModeUI
{
    if (self.cellMode == JMSTableSectionHeaderCellModelHeader) {
        //self.titleLabel.font =
       // self.titleLabel.textColor =
    }
    if (self.cellMode == JMSTableSectionHeaderCellModelFooter) {
       // self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
       // self.titleLabel.textColor = [UIColorFromHEXRGB(0x646464) colorWithAlphaComponent:0.9f];
    }
}


- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.preferredMaxLayoutWidth = self.labelWidth;
    CGSize labelSize = [self.titleLabel sizeThatFits:CGSizeMake(self.labelWidth, CGFLOAT_MAX)];

    CGFloat bottomPadding = _verticalPadding;
    CGFloat topPadding = _topPadding > 0 ? _topPadding : _verticalPadding;
    
    if (self.cellMode == JMSTableSectionHeaderCellModelHeader) {
        labelSize.height = MAX(33-topPadding-bottomPadding, labelSize.height);
    }
    
    
    if (self.titleLabel.textAlignment == NSTextAlignmentCenter) {
        self.titleLabel.frame = (CGRect) {
            .origin = {
                self.contentView.frame.size.width/2 - labelSize.width/2,
                _customHeightEnabled ? self.contentView.frame.size.height - self.titleLabel.frame.size.height - 6 : topPadding
            },
            .size = labelSize
        };
    } else {
        self.titleLabel.frame = (CGRect) {
            .origin = {
                self.labelMargin,
                _customHeightEnabled ? self.contentView.frame.size.height - self.titleLabel.frame.size.height - 6 : topPadding
            },
            .size = labelSize
        };
    }
    
    _iconImageView.frame = (CGRect) {
        .origin = {
            self.contentView.frame.size.width - _iconSize-14,
            _titleLabel.frame.origin.y + (_titleLabel.frame.size.height/2 - _iconSize/2)
        },
        .size = {_iconSize,_iconSize}
    };
    
    _bottomSeparatorView.hidden = !_bottomSeparatorIsVisible;
    _bottomSeparatorView.frame = (CGRect) {
        .origin = {
            0,
            self.contentView.frame.size.height
        },
        .size = {
            self.contentView.frame.size.width,
            1/[UIScreen mainScreen].scale
        }
    };
}



#pragma mark - Accessors - 

- (void) setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = _title;
    [self layoutSubviews];
}

- (void) setFont:(UIFont *)font
{
    self.titleLabel.font = font;
    [self layoutSubviews];
}

- (void) setTextColor:(UIColor *)textColor
{
    self.titleLabel.textColor = textColor;
}

- (UIColor *) textColor
{
    return self.titleLabel.textColor;
}

- (UIFont *) font
{
    return self.titleLabel.font;
}

- (CGFloat) labelWidth
{
    if (_iconImage) {
        return self.contentView.frame.size.width - self.labelMargin * 2 - _iconSize - 14;
    }
    return self.contentView.frame.size.width - self.labelMargin * 2;
}

- (CGFloat) labelMargin
{
    return 15.0f;
}

- (void) setVerticalPadding:(CGFloat)verticalPadding
{
    _verticalPadding = verticalPadding;
    [self layoutSubviews];
}

- (void) setTopPadding:(CGFloat)topPadding
{
    _topPadding = topPadding;
    [self layoutSubviews];
}

- (void) setIconSize:(CGFloat)iconSize
{
    _iconSize = iconSize;
    [self layoutSubviews];
}

- (CGFloat) height
{
    CGFloat topPadding = _topPadding > 0 ? _topPadding : _verticalPadding;
    return self.titleLabel.frame.size.height + self.verticalPadding + topPadding;
}

- (void) setCellMode:(JMSTableSectionHeaderCellModel)cellMode
{
    _cellMode = cellMode;
    [self updateModeUI];
    [self layoutSubviews];
}

- (void) setBottomSeparatorIsVisible:(BOOL)bottomSeparatorIsVisible
{
    _bottomSeparatorIsVisible = bottomSeparatorIsVisible;
    [self layoutSubviews];
}

- (void) setCustomHeightEnabled:(BOOL)customHeightEnabled
{
    _customHeightEnabled = customHeightEnabled;
    [self layoutSubviews];
}

- (void) setIconImage:(UIImage *)iconImage
{
    _iconImage = iconImage;
    _iconImageView.image = _iconImage;
    _iconImageView.hidden = NO;
    [self layoutSubviews];
}

- (void) setIsCellActive:(BOOL)isCellActive {
    _isCellActive = isCellActive;
    [self updateModeUI];
}

@end
