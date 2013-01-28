//
// NSManagedObjectContext+KFData.m
// KFData
//
// Created by Kyle Fuller on 26/11/2012
// Copyright (c) 2012 Kyle Fuller. All rights reserved
//

#import "NSManagedObjectContext+KFData.h"

@implementation NSManagedObjectContext (KFData)

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -

- (BOOL)save {
    BOOL saved = NO;

    if ([self hasChanges]) {
        NSError *error;

        @try {
            saved = [self save:&error];
        } @catch (NSException *exception) {
            NSLog(@"KFData - [NSManagedObjectContext save] (%@)", exception);
        }

        if (saved == NO) {
            NSLog(@"KFData - [NSManagedObjectContext save] (%@)", error);
        }
    }

    return saved;
}

- (BOOL)nestedSave {
    __block BOOL saved = [self save];

    if (saved) {
        NSManagedObjectContext *parentContext = [self parentContext];

        [parentContext performBlockAndWait:^{
            saved = [parentContext nestedSave];
        }];
    }

    return saved;
}

- (void)performSave {
    if ([self hasChanges]) {
        [self performBlock:^{
            BOOL saved = NO;
            NSError *error;
            
            @try {
                saved = [self save:&error];
            } @catch (NSException *exception) {
                NSLog(@"KFData - [NSManagedObjectContext save] (%@)", exception);
            }
            
            if (saved == NO) {
                NSLog(@"KFData - [NSManagedObjectContext save] (%@)", error);
            }
        }];
    }
}

- (void)performNestedSave {
    [self performBlock:^{
        if ([self save]) {
            NSManagedObjectContext *parentContext = [self parentContext];
            [parentContext performNestedSave];
        }
    }];
}

#pragma mark -

- (void)performWriteBlock:(void(^)(void))writeBlock {
    [self performBlock:^{
        writeBlock();
        [self nestedSave];
    }];
}

- (void)performWriteBlock:(void(^)(void))writeBlock
        completionHandler:(void(^)(void))completionHandler
{
    [self performBlock:^{
        writeBlock();

        [self nestedSave];

        if (completionHandler) {
            completionHandler();
        }
    }];
}

#pragma mark - 

- (void)obtainPermanentIDsBeforeSaving {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextWillSave:) name:NSManagedObjectContextWillSaveNotification object:self];
}

- (void)contextWillSave:(NSNotification*)notification {
	NSManagedObjectContext* context = (NSManagedObjectContext*)[notification object];
    if ([[context insertedObjects] count] > 0) {
        NSArray* insertedObjects = [[context insertedObjects] allObjects];
        NSError* error = nil;
        [context obtainPermanentIDsForObjects:insertedObjects error:&error];
#pragma message("should we handle errors here?")
    }
}

@end
