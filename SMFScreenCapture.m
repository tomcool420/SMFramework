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
#import <IOSurface/IOSurface.h>
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
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(nil, screenSize.width, screenSize.height, 8, 4*(int)screenSize.width, rgb, kCGImageAlphaPremultipliedLast);
    CALayer *c = [[[[BRApplicationStackManager singleton] stack] peekController] layer];
    
    CGColorRef col = CGColorCreate(rgb, (CGFloat[]){ 0, 0, 0, 1 });
    c.backgroundColor=col;
    [c renderInContext:ctx];
    
    CGImageRef cgImage = CGBitmapContextCreateImage(ctx);
    c.backgroundColor=nil;
    UIImage  *img2 = [UIImage imageWithCGImage:cgImage];
    NSData *d = UIImagePNGRepresentation(img2);
    [d writeToFile:path atomically:YES];
    [d release];
    CGImageRelease(cgImage);
    CGColorRelease(col);
    CGContextRelease(ctx);
    CGColorSpaceRelease(rgb);
    
}
+(NSData *)pngScreenData
{
    
    CGSize screenSize = [BRWindow maxBounds];
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(nil, screenSize.width, screenSize.height, 8, 4*(int)screenSize.width, rgb, kCGImageAlphaPremultipliedLast);
    //CGContextTranslateCTM(ctx, 0.0, screenSize.height);
    //CGContextScaleCTM(ctx, 1.0, -1.0);
    CALayer *c = [[[[BRApplicationStackManager singleton] stack] peekController] layer];
    
    CGColorRef col = CGColorCreate(rgb, (CGFloat[]){ 0, 0, 0, 1 });
    c.backgroundColor=col;
    [c renderInContext:ctx];
    CGColorRelease(col);
    CGColorSpaceRelease(rgb);
    CGContextRelease(ctx);
    CGImageRef cgImage = CGBitmapContextCreateImage(ctx);
    c.backgroundColor=nil;

    UIImage  *img2 = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    //[UIImageJPEGRepresentation(img2,10.0) writeToFile:@"/var/mobile/Library/Preferences/image2.jpg" atomically:YES];
    return [UIImagePNGRepresentation(img2) autorelease];
}
static NSArray * ReportIOSurfaces(int minWidth, int minHeight, int searchNumber)
{
    NSMutableArray *a = [[NSMutableArray alloc]init];
    for(IOSurfaceID searchId = 0 ; searchId < searchNumber; searchId++ )
    {
        IOSurfaceRef ref = IOSurfaceLookup(searchId);
        
        if (ref) 
        {
            uint32_t width = IOSurfaceGetWidth(ref);
            uint32_t height = IOSurfaceGetHeight(ref);
            OSType pixFormat = IOSurfaceGetPixelFormat(ref);
            char formatStr[5];
            int i;
            for(i=0; i<4; i++ ) {
                formatStr[i] = ((char*)&pixFormat)[3-i];
            }
            formatStr[4]=0;
            if (width > minWidth && height > minHeight/*&& seed == surfaceSeedCounter*/)
            {
                uint32_t bytesPerElement = IOSurfaceGetBytesPerElement(ref);
                uint32_t bytesPerRow = IOSurfaceGetBytesPerRow(ref);
                int rowBytesLeftover = (int)bytesPerRow - (int)width*bytesPerElement;
                [a addObject:[NSString stringWithFormat:@"  [?] id=%d ref=0x%08x base=0x%08x (%d x %d) seed=%d format='%s' BpE=%d rowPad=%d planes:%d\n",
                       searchId,ref,IOSurfaceGetBaseAddress(ref),width,height,IOSurfaceGetSeed(ref),formatStr,
                       bytesPerElement,rowBytesLeftover,IOSurfaceGetPlaneCount(ref),nil]];
//                int planeCount= IOSurfaceGetPlaneCount(ref);
//                if (planeCount>0)
//                    ReportIOPlanes(ref);
            }
        }
    }
    return [a autorelease];
}
NSData *dataForImage(UIImage *image, NSString *path)
{
    NSData *imageData=nil;
    if ([[path pathExtension] localizedCaseInsensitiveCompare:@"png"]==NSOrderedSame) 
        imageData=UIImagePNGRepresentation(image);
    if ([[path pathExtension] localizedCaseInsensitiveCompare:@"jpg"]==NSOrderedSame ||
        [[path pathExtension] localizedCaseInsensitiveCompare:@"jpeg"]==NSOrderedSame)
        imageData=UIImageJPEGRepresentation(image,1.0);
    return imageData;
}
NSData *dataForCGImage(CGImageRef img, NSString *path)
{
    UIImage *realImage=[[UIImage alloc]initWithCGImage:img];
    NSData *d = dataForImage(realImage,path);
    [realImage release];
    return d;
}
-(NSArray *)reportIOSurfacesWidth:(int) width height:(int)height
{
    NSArray *iosurfaces = ReportIOSurfaces(width, height, 200);
    for (NSString *s in iosurfaces)
    {
        NSLog(@"%@",s);
    }
    return iosurfaces;
}
-(NSArray *)reportIOSurfaces
{
    NSArray *iosurfaces = ReportIOSurfaces(50, 50, 200);
    for (NSString *s in iosurfaces)
    {
        NSLog(@"%@",s);
    }
    return iosurfaces;
}
static int IOSurfaceAcceleratorSave(NSString *path, IOSurfaceID searchId,int minWidth, int minHeight, BOOL tiles)
{
    IOSurfaceRef ref = IOSurfaceLookup(searchId);
    uint32_t aseed;
    IOSurfaceLock(ref, kIOSurfaceLockReadOnly, &aseed);
    uint32_t width = IOSurfaceGetWidth(ref);
    uint32_t height = IOSurfaceGetHeight(ref);
    OSType pixFormat = IOSurfaceGetPixelFormat(ref);
    char formatStr[5];
    for(int i=0; i<4; i++ ) {
        formatStr[i] = ((char*)&pixFormat)[3-i];
    }
    NSString *s = [NSString stringWithFormat:@"%c%c%c%c",((char*)&pixFormat)[3],((char*)&pixFormat)[2],((char*)&pixFormat)[1],((char*)&pixFormat)[0],nil];
    //formatStr[4]='\0';
   // NSString *s = [NSString stringWithCString:formatStr encoding:NSUTF8StringEncoding];
//    if ([s length]>4) {
//        NSLog(@"length: %i,%@",[s length],[s substringToIndex:2]);
//        s=[s substringToIndex:4];
//       
//    }
    if (![s isEqualToString:@"BGRA"] && ![s isEqualToString:@"ARGB"]) {
        NSLog(@"Error: Only BGRA/ARGB surfaces supported for now");
        return 1;
    }
    if (width<minWidth) {
        printf("Error: surface width < minimum width\n");
        printf("Please Specify minimum width with -w or --width\n");
        return 2;
    }
    if (height<minHeight) {
        printf("Error: surface height < minimum height\n");
        printf("Please Specify minimum width with -h or --height\n");
        return 2;
    }
    //printSurfaceInfo(ref);
#ifdef DEBUG
    NSDate *startTime = [NSDate date];
#endif
    IOSurfaceAcceleratorRef accel=nil;
    IOSurfaceAcceleratorCreate(NULL,NULL,&accel);
    if (accel==nil) {
        printf("accelerator was not created");
        return 3;
    }
#ifdef DEBUG
    NSTimeInterval rearrangeTime=-[startTime timeIntervalSinceNow];
#endif
    int pitch = width * 4, allocSize = 4 * width * height;
    int bPE = 4;
    char pixelFormat[4] = {'A', 'R', 'G', 'B'};
    CFMutableDictionaryRef dict;
    dict = CFDictionaryCreateMutable(kCFAllocatorDefault, 0,
                                     &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFDictionarySetValue(dict, kIOSurfaceIsGlobal, kCFBooleanTrue);
    //CFDictionarySetValue(dict, kIOSurfaceMemoryRegion, (CFStringRef)@"PurpleEDRAM");
    CFDictionarySetValue(dict, kIOSurfaceBytesPerRow,
                         CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &pitch));
    CFDictionarySetValue(dict, kIOSurfaceBytesPerElement,
                         CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &bPE));
    CFDictionarySetValue(dict, kIOSurfaceWidth,
                         CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &width));
    CFDictionarySetValue(dict, kIOSurfaceHeight,
                         CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &height));
    CFDictionarySetValue(dict, kIOSurfacePixelFormat,
                         CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, pixelFormat));
    CFDictionarySetValue(dict, kIOSurfaceAllocSize,
                         CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &allocSize));
    IOSurfaceRef surf = IOSurfaceCreate(dict);
    
    CFDictionaryRef ed = (CFDictionaryRef) [[NSDictionary dictionaryWithObjectsAndKeys:nil] retain];
