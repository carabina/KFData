
//  KFDataCollectionViewDataSource.m
//  KFData
//
//  Created by Kyle Fuller on 01/10/2013.
//  Copyright (c) 2012-2013 Kyle Fuller. All rights reserved.
//

//#import "KFDataCollectionViewDataSource.h"
//#import "KFObjectManager.h"
//
//
//@interface KFDataCollectionViewDataSource () <NSFetchedResultsControllerDelegate>
//
//@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
//
//@end
//
//@implementation KFDataTableViewDataSource
//
//- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
//              fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
//                           cellHandler:(KFDataTableViewCellHandler)cellHandler
//{
//    NSParameterAssert(collectionView != nil);
//    NSParameterAssert(fetchedResultsController != nil);
//    NSParameterAssert(cellHandler != nil);
//
//    if (self = [super init]) {
//        _cellHandler = cellHandler;
//
//        _collectionView = collectionView;
//        [collectionView setDataSource:self];
//
//        _fetchedResultsController = fetchedResultsController;
//        [_fetchedResultsController setDelegate:self];
//    }
//
//    return self;
//}
//
//- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
//                  managedObjectContext:(NSManagedObjectContext *)managedObjectContext
//                          fetchRequest:(NSFetchRequest *)fetchRequest
//                    sectionNameKeyPath:(NSString *)sectionNameKeyPath
//                             cacheName:(NSString *)cacheName
//                           cellHandler:(KFDataTableViewCellHandler)cellHandler
//{
//    NSParameterAssert(managedObjectContext != nil);
//    NSParameterAssert(fetchRequest != nil);
//
//    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:sectionNameKeyPath cacheName:cacheName];
//    return [self initWithCollectionView:collectionView fetchedResultsController:fetchedResultsController  cellHandler:cellHandler];
//}
//
//- (instancetype)initWithCollectionView:(UICollectionView *)collectionView objectManager:(KFObjectManager *)objectManager sectionNameKeyPath:(NSString *)sectionNameKeyPath cacheName:(NSString *)cacheName cellHandler:(KFDataTableViewCellHandler)cellHandler {
//    NSParameterAssert(objectManager != nil);
//
//    return [self initWithCollectionView:collectionView managedObjectContext:[objectManager managedObjectContext] fetchRequest:[objectManager fetchRequest] sectionNameKeyPath:sectionNameKeyPath cacheName:cacheName cellHandler:cellHandler];
//}
//
//- (NSManagedObjectContext *)managedObjectContext {
//    return [_fetchedResultsController managedObjectContext];
//}
//
//- (NSFetchRequest *)fetchRequest {
//    return [_fetchedResultsController fetchRequest];
//}
//
//- (BOOL)performFetch:(NSError **)error {
//    BOOL result = [[self fetchedResultsController] performFetch:error];
//    [[self collectionView] reloadData];
//    return result;
//}
//
//#pragma mark -
//
//- (id <NSFetchedResultsSectionInfo>)sectionInfoForSection:(NSUInteger)section {
//    NSArray *sections = [[self fetchedResultsController] sections];
//    return [sections objectAtIndex:section];
//}
//
//- (NSManagedObject *)objectAtIndexPath:(NSIndexPath *)indexPath {
//    return [[[self sectionInfoForSection:[indexPath section]] objects] objectAtIndex:[indexPath row]];
//}
//
//#pragma mark - NSFetchedResultsControllerDelegate
//
//- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
//    [self setSectionUpdates:[NSMutableArray array]];
//    [self setItemUpdates:[NSMutableArray array]];
//}
//
//- (void)controller:(NSFetchedResultsController *)controller
//  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
//           atIndex:(NSUInteger)sectionIndex
//     forChangeType:(NSFetchedResultsChangeType)type
//{
//    switch (type) {
//        case NSFetchedResultsChangeInsert:
//        case NSFetchedResultsChangeDelete: {
//            NSDictionary *userInfo = @{@(type): [NSIndexSet indexSetWithIndex:sectionIndex]};
//            [[self sectionUpdates] addObject:userInfo];
//            break;
//        }
//    }
//}
//
//- (void)controller:(NSFetchedResultsController *)controller
//   didChangeObject:(id)anObject
//       atIndexPath:(NSIndexPath *)indexPath
//     forChangeType:(NSFetchedResultsChangeType)type
//      newIndexPath:(NSIndexPath *)newIndexPath
//{
//    NSDictionary *userInfo;
//
//    switch (type) {
//        case NSFetchedResultsChangeInsert:
//            userInfo = @{@(type): @[newIndexPath]};
//            break;
//
//        case NSFetchedResultsChangeDelete:
//        case NSFetchedResultsChangeUpdate:
//            userInfo = @{@(type): @[indexPath]};
//            break;
//
//        case NSFetchedResultsChangeMove:
//            userInfo = @{@(type): @[indexPath, newIndexPath]};
//            break;
//    }
//
//    if (userInfo) {
//        [[self itemUpdates] addObject:userInfo];
//    }
//}
//
//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
//    NSArray *sectionUpdates = [self sectionUpdates];
//    NSArray *itemUpdates = [self itemUpdates];
//
//    [self setSectionUpdates:nil];
//    [self setItemUpdates:nil];
//
//    UICollectionView *collectionView = [self collectionView];
//
//    // http://openradar.appspot.com/12954582
//    __block BOOL shouldReload = NO;
//
//    for (NSDictionary *userInfo in sectionUpdates) {
//        [userInfo enumerateKeysAndObjectsUsingBlock:^(id key, NSIndexSet *indexSet, BOOL *stop) {
//            NSFetchedResultsChangeType type = [key unsignedIntegerValue];
//            switch (type) {
//                case NSFetchedResultsChangeInsert:
//                    *stop = shouldReload = YES; // reload for every section insert (this covers the case of first item inserts too)
//                    break;
//                case NSFetchedResultsChangeDelete:
//                    if ([[self collectionView] numberOfSections] == 1) {
//                        *stop = shouldReload = YES;
//                    } else {
//                        shouldReload = NO;
//                    }
//                    break;
//                case NSFetchedResultsChangeUpdate:
//                case NSFetchedResultsChangeMove:
//                    shouldReload = NO;
//                    break;
//            }
//        }];
//    }
//
//    if ([itemUpdates count] > 0 && [sectionUpdates count] == 0) {
//        shouldReload = YES;
//    }
//
//    if (shouldReload) {
//        [collectionView reloadData];
//        return;
//    }
//
//    if ([sectionUpdates count]) {
//        [collectionView performBatchUpdates:^{
//            for (NSDictionary *userInfo in sectionUpdates) {
//                [userInfo enumerateKeysAndObjectsUsingBlock:^(id key, NSIndexSet *indexSet, BOOL *stop) {
//                    NSFetchedResultsChangeType type = [key unsignedIntegerValue];
//
//                    switch (type) {
//                        case NSFetchedResultsChangeInsert:
//                            [collectionView insertSections:indexSet];
//                            break;
//
//                        case NSFetchedResultsChangeDelete: {
//                            [collectionView deleteSections:indexSet];
//                            break;
//                        }
//                    }
//                }];
//            }
//        } completion:nil];
//    }
//
//    if ([itemUpdates count]) {
//        [collectionView performBatchUpdates:^{
//            for (NSDictionary *userInfo in itemUpdates) {
//                [userInfo enumerateKeysAndObjectsUsingBlock:^(id key, NSArray *indexPaths, BOOL *stop) {
//                    NSFetchedResultsChangeType type = [key unsignedIntegerValue];
//
//                    switch (type) {
//                        case NSFetchedResultsChangeInsert:
//                            [collectionView insertItemsAtIndexPaths:indexPaths];
//                            break;
//
//                        case NSFetchedResultsChangeDelete:
//                            [collectionView deleteItemsAtIndexPaths:indexPaths];
//                            break;
//
//                        case NSFetchedResultsChangeUpdate:
//                            [collectionView reloadItemsAtIndexPaths:indexPaths];
//                            break;
//
//                        case NSFetchedResultsChangeMove: {
//                            NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
//                            NSIndexPath *newIndexPath = [indexPaths objectAtIndex:1];
//                            [collectionView moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
//                            break;
//                        }
//                    }
//                }];
//            }
//        } completion:nil];
//    }
//}
//
//#pragma mark - UICollectionViewDataSource
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return (NSInteger)[[[self fetchedResultsController] sections] count];
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    id <NSFetchedResultsSectionInfo> [self sectionInfoForSection:section];
//	return (NSInteger)[sectionInfo numberOfObjects];
//}

//@end