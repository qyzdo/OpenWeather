//
//  Weather.h
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import <Foundation/Foundation.h>

@class Weather;
@class WeatherCurrent;
@class WeatherElement;
@class WeatherMain;
@class WeatherDescription;
@class WeatherDaily;
@class WeatherFeelsLike;
@class WeatherTemp;
@class WeatherMinutely;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface WeatherMain : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (WeatherMain *)clear;
+ (WeatherMain *)clouds;
@end

@interface WeatherDescription : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (WeatherDescription *)brokenClouds;
+ (WeatherDescription *)clearSky;
+ (WeatherDescription *)fewClouds;
+ (WeatherDescription *)overcastClouds;
+ (WeatherDescription *)scatteredClouds;
@end

#pragma mark - Object interfaces

@interface Weather : NSObject
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lon;
@property (nonatomic, copy)   NSString *timezone;
@property (nonatomic, assign) NSInteger timezoneOffset;
@property (nonatomic, strong) WeatherCurrent *current;
@property (nonatomic, copy)   NSArray<WeatherMinutely *> *minutely;
@property (nonatomic, copy)   NSArray<WeatherCurrent *> *hourly;
@property (nonatomic, copy)   NSArray<WeatherDaily *> *daily;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
@end

@interface WeatherCurrent : NSObject
@property (nonatomic, assign)           NSInteger dt;
@property (nonatomic, nullable, strong) NSNumber *sunrise;
@property (nonatomic, nullable, strong) NSNumber *sunset;
@property (nonatomic, assign)           double temp;
@property (nonatomic, assign)           double feelsLike;
@property (nonatomic, assign)           NSInteger pressure;
@property (nonatomic, assign)           NSInteger humidity;
@property (nonatomic, assign)           double dewPoint;
@property (nonatomic, nullable, strong) NSNumber *uvi;
@property (nonatomic, assign)           NSInteger clouds;
@property (nonatomic, assign)           NSInteger visibility;
@property (nonatomic, assign)           double windSpeed;
@property (nonatomic, assign)           NSInteger windDeg;
@property (nonatomic, copy)             NSArray<WeatherElement *> *weather;
@property (nonatomic, nullable, strong) NSNumber *pop;
@end

@interface WeatherElement : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) WeatherMain *main;
@property (nonatomic, assign) WeatherDescription *theDescription;
@property (nonatomic, copy)   NSString *icon;
@end

@interface WeatherDaily : NSObject
@property (nonatomic, assign) NSInteger dt;
@property (nonatomic, assign) NSInteger sunrise;
@property (nonatomic, assign) NSInteger sunset;
@property (nonatomic, strong) WeatherTemp *temp;
@property (nonatomic, strong) WeatherFeelsLike *feelsLike;
@property (nonatomic, assign) NSInteger pressure;
@property (nonatomic, assign) NSInteger humidity;
@property (nonatomic, assign) double dewPoint;
@property (nonatomic, assign) double windSpeed;
@property (nonatomic, assign) NSInteger windDeg;
@property (nonatomic, copy)   NSArray<WeatherElement *> *weather;
@property (nonatomic, assign) NSInteger clouds;
@property (nonatomic, assign) double pop;
@property (nonatomic, assign) double uvi;
@end

@interface WeatherFeelsLike : NSObject
@property (nonatomic, assign) double day;
@property (nonatomic, assign) double night;
@property (nonatomic, assign) double eve;
@property (nonatomic, assign) double morn;
@end

@interface WeatherTemp : NSObject
@property (nonatomic, assign) double day;
@property (nonatomic, assign) double min;
@property (nonatomic, assign) double max;
@property (nonatomic, assign) double night;
@property (nonatomic, assign) double eve;
@property (nonatomic, assign) double morn;
@end

@interface WeatherMinutely : NSObject
@property (nonatomic, assign) NSInteger dt;
@property (nonatomic, assign) NSInteger precipitation;
@end

NS_ASSUME_NONNULL_END
