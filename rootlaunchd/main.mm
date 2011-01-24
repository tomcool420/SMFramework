
static CFDataRef daemonCallBack(CFMessagePortRef local, SInt32 msgid, CFDataRef cfData, void *info) {
	const char *data = (const char *) CFDataGetBytePtr(cfData);
	UInt16 dataLen = CFDataGetLength(cfData);
    NSLog(@"daemon Callback");
    if (dataLen > 0 && data)
    {
        NSDictionary *dd = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:(NSData *)cfData 
                                                                            mutabilityOption:0 
                                                                                      format:NULL 
                                                                            errorDescription:nil];
        NSLog(@"daemon Callback %@",dd);
    }
    return NULL;  // as stated in header, both data and returnData will be released for us after callback returns
}

int main(int argc, char **argv, char **envp) 
{
    NSAutoreleasePool *p = [[NSAutoreleasePool alloc]init];
    
    NSLog(@"hello");
    CFMessagePortRef local = CFMessagePortCreateLocal(NULL, CFSTR("org.tomcool.lowtide.daemon"), daemonCallBack, NULL, false);
    NSLog(@"creating port");
    if (!local) {
        NSLog(@"   error creating port");
    }
    CFRunLoopSourceRef source = CFMessagePortCreateRunLoopSource(NULL, local, 0);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    CFRunLoopRun();
    [p release];
    CFRelease(local);
    return 0;
}

// vim:ft=objc
