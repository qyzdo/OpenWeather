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
    
    self.numberOfRows = 15;
    self.numberOfSections = 1;
    
    [self fetchData:^(Weather *weather) {
        
        int feelsLikeNumberInt = (int)weather.current.feelsLike;
        NSNumber *feelsLikeNumber = [NSNumber numberWithInt:feelsLikeNumberInt];
        self->_feelsLikeText = [NSString stringWithFormat:@"Feels like temperature: %@°C", [feelsLikeNumber stringValue]];
        
        int minTempNumberInt = (int)weather.daily[0].temp.min;
        NSNumber *minTempNumber = [NSNumber numberWithInt:minTempNumberInt];
        self->_minTemperatureText = [NSString stringWithFormat:@"Min: %@°C", [minTempNumber stringValue]];
        
        int maxTempNumberInt = (int)weather.daily[0].temp.max;
        NSNumber *maxTempNumber = [NSNumber numberWithInt:maxTempNumberInt];
        self->_maxTemperatureText = [NSString stringWithFormat:@"Max: %@°C", [maxTempNumber stringValue]];
        
        int currentTempNumberInt = (int)weather.current.temp;
        NSNumber *currentTempNumber = [NSNumber numberWithInt:currentTempNumberInt];
        self->_currentTemperatureText = [NSString stringWithFormat:@"%@°C", [currentTempNumber stringValue]];
        
        NSString *imageIcon = weather.current.weather[0].icon;
        UIImage *imageView = [UIImage imageNamed:imageIcon];
        self->_weatherImage = imageView;
        
        [self.delegate didFinishFetchingData:self];
    }];
    return self;
}

- (void)fetchData: (void (^)(Weather* weather))callback {
    WeatherService *service = [WeatherService new];
    [service getTodayWeather:^(Weather *weather) {
        callback(weather);
    }];

}
@end
