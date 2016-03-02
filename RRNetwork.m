#import "RRNetwork.h"

@implementation RRNetwork

+ (void)downloadDataFromUrlStr:(NSString *)urlStr
		 withCompletionHandler:(void (^)(NSData *data, NSError *error))completion {
	
	// Сreate a queue of the same thread that the method was invoked
	NSOperationQueue *queue = [NSOperationQueue currentQueue];
	
    // Encode URL string
    
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
	// Create download task
	NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
										  dataTaskWithURL:[NSURL URLWithString:urlStr]
										  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
											  
											  NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
												  completion(data, error);
											  }];
											  // Run queue
											  [queue addOperation:op];
										  }];
	// Run download task
	[downloadTask resume];
	
}

+ (void)downloadJSONFromUrlStr:(NSString *)urlStr
         withCompletionHandler:(void (^)(id jsonData, NSError *error))completion {
	
	[self downloadDataFromUrlStr:urlStr withCompletionHandler:^(NSData *data, NSError *error) {
		
			if (!error)
			{
				// Serialize JSON
				NSError *serializeError = nil;
				id jsonData = [NSJSONSerialization JSONObjectWithData:data
															  options:NSJSONReadingMutableContainers
																error:&serializeError];
				completion(jsonData, serializeError);
			}
			else
			{
				// Handle download error
				completion(nil, error);
			}
		
	}];
	
}

@end
