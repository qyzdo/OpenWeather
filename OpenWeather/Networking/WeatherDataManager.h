//
//  Networking.h
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import <Foundation/Foundation.h>
#import "ApiKey.h"
#import "Weather.h"

@interface WeatherDataManager : NSObject


- (void)getWeather: (void (^)(Weather* weather))callback;


@end
