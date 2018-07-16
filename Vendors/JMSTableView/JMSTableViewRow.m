//
//  JMSTableViewRow.m

#import "JMSTableViewRow.h"

@implementation JMSTableViewRow

+ (JMSTableViewRow *) initWithIdentifier:(NSInteger)identifier {
    JMSTableViewRow * row = [JMSTableViewRow new];
    row.identifier = identifier;
    return row;
}

@end
