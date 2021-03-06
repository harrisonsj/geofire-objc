//
//  GFRealDataTest.m
//  GeoFire
//
//  Created by Jonny Dimond on 7/9/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

#import "GFRealDataTest.h"

#import "TestHelpers.h"

#import <FirebaseCore/FirebaseCore.h>
#import <FirebaseDatabase/FirebaseDatabase.h>

@import Firebase;

@implementation GFRealDataTest

- (void)setUp
{
    [super setUp];
    static dispatch_queue_t backgroundQueue = NULL;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FIROptions *options = [[FIROptions alloc] initWithGoogleAppID:@"1:1069647793992:ios:91eecf4730fc920b"
                                                          GCMSenderID:@"1069647793992"];
        options.databaseURL = @"https://testapp-5d356.firebaseio.com";

        [FIRApp configureWithOptions:options];

        backgroundQueue = dispatch_queue_create("com.firebase.geofire.test", DISPATCH_QUEUE_SERIAL);
        [[FIRDatabase database] setCallbackQueue:backgroundQueue];
    });

    self.firebaseRef = [[FIRDatabase database] referenceWithPath:@"_test"];
    self.geoFire = [[GeoFire alloc] initWithFirebaseRef:self.firebaseRef];
    self.geoFire.callbackQueue = backgroundQueue;
}

- (void)tearDown
{
    [super tearDown];
    dispatch_semaphore_t wait = dispatch_semaphore_create(0);

    [self.firebaseRef setValue:nil withCompletionBlock:^(NSError *error, FIRDatabaseReference *ref) {
        dispatch_semaphore_signal(wait);
    }];

    dispatch_semaphore_wait(wait, dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC));
}

@end
