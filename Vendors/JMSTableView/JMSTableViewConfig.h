//
//  JMSTableViewConfig.h

#import <Foundation/Foundation.h>
#import "JMSTableViewSection.h"
#import "JMSTableViewRow.h"

@interface JMSTableViewConfig : NSObject
@property (nonatomic, readonly) NSArray * sections;

- (void) appendSection:(JMSTableViewSection *)section;
- (void) removeSection:(JMSTableViewSection *)section;
- (void) appendSectionWithIdentifier:(NSInteger)identifier completion:(void (^)(JMSTableViewSection *))completion;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (JMSTableViewSection*) sectionAtSection:(NSInteger)section;
- (JMSTableViewSection*) sectionByIdentifier:(NSInteger)identifier;
- (JMSTableViewRow *)rowAtIndexPath:(NSIndexPath*)indexPath;
- (NSArray *) getAllRows;
- (NSString*) footerTextInSection:(NSInteger)section;
- (NSString*) headerTextInSection:(NSInteger)section;

@end
