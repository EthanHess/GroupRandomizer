//
//  NameController.h
//  groupRandomizer
//
//  Created by Ethan Hess on 5/29/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Name.h"

@interface NameController : NSObject

@property (nonatomic, strong) NSArray *names;
@property (nonatomic, strong) NSArray *temporaryNames; 

+ (NameController *)sharedInstance;

- (void)addNameWithNameString:(NSString *)nameString; 

- (void)removeName:(Name *)name;

- (NSArray *)shuffle:(NSArray *)array;

@end
