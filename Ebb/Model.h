//
//  Model.h
//  Ebb
//
//  Created by Daniel Walsh on 5/19/12.
//  Copyright (c) 2012 Walsh walsh Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject {
    NSArray *headers;
    NSArray *properties;
    NSArray *outputs;
    NSMutableArray *parameters;
    NSMutableArray *results;


}

- (NSUInteger) numberOfSections;
- (NSUInteger) numberOfRowsInSection: (NSInteger) section;
- (NSUInteger) numberOfRowsInResults: (NSInteger) section;
- (NSString *) text: (NSIndexPath *) indexPath row: (NSUInteger) row;
- (NSString *) headers: (NSInteger) section;
- (NSArray *) section: (NSIndexPath *) indexPath;
- (NSArray *) getValues: (NSIndexPath *) indexPath;
- (NSMutableArray *) updateValues: (NSIndexPath *) indexPath;
- (NSArray *) getOutputs: (NSIndexPath *) indexPath;
- (NSArray *) getResults: (NSIndexPath *) indexPath;
- (void) calculateResults;
@end
