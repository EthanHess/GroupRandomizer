//
//  NameController.m
//  groupRandomizer
//
//  Created by Ethan Hess on 5/29/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "NameController.h"
#import "Stack.h"

@implementation NameController

+ (NameController *)sharedInstance {
    static NameController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [NameController new];
    });
    
    return sharedInstance;
    
}

- (NSArray *)names {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Name"];
    
    NSArray *objects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    return objects;
    
}

- (void)addNameWithNameString:(NSString *)nameString {
    
    Name *name = [NSEntityDescription insertNewObjectForEntityForName:@"Name" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    name.nameString = nameString;
    
    [self synchronize];
    
}

- (void)removeName:(Name *)name {
    
    [name.managedObjectContext deleteObject:name];
    
    [self synchronize];
}

- (NSArray *)shuffle:(NSArray *)array {
    
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:array];
    
    NSUInteger count = [newArray count];
    
    for (NSUInteger i = 0; i < count; i++) {
       
        NSInteger remainingCount = count - i;
        
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t)remainingCount);
        
        [newArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
        
    }
    
    return [NSArray arrayWithArray:newArray];
}


- (void)synchronize {
    
    [[Stack sharedInstance].managedObjectContext save:NULL];
    
}

@end