#ifdef DEBUG
    NSTimeInterval createTime=-[startTime timeIntervalSinceNow];
#endif
    IOSurfaceAcceleratorTransferSurface(accel,ref,surf,ed,NULL);
#ifdef DEBUG
    NSTimeInterval convertTime=-[startTime timeIntervalSinceNow]-createTime;
#endif
    IOSurfaceUnlock(ref,kIOSurfaceLockReadOnly,&aseed);
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, IOSurfaceGetBaseAddress(surf), (width * height * 4), NULL);
    CGImageRef cgImage=CGImageCreate(width, height, 8,
                                     8*4, IOSurfaceGetBytesPerRow(surf),
                                     CGColorSpaceCreateDeviceRGB(), kCGImageAlphaNoneSkipFirst |kCGBitmapByteOrder32Little,
                                     provider, NULL,
                                     YES, kCGRenderingIntentDefault);
    NSData *imageData = dataForCGImage(cgImage,path);
    if (imageData==nil) {
        printf("Error: Problem with conversion to NSData: exiting...\n");
        return 3;
    }
    BOOL d = [imageData writeToFile:path atomically:YES];
    if (d) {
        NSLog(@"IOSurface was successfully written to %@",path);
    }
    else {
        NSLog(@"image not saved");
    }

#ifdef DEBUG
    NSTimeInterval finishTime=-[startTime timeIntervalSinceNow];
    printf("times %lf %lf %lf\n",createTime,convertTime,finishTime);
