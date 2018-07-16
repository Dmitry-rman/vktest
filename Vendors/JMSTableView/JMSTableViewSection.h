//
//  JMSTableViewSection.h

#import <Foundation/Foundation.h>
#import "JMSTableViewRow.h"
#import "JMSTableSectionHeaderCell.h"

@interface JMSTableViewSection : NSObject
@property (nonatomic) NSInteger identifier;
@property (nonatomic, strong) NSString *headerText;
@property (nonatomic, strong) NSString *footerText;
@property (nonatomic, strong) JMSTableSectionHeaderCell * header;
@property (nonatomic, strong) JMSTableSectionHeaderCell * footer;
@property (nonatomic, readonly) NSArray * rows;

+ (JMSTableViewSection *)initWithIdentifier:(NSInteger)identifier;

- (void) appendRowWithIdentifier:(NSInteger)identifier completion:(void (^)(JMSTableViewRow *))completion;
- (void) removeRow:(JMSTableViewRow*)row;

- (JMSTableViewRow*) rowByIdentifier:(NSInteger)identifier;

//- (JMSTableViewRow*)rowAtIndex:(NSInteger)index;
//- (JMSTableViewRow*)rowAtIdentifier:(NSInteger)identifier;

@end
