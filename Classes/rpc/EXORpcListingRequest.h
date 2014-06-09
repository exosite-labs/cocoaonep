//
//  EXORpcListingRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

/**
 Type of RIDs
 */
enum EXORpcListType_e {
    EXORpcListTypeClient = 0x01,
    EXORpcListTypeDataport = 0x02,
    EXORpcListTypeDatarule = 0x04,
    EXORpcListTypeDispatch = 0x08,
    EXORpcListTypeAll = 0xff
};
typedef enum EXORpcListType_e EXORpcListType_t;

/**
 Filter Attributes for RIDs
 */
enum EXORpcFilterType_e {
    EXORpcFilterTypeDefault = 0x00,     /// This is the same as EXORpcFilterTypeOwned
    EXORpcFilterTypeActivated = 0x01,   /// Resources that have been shared with and activated by caller client
    EXORpcFilterTypeAliased = 0x02,     /// Resources that have been aliased by caller client
    EXORpcFilterTypeOwned = 0x04,       /// Resources owned by caller client
    EXORpcFilterTypePublic = 0x08,      /// Resources that have been made public
    EXORpcFilterTypeTagged = 0x10,      /// @warning Currently not implemented.
    EXORpcFilterTypeAll = 0xff          /// All of the resource types.
};
typedef enum EXORpcFilterType_e EXORpcFilterType_t;

/**
 Callback with the RIDs listed
 @param results Dictionary of arrays by the type of RID
 @param error nil on success, or the error encountered
 */
typedef void(^EXORpcListingRequestComplete)(NSDictionary *results, NSError *error);


/**
 * Request a listing of RIDs on a client
 */
@interface EXORpcListingRequest : EXORpcRequest <NSCopying>
@property(nonatomic,assign,readonly) EXORpcListType_t list; /// The type of RIDs being requested
@property(nonatomic,assign,readonly) EXORpcFilterType_t filter; /// The filter to apply to the request
@property(nonatomic,copy,readonly) EXORpcListingRequestComplete complete; /// The callback

/**
 Creates a request for a listing of RIDs
 
 @param list The types of RIDs to request
 @param filter The filter to apply on the RIDs
 @param complete Callback to call with the results
 @return The request
 */
+ (EXORpcListingRequest*)listingByType:(EXORpcListType_t)list filter:(EXORpcFilterType_t)filter complete:(EXORpcListingRequestComplete)complete;

/**
 Initializes a request for a listing of RIDs

 @param list The types of RIDs to request
 @param filter The filter to apply on the RIDs
 @param complete Callback to call with the results
 @return The request
 */
- (instancetype)initWithType:(EXORpcListType_t)list filter:(EXORpcFilterType_t)filter complete:(EXORpcListingRequestComplete)complete;

@end
