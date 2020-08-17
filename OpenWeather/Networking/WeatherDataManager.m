//
//  Networking.m
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import "WeatherDataManager.h"

@implementation WeatherDataManager

- (void)getWeather:(NSURL *)url completion:(void (^)(NSString *))callback {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        if (!error && [httpResponse statusCode] == 200) {
            NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            id weather = [NSObject new];
            weather = [Weather fromJSON:jsonString encoding:NSUTF8StringEncoding error:&error];
            callback(jsonString);
        } else {
            NSLog(@"DOWNLOADING DATA ERROR");
        }
    }];
    [dataTask resume];
}


@end

