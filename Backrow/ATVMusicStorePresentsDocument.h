/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/AppleTV.framework/AppleTV
 */

#import "ATVURLDocument.h"

@class NSURL, NSString, NSDictionary;

__attribute__((visibility("hidden")))
@interface ATVMusicStorePresentsDocument : ATVURLDocument {
@private
	long _collectionNumber;	// 60 = 0x3c
	NSString *_requestID;	// 64 = 0x40
	NSURL *_redirectURL;	// 68 = 0x44
	NSDictionary *_catalogCollection;	// 72 = 0x48
}
@property(readonly, retain) NSDictionary *catalogCollection;	// G=0x34c56b69; converted property
@property(readonly, retain) NSURL *redirectURL;	// G=0x34c56b59; converted property
+ (id)documentWithURLRequest:(id)urlrequest requestID:(id)anId collectionNumber:(long)number;	// 0x34c56a45
- (id)initWithURLRequest:(id)urlrequest requestID:(id)anId collectionNumber:(long)number;	// 0x34c56a91
// converted property getter: - (id)catalogCollection;	// 0x34c56b69
- (void)dealloc;	// 0x34c56af1
- (void)documentLoadedWithCompletionHandler:(id)completionHandler;	// 0x34c56b79
// converted property getter: - (id)redirectURL;	// 0x34c56b59
@end

