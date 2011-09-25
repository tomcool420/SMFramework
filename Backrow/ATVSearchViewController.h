/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/AppleTV.framework/AppleTV
 */

#import "BRViewController.h"
#import "AppleTV-Structs.h"
#import "BRTextFieldDelegate.h"
#import "ATVSearchViewDelegate.h"

@class NSString, ATVSearchView, NSTimer, NSCache;

@interface ATVSearchViewController : BRViewController <ATVSearchViewDelegate, BRTextFieldDelegate> {
@private
	NSTimer *_delayedLoadTimer;	// 64 = 0x40
	NSCache *_resultsCache;	// 68 = 0x44
	NSString *_latestSearchString;	// 72 = 0x48
	NSString *_latestSearchStringWithResults;	// 76 = 0x4c
}
@property(readonly, assign) NSString *latestSearchStringWithResults;	// G=0x34de05a9; @synthesize=_latestSearchStringWithResults
@property(readonly, assign) ATVSearchView *searchView;	// G=0x34de03ad; @dynamic
- (id)init;	// 0x34de025d
- (void)_handleDelayedLoad:(id)load;	// 0x34de072d
- (id)_latestSearchString;	// 0x34de05b9
- (id)_latestSearchStringWithResults;	// 0x34de0795
- (void)_restoreLatestSearchStringWithResults;	// 0x34de0811
- (void)_setDelayedLoadTimer:(id)timer;	// 0x34de0705
- (void)_setLatestSearchString:(id)string;	// 0x34de05c9
- (void)_setResults:(id)results forSearch:(id)search;	// 0x34de052d
- (void)_updateLatestSearchStringWithResults:(id)results;	// 0x34de07a5
- (void)dealloc;	// 0x34de0331
// declared property getter: - (id)latestSearchStringWithResults;	// 0x34de05a9
// declared property getter: - (id)searchView;	// 0x34de03ad
- (void)searchView:(id)view focusDidChangeToControl:(int)focus;	// 0x34de0431
- (void)searchWithString:(id)string;	// 0x34de03c1
- (void)textDidChange:(id)text;	// 0x34de0465
- (void)textDidEndEditing:(id)text;	// 0x34de0529
@end
