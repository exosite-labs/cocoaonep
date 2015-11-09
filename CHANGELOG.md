# CocoaOneP CHANGELOG

## v1.0.0
- Upgrade to AFNetworking 3.0
- Added the web socket interface to 1P
- Dropped Portals API entirely.  Code here was out of date and buggy.
- Better intergration with Swift
- Switched to Semantic Versioning

## v0.5.1
- Fixed #5; Updating a data port clobbers the retention. 

## v0.5.0
- Fixes and example for wait request.
- Added many unit tests; still have many more to go for complete coverage.
- Added complete callback to EXORpxShareRequest.
- Dropped the HTTP Data API support.  The RPC API is richer, has better error responses, and is
  better debugged.

## v0.4.2
- Fixed some bugs in ExoHttpClient

## v0.4.1
- Added the wait request object.
- Unicode symbols for stringifed preprocessing object
- Fix initializing subscribe field from plists.

## v0.4.0
 

## v0.3.3
- Added block callback to RPC for when it is doing network activity.
- Trying an idea for collecting some common patterns atop RPC.
- Added readonly properties for the parts of EXORpcAuthKey
- Fixed bug giving 1P time in floating point. (1P wants integer)
- Made EXORpcLookupRequest, EXORpcMapRequest, and EXORpcDataportResource immutable.
- Abstracted out retention values from multiple resource objects.
- On EXOPortal, if domain is set to nil, use the default domain.
- New user and passowrd reset requests push a JSON object, not form data.


## v0.3.2
- Made EXORpcResource and its children immutable.
- Changed how a resource exports so it will work with both create and update.
- Implemented EXORpcUpdateRequest
- Couple more unit tests.

## v0.3.1
- Readied things for others


## v0.1.0

Initial release.
