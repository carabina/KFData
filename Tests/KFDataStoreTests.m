//
//  KFDataStoreTests.m
//  KFData
//
//  Created by Kyle Fuller on 12/08/2013.
//  Copyright 2012-2013  Kyle Fuller. All rights reserved.
//

#import "KFDataTests.h"


@interface KFDataStoreTests : XCTestCase

@end

@implementation KFDataStoreTests

#pragma mark - Unimplemented abstract class raises exception

- (void)testUnimplementedAddPersistentStoreRaisesException {
    KFDataStore *store = [[KFDataStore alloc] init];
    expect(^{ [store addPersistentStoreWithType:nil configuration:nil URL:nil options:nil error:nil]; }).to.raiseAny();
}

- (void)testUnimplementedPersistentStoreCoordinatorRaisesException {
    KFDataStore *store = [[KFDataStore alloc] init];
    expect(^{ [store persistentStoreCoordinator]; }).to.raiseAny();
}

- (void)testUnimplementedManagedObjectContextRaisesException {
    KFDataStore *store = [[KFDataStore alloc] init];
    expect(^{ [store managedObjectContext]; }).to.raiseAny();
}

- (void)testUnimplementedPerformWriteBlockRaisesException {
    KFDataStore *store = [[KFDataStore alloc] init];
    expect(^{ [store performWriteBlock:nil completion:nil]; }).to.raiseAny();
}

- (void)testUnimplementedPerformReadBlockRaisesException {
    KFDataStore *store = [[KFDataStore alloc] init];
    expect(^{ [store performReadBlock:nil]; }).to.raiseAny();
}

#pragma mark - Cluster Class Routing

- (void)testSingleStackStoreCreation {
    KFDataStore *store = [KFDataStore storeWithConfigurationType:KFDataStoreConfigurationTypeSingleStack];
    expect(NSStringFromClass([store class])).to.equal(@"KFDataSingleStackStore");
}

- (void)testSingleResetStackStoreCreation {
    KFDataStore *store = [KFDataStore storeWithConfigurationType:KFDataStoreConfigurationTypeSingleResetStack];
    expect(NSStringFromClass([store class])).to.equal(@"KFDataSingleResetStackStore");
}

- (void)testDualStackStoreCreation {
    KFDataStore *store = [KFDataStore storeWithConfigurationType:KFDataStoreConfigurationTypeDualStack];
    expect(NSStringFromClass([store class])).to.equal(@"KFDataDualStackStore");
}

- (void)testDualResetStackStoreCreation {
    KFDataStore *store = [KFDataStore storeWithConfigurationType:KFDataStoreConfigurationTypeDualResetStack];
    expect(NSStringFromClass([store class])).to.equal(@"KFDataDualResetStackStore");
}

#pragma mark - Test common helpers

- (void)testStandardLocalDataStoreShouldBeDualStack {
    NSError *error;
    KFDataStore *store = [KFDataStore standardLocalDataStore:&error];
    expect(NSStringFromClass([store class])).to.equal(@"KFDataDualStackStore");
    expect(error).to.beNil();
}

- (void)testStandardLocalDataStoreShouldBeSingleStack {
    NSError *error;
    KFDataStore *store = [KFDataStore standardMemoryDataStore:&error];
    expect(NSStringFromClass([store class])).to.equal(@"KFDataSingleStackStore");
    expect(error).to.beNil();
}

#pragma mark -

- (void)testSingleStackStoreAddsPersistentStore {
    KFDataStore *store = [KFDataStore storeWithConfigurationType:KFDataStoreConfigurationTypeSingleStack];
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [store persistentStoreCoordinator];
    NSPersistentStore *persistentStore = [store addMemoryStore:nil error:nil];

    expect([[persistentStoreCoordinator persistentStores] containsObject:persistentStore]).to.beTruthy();
}

#pragma mark - Dual stack store only supports SQLite

- (void)testDualStackStoreCannotAddMemoryPersistentStore {
    KFDataStore *store = [KFDataStore storeWithConfigurationType:KFDataStoreConfigurationTypeDualStack];
    NSPersistentStore *persistentStore = [store addMemoryStore:nil error:nil];
    expect(persistentStore).to.beNil();
}

- (void)testDualStackStoreCannotAddBinaryPersistentStore {
    KFDataStore *store = [KFDataStore storeWithConfigurationType:KFDataStoreConfigurationTypeDualStack];
    NSPersistentStore *persistentStore = [store addPersistentStoreWithType:NSBinaryStoreType configuration:nil URL:nil options:nil error:nil];
    expect(persistentStore).to.beNil();
}

@end
