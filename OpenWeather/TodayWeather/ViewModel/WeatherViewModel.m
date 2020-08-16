//
//  WeatherViewModel.m
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import "WeatherViewModel.h"

@implementation WeatherViewModel

- (instancetype)init {
    self = [super init];
    if(!self) return nil;
    
    [self fetchData:^(Weather *weather) {
        
        int feelsLikeNumberInt = (int)weather.main.feelsLike;
        NSNumber *feelsLikeNumber = [NSNumber numberWithInt:feelsLikeNumberInt];
        self->_feelsLikeText = [NSString stringWithFormat:@"Feels like temperature: %@°C", [feelsLikeNumber stringValue]];
        
        int minTempNumberInt = (int)weather.main.tempMin;
        NSNumber *minTempNumber = [NSNumber numberWithInt:minTempNumberInt];
        self->_minTemperatureText = [NSString stringWithFormat:@"Min: %@°C", [minTempNumber stringValue]];
        
        int maxTempNumberInt = (int)weather.main.tempMax;
        NSNumber *maxTempNumber = [NSNumber numberWithInt:maxTempNumberInt];
        self->_maxTemperatureText = [NSString stringWithFormat:@"Max: %@°C", [maxTempNumber stringValue]];
        
        int currentTempNumberInt = (int)weather.main.temp;
        NSNumber *currentTempNumber = [NSNumber numberWithInt:currentTempNumberInt];
        self->_currentTemperatureText = [NSString stringWithFormat:@"%@°C", [currentTempNumber stringValue]];
        
        if(weather.weather[0].identifier>=500) {
            UIImage *imageView = [UIImage imageNamed:@"10d"];
            self->_weatherImage = imageView;
        }
        
        NSLog(@"%ld", (long)weather.weather[0].identifier);
        [self.delegate didFinishFetchingData:self];
    }];
    return self;
}

- (void)fetchData: (void (^)(Weather* weather))callback {
    WeatherDataManager *api = [[WeatherDataManager alloc] init];
    [api getWeather:^(Weather *weather) {
        callback(weather);
    }];
}
@end
