#import "JMSTableViewCell.h"


typedef NS_ENUM(NSInteger, JMSTableSectionHeaderCellModel) {
    JMSTableSectionHeaderCellModelHeader,
    JMSTableSectionHeaderCellModelFooter
};

@interface JMSTableSectionHeaderCell : JMSTableViewCell
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) UIFont * font;
@property (nonatomic, strong) UIColor * textColor;
@property (nonatomic) CGFloat verticalPadding;
@property (nonatomic) CGFloat topPadding;
@property (nonatomic) BOOL bottomSeparatorIsVisible;
@property (nonatomic) BOOL customHeightEnabled;
@property (nonatomic, strong) UIImage * iconImage;
@property (nonatomic) CGFloat iconSize;
@property (nonatomic) JMSTableSectionHeaderCellModel cellMode;


@end
