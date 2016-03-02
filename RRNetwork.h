#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RRNetwork : NSObject

// Download JSON
+ (void)downloadJSONFromUrlStr:(NSString *)urlStr
		 withCompletionHandler:(void (^)(id jsonData, NSError *error))completion;
		 
@end