#endif
    return 0;
    
}
-(void)saveSurface:(int)searchID
{
    NSLog(@"saving");
    int i = IOSurfaceAcceleratorSave([NSHomeDirectory() stringByAppendingPathComponent:@"hello.png"],(IOSurfaceID)searchID,50,50,NO);
    NSLog(@"save status: %i",i);
}
+(NSData *)controlPlaneData
{
    CGSize screenSize = [BRWindow maxBounds];
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(nil, screenSize.width, screenSize.height, 8, 4*(int)screenSize.width, rgb, kCGImageAlphaPremultipliedLast);
    //CGContextTranslateCTM(ctx, 0.0, screenSize.height);
    //CGContextScaleCTM(ctx, 1.0, -1.0);
    CALayer *c = [[[BRWindow window] _controlPlane] layer];//[[[[BRApplicationStackManager singleton] stack] peekController] layer];
    CGColorRef col = CGColorCreate(rgb, (CGFloat[]){ 0, 0, 0, 1 });
    c.backgroundColor=col;
    [c renderInContext:ctx];
    
    CGImageRef cgImage = CGBitmapContextCreateImage(ctx);
    c.backgroundColor=nil;
    CGColorRelease(col);
    CGColorSpaceRelease(rgb);
    CGContextRelease(ctx);
    //CFURLRef url = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, CFSTR("/var/mobile/Library/Preferences/image.bmp"), kCFURLPOSIXPathStyle, false);
    //CFStringRef type = kUTTypeBMP; // or kUTTypeBMP if you like
    //    CGImageDestinationRef dest = CGImageDestinationCreateWithURL(url, type, 1, 0);
    //    CGImageDestinationAddImage(dest, cgImage, 0);
    UIImage  *img2 = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);

    return [UIImagePNGRepresentation(img2) autorelease];
}
@end
