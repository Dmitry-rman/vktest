#import "UILabel+LinesCount.h"

@implementation UILabel (LinesCount)

- (NSInteger) linesCount
{
    CGSize constrain = CGSizeMake(self.bounds.size.width, FLT_MAX);
    CGRect frame = [self.text boundingRectWithSize:constrain
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:self.font}
                                     context:nil];
    
    return ceil(frame.size.height / self.font.lineHeight);
}

@end
