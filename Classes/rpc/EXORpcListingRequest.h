//
//  EXORpcListingRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

enum EXORpcListType_e {
    EXORpcListTypeClient = 0x01,
    EXORpcListTypeDataport = 0x02,
    EXORpcListTypeDatarule = 0x04,
    EXORpcListTypeDispatch = 0x08,
    EXORpcListTypeAll = 0xff
};
typedef enum EXORpcListType_e EXORpcListType_t;

enum EXORpcFilterType_e {
    EXORpcFilterTypeDefault = 0x00,
    EXORpcFilterTypeActivated = 0x01,
    EXORpcFilterTypeAliased = 0x02,
    EXORpcFilterTypeOwned = 0x04,
    EXORpcFilterTypePublic = 0x08,
    EXORpcFilterTypeTagged = 0x10,
    EXORpcFilterTypeAll = 0xff
};
typedef enum EXORpcFilterType_e EXORpcFilterType_t;

typedef void(^EXORpcListingRequestComplete)(NSDictionary *results, NSError *err);

@interface EXORpcListingRequest : EXORpcRequest <NSCopying>
@property(nonatomic,assign,readonly) EXORpcListType_t list;
@property(nonatomic,assign,readonly) EXORpcFilterType_t filter;
@property(nonatomic,copy,readonly) EXORpcListingRequestComplete complete;

+ (EXORpcListingRequest*)listingByType:(EXORpcListType_t)list filter:(EXORpcFilterType_t)filter complete:(EXORpcListingRequestComplete)complete;
- (instancetype)initWithType:(EXORpcListType_t)list filter:(EXORpcFilterType_t)filter complete:(EXORpcListingRequestComplete)complete;

@end
