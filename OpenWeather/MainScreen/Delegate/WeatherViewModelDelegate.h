//
//  WeatherViewModelDelegate.h
//  OpenWeather
//
//  Created by Oskar Figiel on 16/08/2020.
//

@class WeatherViewModel;
 
@protocol WeatherViewModelDelegate <NSObject>
 
- (void) didFinishFetchingData:(WeatherViewModel*) sender;

@end
