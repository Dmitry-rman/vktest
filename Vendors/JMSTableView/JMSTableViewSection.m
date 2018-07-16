//
//  JMSTableViewSection.m

#import "JMSTableViewSection.h"

@interface JMSTableViewSection()
@property (nonatomic, strong) NSMutableArray * rowsArray;
@end;

@implementation JMSTableViewSection

+ (JMSTableViewSection *) initWithIdentifier:(NSInteger)identifier {
    JMSTableViewSection * section = [JMSTableViewSection new];
    section.identifier = identifier;
    return section;
}


- (id) init {
    if (self = [super init]) {
        [self configureInit];
    }
    return self;
}

- (void) configureInit {
    _rowsArray = [NSMutableArray new];
}

- (void) appendRow:(JMSTableViewRow *)row {
    [_rowsArray addObject:row];
}

- (void) appendRowWithIdentifier:(NSInteger)identifier completion:(void (^)(JMSTableViewRow *))completion {
    JMSTableViewRow * row = [JMSTableViewRow initWithIdentifier:identifier];
    [_rowsArray addObject:row];
    completion(row);
}

- (void) removeRow:(JMSTableViewRow *)row {
    if ([_rowsArray containsObject:row]) {
        [_rowsArray removeObject:row];
    }
}



#pragma mark - Accessors -

- (NSArray *)rows {
    return _rowsArray;
}

- (JMSTableViewRow *)rowByIdentifier:(NSInteger)identifier {
    for (JMSTableViewRow * row in _rowsArray) {
        if (row.identifier == identifier) {
            return row;
        }
    }
    return nil;
}

@end
