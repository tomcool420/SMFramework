/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/AppleTV.framework/AppleTV
 */

#import <Foundation/NSURLRequest.h> // Unknown library

@class NSString, OAConsumer, OAToken;

__attribute__((visibility("hidden")))
@interface OAMutableURLRequest : NSMutableURLRequest {
@private
	OAConsumer *consumer;	// 8 = 0x8
	OAToken *token;	// 12 = 0xc
	NSString *realm;	// 16 = 0x10
	NSString *verifier;	// 20 = 0x14
	NSString *signature;	// 24 = 0x18
	NSString *nonce;	// 28 = 0x1c
	NSString *timestamp;	// 32 = 0x20
}
@property(retain) OAConsumer *consumer;	// G=0x34e04ce8; S=0x34e04dc8; @synthesize
@property(copy) NSString *nonce;	// G=0x34e04d88; S=0x34e04ed4; @synthesize
@property(copy) NSString *realm;	// G=0x34e04d28; S=0x34e04e38; @synthesize
@property(copy) NSString *signature;	// G=0x34e04d68; S=0x34e04ea0; @synthesize
@property(copy) NSString *timestamp;	// G=0x34e04da8; S=0x34e04f08; @synthesize
@property(retain) OAToken *token;	// G=0x34e04d08; S=0x34e04e00; @synthesize
@property(copy) NSString *verifier;	// G=0x34e04d48; S=0x34e04e6c; @synthesize
+ (id)requestWithURL:(id)url consumer:(id)consumer token:(id)token realm:(id)realm verifier:(id)verifier;	// 0x34e04510
- (id)initWithURL:(id)url consumer:(id)consumer token:(id)token realm:(id)realm verifier:(id)verifier;	// 0x34e04654
// declared property getter: - (id)consumer;	// 0x34e04ce8
- (void)dealloc;	// 0x34e04588
// declared property getter: - (id)nonce;	// 0x34e04d88
- (void)prepare;	// 0x34e040cc
// declared property getter: - (id)realm;	// 0x34e04d28
// declared property setter: - (void)setConsumer:(id)consumer;	// 0x34e04dc8
// declared property setter: - (void)setNonce:(id)nonce;	// 0x34e04ed4
// declared property setter: - (void)setRealm:(id)realm;	// 0x34e04e38
// declared property setter: - (void)setSignature:(id)signature;	// 0x34e04ea0
// declared property setter: - (void)setTimestamp:(id)timestamp;	// 0x34e04f08
// declared property setter: - (void)setToken:(id)token;	// 0x34e04e00
// declared property setter: - (void)setVerifier:(id)verifier;	// 0x34e04e6c
// declared property getter: - (id)signature;	// 0x34e04d68
- (id)signatureBaseString;	// 0x34e04860
// declared property getter: - (id)timestamp;	// 0x34e04da8
// declared property getter: - (id)token;	// 0x34e04d08
// declared property getter: - (id)verifier;	// 0x34e04d48
@end
