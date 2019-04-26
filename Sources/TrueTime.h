//
//  TrueTime.h
//  TrueTime
//
//  Created by Michael Sanders on 7/9/16.
//  Copyright © 2016 Instacart. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

//! Project version number for TrueTime.
FOUNDATION_EXPORT double TrueTimeVersionNumber;

//! Project version string for TrueTime.
FOUNDATION_EXPORT const unsigned char TrueTimeVersionNumberString[];

//! Domain for TrueTime errors.
FOUNDATION_EXPORT NSString * const TrueTimeErrorDomain;

//! Notification sent whenever a TrueTimeClient's reference time is updated.
FOUNDATION_EXPORT NSString * const TrueTimeUpdatedNotification;

//! Notification sent whenever a TrueTimeClient's reference time is updated with the first result.
FOUNDATION_EXPORT NSString * const TrueTimeFirstUpdateNotification;

//! Notification sent whenever a TrueTimeClient's reference time finished updating.
//! (only sent when update was successful/when the reference time was updated with a new value)
FOUNDATION_EXPORT NSString * const TrueTimeFinishedUpdatingNotification;

NS_ASSUME_NONNULL_END
