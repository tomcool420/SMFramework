/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/AppleTV.framework/AppleTV
 */

#import "BRBaseParserDelegate.h"

@class NSMutableArray;

__attribute__((visibility("hidden")))
@interface ATVDotMacParserDelegate : BRBaseParserDelegate {
@private
	NSMutableArray *_entries;	// 12 = 0xc
	BOOL _entryCreated;	// 16 = 0x10
	int _curIndex;	// 20 = 0x14
}
@property(readonly, retain) NSMutableArray *entries;	// G=0x34c03101; converted property
+ (id)delegate;	// 0x34c02fa9
- (id)init;	// 0x34c02fd9
- (void)__atv_end_entry;	// 0x34c030e1
- (void)__atv_start_entry:(id)entry;	// 0x34c03095
- (id)_selectorForElement:(id)element qName:(id)name end:(BOOL)end;	// 0x34c032f1
- (void)dealloc;	// 0x34c0304d
- (id)endSelectors;	// 0x34c032ed
// converted property getter: - (id)entries;	// 0x34c03101
- (id)modDate;	// 0x34c03091
- (void)parser:(id)parser didEndElement:(id)element namespaceURI:(id)uri qualifiedName:(id)name;	// 0x34c03245
- (void)parser:(id)parser didStartElement:(id)element namespaceURI:(id)uri qualifiedName:(id)name attributes:(id)attributes;	// 0x34c03189
- (void)setEntryObject:(id)object forKey:(id)key;	// 0x34c0312d
- (id)startSelectors;	// 0x34c032e9
@end
