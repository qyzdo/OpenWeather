//
//  Networking.m
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import "WeatherDataManager.h"

@implementation WeatherDataManager

- (void)getWeather: (void (^)(Weather* weather))callback {
    NSMutableString *urlString = [NSMutableString new];
    [urlString appendString:@"https://openweathermap.org/data/2.5/weather?q=London,uk&appid="];
    [urlString appendString:APIKey];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        if (!error && [httpResponse statusCode] == 200) {
            NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            Weather *weather = [Weather fromJSON:jsonString encoding:NSUTF8StringEncoding error:&error];
            callback(weather);
        } else {
            NSLog(@"DOWNLOADING DATA ERROR");
        }
    }];
    [dataTask resume];
}


@end

