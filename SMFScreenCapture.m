//
//  SMFScreenCapture.m
//  SMFramework
//
//  Created by Thomas Cool on 10/27/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFScreenCapture.h"
#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "SMFEventManager.h"
#import "SMFEvent.h"
#import "SMFPhotoMethods.h"
#import "SMFEventConfiguration.h"
#import "SMFQueryMenu.h"
#define testDomain (CFStringRef)@"org.tomcool.test"
@implementation SMFScreenCapture
SYNTHESIZE_SINGLETON_FOR_CLASS(SMFScreenCapture,sharedInstance)
-(NSString *)displayName
{
    return @"Built In Functions";
    
}
-(id)init
{
    self=[super init];
    if (self!=nil) {
//        [[SMFEventManager sharedManager]registerListener:self forName:@"events.screenshot"];
//        [[SMFEventManager sharedManager]setKey:@"=" forName:@"events.screenshot"];
//        [[SMFEventManager sharedManager]registerListener:self forName:@"events.test"];
//        [[SMFEventManager sharedManager]setKey:@"-" forName:@"events.test"];
//        [[SMFEventManager sharedManager]setRemoteAction:15 forName:@"events.test"];
//        [[SMFEventManager sharedManager]setRemoteAction:18 forName:@"events.screenshot"];
//        [[SMFEventManager sharedManager]setRemoteAction:63265 forName:@"events.screenshot"];
//        [[SMFEventManager sharedManager]registerListener:self forName:@"events.reboot"];
//        [[SMFEventManager sharedManager]registerListener:self forName:@"events.restartLowtide"];
    }
    return self;
}
-(void)actionForEvent:(SMFEvent *)event
{
    if ([event.name isEqualToString:@"events.screenshot"]) {
        [SMFScreenCapture saveScreenToFile:@"/screenshot.png"];
    }
    else if ([event.name isEqualToString:@"events.test"]) {
//        BRDataStore *store = [SMFPhotoMethods dataStoreForPath:@"/System/Library/PrivateFrameworks/AppleTV.framework/DefaultAnimalPhotos/"];
//        BRPhotoControlFactory* controlFactory = [BRPhotoControlFactory standardFactory];
//        SMFPhotoCollectionProvider* provider    = [SMFPhotoCollectionProvider providerWithDataStore:store controlFactory:controlFactory];//[[ATVSettingsFacade sharedInstance] providerForScreenSaver];//[collection provider];
//        SMFPhotoBrowserController* pc  = [SMFPhotoBrowserController controllerForProvider:provider];
//        [pc setTitle:@"DefaultAnimalPhotos"];
//        [[[BRApplicationStackManager singleton] stack] pushController:pc];
        
        
//        SMFEventConfiguration *ec = [[SMFEventConfiguration alloc] init];
        CFPreferencesSetValue((CFStringRef)@"testVal", [NSNumber numberWithBool:0], testDomain, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost);
        CFPreferencesSynchronize(testDomain, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost);
        //        SMFQueryMenu *ec = [[SMFQueryMenu alloc]init];
//        [[[BRApplicationStackManager singleton] stack] pushController:ec];
//        [ec release];
    }
}
+(void)saveScreenToFile:(NSString *)path
{
    CGSize screenSize = [BRWindow maxBounds];
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB(); 
    CGContextRef ctx = CGBitmapContextCreate(nil, screenSize.width, screenSize.height, 8, 4*(int)screenSize.width, colorSpaceRef, kCGImageAlphaPremultipliedLast);
    CALayer *c = [[[[BRApplicationStackManager singleton] stack] peekController] layer];
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGColorRef col = CGColorCreate(rgb, (CGFloat[]){ 0, 0, 0, 1 });
    c.backgroundColor=col;
    [c renderInContext:ctx];
    
    CGImageRef cgImage = CGBitmapContextCreateImage(ctx);
    c.backgroundColor=nil;
    UIImage  *img2 = [UIImage imageWithCGImage:cgImage];
    [UIImagePNGRepresentation(img2) writeToFile:path atomically:YES];
    
}
+(NSData *)pngScreenData
{
    
    CGSize screenSize = [BRWindow maxBounds];
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB(); 
    CGContextRef ctx = CGBitmapContextCreate(nil, screenSize.width, screenSize.height, 8, 4*(int)screenSize.width, colorSpaceRef, kCGImageAlphaPremultipliedLast);
    //CGContextTranslateCTM(ctx, 0.0, screenSize.height);
    //CGContextScaleCTM(ctx, 1.0, -1.0);
    CALayer *c = [[[[BRApplicationStackManager singleton] stack] peekController] layer];
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGColorRef col = CGColorCreate(rgb, (CGFloat[]){ 0, 0, 0, 1 });
    c.backgroundColor=col;
    [c renderInContext:ctx];
    
    CGImageRef cgImage = CGBitmapContextCreateImage(ctx);
    c.backgroundColor=nil;
    
    //CFURLRef url = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, CFSTR("/var/mobile/Library/Preferences/image.bmp"), kCFURLPOSIXPathStyle, false);
    //CFStringRef type = kUTTypeBMP; // or kUTTypeBMP if you like
    //    CGImageDestinationRef dest = CGImageDestinationCreateWithURL(url, type, 1, 0);
    //    CGImageDestinationAddImage(dest, cgImage, 0);
    UIImage  *img2 = [UIImage imageWithCGImage:cgImage];
    //[UIImageJPEGRepresentation(img2,10.0) writeToFile:@"/var/mobile/Library/Preferences/image2.jpg" atomically:YES];
    return UIImagePNGRepresentation(img2);
}
+(NSData *)controlPlaneData
{
    CGSize screenSize = [BRWindow maxBounds];
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB(); 
    CGContextRef ctx = CGBitmapContextCreate(nil, screenSize.width, screenSize.height, 8, 4*(int)screenSize.width, colorSpaceRef, kCGImageAlphaPremultipliedLast);
    //CGContextTranslateCTM(ctx, 0.0, screenSize.height);
    //CGContextScaleCTM(ctx, 1.0, -1.0);
    CALayer *c = [[[BRWindow window] _controlPlane] layer];//[[[[BRApplicationStackManager singleton] stack] peekController] layer];
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGColorRef col = CGColorCreate(rgb, (CGFloat[]){ 0, 0, 0, 1 });
    c.backgroundColor=col;
    [c renderInContext:ctx];
    
    CGImageRef cgImage = CGBitmapContextCreateImage(ctx);
    c.backgroundColor=nil;
    
    //CFURLRef url = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, CFSTR("/var/mobile/Library/Preferences/image.bmp"), kCFURLPOSIXPathStyle, false);
    //CFStringRef type = kUTTypeBMP; // or kUTTypeBMP if you like
    //    CGImageDestinationRef dest = CGImageDestinationCreateWithURL(url, type, 1, 0);
    //    CGImageDestinationAddImage(dest, cgImage, 0);
    UIImage  *img2 = [UIImage imageWithCGImage:cgImage];
    //[UIImageJPEGRepresentation(img2,10.0) writeToFile:@"/var/mobile/Library/Preferences/image2.jpg" atomically:YES];
    return UIImagePNGRepresentation(img2);
}
@end
