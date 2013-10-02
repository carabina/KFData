////
////  KFDataCollectionViewDataSource.h
////  KFData
////
////  Created by Kyle Fuller on 01/10/2013.
////  Copyright (c) 2012-2013 Kyle Fuller. All rights reserved.
////
//
//#import <Availability.h>
//
//#if __IPHONE_OS_VERSION_MIN_REQUIRED
//#import <UIKit/UIKit.h>
//#import <CoreData/CoreData.h>
//
//
///** KFDataCollectionViewDataSource is a collection view data source for dealing with a fetch request. */
//
//@interface KFDataCollectionViewDataSource : NSObject <UICollectionViewDataSource>
//
//@property (nonatomic, strong, readonly) UICollectionView *collectionView;
//@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic, strong, readonly) NSFetchRequest *fetchRequest;
//@property (nonatomic, strong, readonly) KFDataTableViewCellHandler cellHandler;
//
//- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
//                  managedObjectContext:(NSManagedObjectContext *)managedObjectContext
//                          fetchRequest:(NSFetchRequest *)fetchRequest
//                    sectionNameKeyPath:(NSString *)sectionNameKeyPath
//                             cacheName:(NSString *)cacheName
//                           cellHandler:(KFDataTableViewCellHandler)cellHandler;
//
//- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
//                         objectManager:(KFObjectManager *)objectManager
//                    sectionNameKeyPath:(NSString *)sectionNameKeyPath
//                             cacheName:(NSString *)cacheName
//                           cellHandler:(KFDataTableViewCellHandler)cellHandler;
//
///** Executes the fetch request on the store to get objects and load them into the table view.
// @returns YES if successful or NO (and an error) if a problem occurred.
// An error is returned if the fetch request specified doesn't include a sort descriptor that uses sectionNameKeyPath.'
// */
//- (BOOL)performFetch:(NSError **)error;
//
///** Retrieve the object for the index path
// @param indexPath to retrieve the object for
// @return The managed object for this index path.
// */
//- (NSManagedObject *)objectAtIndexPath:(NSIndexPath *)indexPath;
//
//@end
//
//#endif
