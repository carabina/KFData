//
//  NSManagedObject+KFData.h
//  KFData
//
//  Created by Kyle Fuller on 26/11/2012.
//  Copyright (c) 2012 Kyle Fuller. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (KFData)

+ (NSArray*)executeFetchRequest:(NSFetchRequest*)fetchRequest
         inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;
+ (id)executeFetchRequestAndEnsureSingleObject:(NSFetchRequest*)fetchRequest
									  inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;
+ (id)executeFetchRequestAndReturnFirstObject:(NSFetchRequest*)fetchRequest
									 inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;
+ (id)executeFetchRequestAndReturnLastObject:(NSFetchRequest*)fetchRequest
									inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;

+ (NSEntityDescription*)entityDescriptionInManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;

+ (id)createInManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;

+ (NSUInteger)removeAllInManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;
+ (NSUInteger)removeAllInManagedObjectContext:(NSManagedObjectContext*)managedObjectContext
                                withPredicate:(NSPredicate*)predicate;

@end
