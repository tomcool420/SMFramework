
static void daemonRunCode(int type, NSString *codeString){
	
	CFMessagePortRef daemonPort = 0;
	NSMutableDictionary *d = [[NSMutableDictionary alloc]init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [d setObject:codeString forKey:@"command"];
    CFDataRef data= CFPropertyListCreateData (
                                              NULL,
                                              (CFDictionaryRef)d,
                                              kCFPropertyListXMLFormat_v1_0,
                                              0,
                                              NULL);
    NSLog(@"sending info");
	if (!daemonPort || !CFMessagePortIsValid(daemonPort)) {
        NSLog(@"searching for port");
		daemonPort = CFMessagePortCreateRemote(NULL, CFSTR("org.tomcool.lowtide.daemon"));
	}
	if (!daemonPort) return;
	NSLog(@"found port");
	// create and send message
	CFMessagePortSendRequest(daemonPort, type, data, 1, 1, NULL, NULL);
    if (data) {
        CFRelease(data);
    }
}

int main(int argc, char **argv, char **envp) 
{
    NSAutoreleasePool *p = [[NSAutoreleasePool alloc]init];
    daemonRunCode(1, @"hellO");
    [p release];
    return 0;
}

// vim:ft=objc
