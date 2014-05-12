# CocoaOneP

CocoaOneP is a bindings library for the Exosite One Platform.

[![Version](http://cocoapod-badges.herokuapp.com/v/CocoaOneP/badge.png)](http://cocoadocs.org/docsets/CocoaOneP)
[![Platform](http://cocoapod-badges.herokuapp.com/p/CocoaOneP/badge.png)](http://cocoadocs.org/docsets/CocoaOneP)

[![Build Status](https://travis-ci.org/CocoaOneP/CocoaOneP.svg)](https://travis-ci.org/CocoaOneP/CocoaOneP)

This is still a beta release. Some things are still quite fluid.
The next release (0.4.0) will have changes to the API.

The complete [Exosite One Platform API](https://github.com/exosite/docs) covers a lot of
ground.  This set of bindings only covers the following lower-level APIs:
- HTTP Data Interface API
- Remote Procedure Call API
- Portals API

You need to be at least partially familar with the low-level APIs to use this library well.

## Usage

To run the example project; clone the repo, and run `pod install` from the Project directory first.

For simple interactions with One Platform, use the HTTP Data Interface.  Create a
`EXOHttpClient` for each device client, and then use the `readAliases:complete:` and
`writeAliases:complete:`.  Using the HTTP Data Interface assumes that the clients in One
Platform have been completely setup.

For more complex interactions, use the Remote Procedure Call API.  Create an `EXORpc`, build up
an array of requests, and send them with `doRPCwithAuth:requests::complete:`.

We are in the progress of adding appledoc to all the headers.


## Requirements

CocoaOneP requires Xcode 5, targeting either iOS 7.0 and above, or Mac OS 10.8 Mountain Lion.
It also depends on [AFNetworking 2.0](https://github.com/AFNetworking/AFNetworking).

## Installation with CocoaPods

CocoaOneP is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

```ruby
pod "CocoaOneP"
```


## License

License is BSD, Copyright 2014, Exosite LLC. See the LICENSE file for more info.

