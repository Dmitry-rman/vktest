//
//  JMSTableViewConfig.m

#import "JMSTableViewConfig.h"

@interface JMSTableViewConfig()
@property (nonatomic, strong) NSMutableArray * sectionsArray;

@end

@implementation JMSTableViewConfig

- (id) init {
    if (self = [super init]) {
        [self configureInit];
    }
    return self;
}

- (void) configureInit {
    _sectionsArray = [NSMutableArray new];
}

- (void) appendSectionWithIdentifier:(NSInteger)identifier completion:(void (^)(JMSTableViewSection *))completion {
    JMSTableViewSection * section = [JMSTableViewSection initWithIdentifier:identifier];
    [_sectionsArray addObject:section];
    if(completion)completion(section);
}

- (void) removeSection:(JMSTableViewSection *)section {
    if ([_sectionsArray containsObject:section]) {
        [_sectionsArray removeObject:section];
    }
}


#pragma mark - Table Sources -

- (NSInteger)numberOfSections {
    return self.sections.count;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return ((JMSTableViewSection *)self.sections[section]).rows.count;
}

- (NSString*) footerTextInSection:(NSInteger)section {
    return ((JMSTableViewSection *)self.sections[section]).footerText;
}

- (NSString*) headerTextInSection:(NSInteger)section {
    return ((JMSTableViewSection *)self.sections[section]).headerText;
}

- (JMSTableViewRow *)rowAtIndexPath:(NSIndexPath*)indexPath {
    return ((JMSTableViewSection *)self.sections[indexPath.section]).rows[indexPath.row];
}

- (JMSTableViewSection *) sectionAtSection:(NSInteger)section {
    return self.sections[section];
}




#pragma mark - Accessors -

- (NSArray *)sections {
    return _sectionsArray;
}

- (JMSTableViewSection *)sectionByIdentifier:(NSInteger)identifier {
    for (JMSTableViewSection * section in _sectionsArray) {
        if (section.identifier == identifier) {
            return section;
        }
    }
    return nil;
}

- (NSArray *)getAllRows {
    NSMutableArray * rows = [NSMutableArray new];
    for (JMSTableViewSection * section in _sectionsArray) {
        for (JMSTableViewRow * row in section.rows) {
            [rows addObject:row];
        }
    }
    return [NSArray arrayWithArray:rows];
}

@end
