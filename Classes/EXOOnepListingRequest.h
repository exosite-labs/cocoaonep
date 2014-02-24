//
//  EXOOnepListingRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"

enum EXOOnepListType_e {
    EXOOnepListTypeClient = 0x01,
    EXOOnepListTypeDataport = 0x02,
    EXOOnepListTypeDatarule = 0x04,
    EXOOnepListTypeDispatch = 0x08,
    EXOOnepListTypeAll = 0xff
};
typedef enum EXOOnepListType_e EXOOnepListType_t;

enum EXOOnepFilterType_e {
    EXOOnepFilterTypeActivated = 0x01,
    EXOOnepFilterTypeAliased = 0x02,
    EXOOnepFilterTypeOwned = 0x04,
    EXOOnepFilterTypePublic = 0x08,
    EXOOnepFilterTypeTagged = 0x10,
    EXOOnepFilterTypeAll = 0xff
};
typedef enum EXOOnepFilterType_e EXOOnepFilterType_t;

typedef void(^EXOOnepListingRequestComplete)(NSDictionary *results, NSError *err);

@interface EXOOnepListingRequest : EXOOnepRequest <NSCopying>
@property(nonatomic,assign,readonly) EXOOnepListType_t list;
@property(nonatomic,assign,readonly) EXOOnepFilterType_t filter;
@property(nonatomic,copy,readonly) EXOOnepListingRequestComplete complete;

+ (EXOOnepListingRequest*)listingByRID:(EXOOnepResourceID *)rid list:(EXOOnepListType_t)list filter:(EXOOnepFilterType_t)filter complete:(EXOOnepListingRequestComplete)complete;
- (instancetype)initWithRID:(EXOOnepResourceID *)rid list:(EXOOnepListType_t)list filter:(EXOOnepFilterType_t)filter complete:(EXOOnepListingRequestComplete)complete;

@end
