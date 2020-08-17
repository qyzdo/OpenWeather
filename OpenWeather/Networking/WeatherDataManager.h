//
//  Networking.h
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import <Foundation/Foundation.h>
#import "ApiKey.h"

@interface WeatherDataManager<ObjectType> : NSObject


- (void)getWeather: (NSURL*)url completion: (void (^)(NSString*))callback;


@end
