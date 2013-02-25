//
//  KFDataViewControllerProtocol.h
//  
//
//  Created by Kyle Fuller on 20/12/2012.
//
//

#import <UIKit/UIKit.h>

@class KFDataStore;
@class NSManagedObjectContext;

@protocol KFDataViewControllerProtocol <NSObject>

- (id)initWithManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;

- (NSManagedObjectContext *)managedObjectContext;

@end

@protocol KFDataDetailViewControllerProtocol <NSObject>

- (id)initWithManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;

- (NSManagedObjectContext *)managedObjectContext;

@end

@protocol KFDataListViewControllerProtocol <NSObject>

- (id)initWithManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;

- (NSManagedObjectContext *)managedObjectContext;

- (void)setFetchRequest:(NSFetchRequest*)fetchRequest
     sectionNameKeyPath:(NSString*)sectionNameKeyPath;

- (void)performFetch;

@end
