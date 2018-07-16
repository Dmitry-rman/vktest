//
//  JMSTableViewRow.h

#import <Foundation/Foundation.h>
@class JMSTableViewCell;

@interface JMSTableViewRow : NSObject
@property (nonatomic) NSInteger identifier;
@property (nonatomic, strong) NSString * cellIdentifier;
@property (nonatomic, strong) JMSTableViewCell * cell;

+ (JMSTableViewRow *)initWithIdentifier:(NSInteger)identifier;

@end
