//
//  Weather.m
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import "Weather.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface Weather (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface WeatherCurrent (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface WeatherElement (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface WeatherDaily (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface WeatherFeelsLike (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface WeatherTemp (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface WeatherMinutely (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

// These enum-like reference types are needed so that enum
// values can be contained by NSArray and NSDictionary.

@implementation WeatherMain
+ (NSDictionary<NSString *, WeatherMain *> *)values
{
    static NSDictionary<NSString *, WeatherMain *> *values;
    return values = values ? values : @{
        @"Clear": [[WeatherMain alloc] initWithValue:@"Clear"],
        @"Clouds": [[WeatherMain alloc] initWithValue:@"Clouds"],
    };
}

+ (WeatherMain *)clear { return WeatherMain.values[@"Clear"]; }
+ (WeatherMain *)clouds { return WeatherMain.values[@"Clouds"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return WeatherMain.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation WeatherDescription
+ (NSDictionary<NSString *, WeatherDescription *> *)values
{
    static NSDictionary<NSString *, WeatherDescription *> *values;
    return values = values ? values : @{
        @"broken clouds": [[WeatherDescription alloc] initWithValue:@"broken clouds"],
        @"clear sky": [[WeatherDescription alloc] initWithValue:@"clear sky"],
        @"few clouds": [[WeatherDescription alloc] initWithValue:@"few clouds"],
        @"overcast clouds": [[WeatherDescription alloc] initWithValue:@"overcast clouds"],
        @"scattered clouds": [[WeatherDescription alloc] initWithValue:@"scattered clouds"],
    };
}

+ (WeatherDescription *)brokenClouds { return WeatherDescription.values[@"broken clouds"]; }
+ (WeatherDescription *)clearSky { return WeatherDescription.values[@"clear sky"]; }
+ (WeatherDescription *)fewClouds { return WeatherDescription.values[@"few clouds"]; }
+ (WeatherDescription *)overcastClouds { return WeatherDescription.values[@"overcast clouds"]; }
+ (WeatherDescription *)scatteredClouds { return WeatherDescription.values[@"scattered clouds"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return WeatherDescription.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

static id map(id collection, id (^f)(id value)) {
    id result = nil;
    if ([collection isKindOfClass:NSArray.class]) {
        result = [NSMutableArray arrayWithCapacity:[collection count]];
        for (id x in collection) [result addObject:f(x)];
    } else if ([collection isKindOfClass:NSDictionary.class]) {
        result = [NSMutableDictionary dictionaryWithCapacity:[collection count]];
        for (id key in collection) [result setObject:f([collection objectForKey:key]) forKey:key];
    }
    return result;
}

#pragma mark - JSON serialization

Weather *_Nullable WeatherFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [Weather fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

Weather *_Nullable WeatherFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return WeatherFromData([json dataUsingEncoding:encoding], error);
}

@implementation Weather
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"lat": @"lat",
        @"lon": @"lon",
        @"timezone": @"timezone",
        @"timezone_offset": @"timezoneOffset",
        @"current": @"current",
        @"minutely": @"minutely",
        @"hourly": @"hourly",
        @"daily": @"daily",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return WeatherFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return WeatherFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[Weather alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _current = [WeatherCurrent fromJSONDictionary:(id)_current];
        _minutely = map(_minutely, λ(id x, [WeatherMinutely fromJSONDictionary:x]));
        _hourly = map(_hourly, λ(id x, [WeatherCurrent fromJSONDictionary:x]));
        _daily = map(_daily, λ(id x, [WeatherDaily fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = Weather.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = Weather.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:Weather.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in Weather.properties) {
        id propertyName = Weather.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"current": [_current JSONDictionary],
        @"minutely": map(_minutely, λ(id x, [x JSONDictionary])),
        @"hourly": map(_hourly, λ(id x, [x JSONDictionary])),
        @"daily": map(_daily, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}

@end

@implementation WeatherCurrent
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"dt": @"dt",
        @"sunrise": @"sunrise",
        @"sunset": @"sunset",
        @"temp": @"temp",
        @"feels_like": @"feelsLike",
        @"pressure": @"pressure",
        @"humidity": @"humidity",
        @"dew_point": @"dewPoint",
        @"uvi": @"uvi",
        @"clouds": @"clouds",
        @"visibility": @"visibility",
        @"wind_speed": @"windSpeed",
        @"wind_deg": @"windDeg",
        @"weather": @"weather",
        @"pop": @"pop",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[WeatherCurrent alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _weather = map(_weather, λ(id x, [WeatherElement fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = WeatherCurrent.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = WeatherCurrent.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:WeatherCurrent.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in WeatherCurrent.properties) {
        id propertyName = WeatherCurrent.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"weather": map(_weather, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation WeatherElement
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"main": @"main",
        @"description": @"theDescription",
        @"icon": @"icon",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[WeatherElement alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _main = [WeatherMain withValue:(id)_main];
        _theDescription = [WeatherDescription withValue:(id)_theDescription];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = WeatherElement.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = WeatherElement.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:WeatherElement.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in WeatherElement.properties) {
        id propertyName = WeatherElement.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"main": [_main value],
        @"description": [_theDescription value],
    }];

    return dict;
}
@end

@implementation WeatherDaily
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"dt": @"dt",
        @"sunrise": @"sunrise",
        @"sunset": @"sunset",
        @"temp": @"temp",
        @"feels_like": @"feelsLike",
        @"pressure": @"pressure",
        @"humidity": @"humidity",
        @"dew_point": @"dewPoint",
        @"wind_speed": @"windSpeed",
        @"wind_deg": @"windDeg",
        @"weather": @"weather",
        @"clouds": @"clouds",
        @"pop": @"pop",
        @"uvi": @"uvi",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[WeatherDaily alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _temp = [WeatherTemp fromJSONDictionary:(id)_temp];
        _feelsLike = [WeatherFeelsLike fromJSONDictionary:(id)_feelsLike];
        _weather = map(_weather, λ(id x, [WeatherElement fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = WeatherDaily.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = WeatherDaily.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:WeatherDaily.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in WeatherDaily.properties) {
        id propertyName = WeatherDaily.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"temp": [_temp JSONDictionary],
        @"feels_like": [_feelsLike JSONDictionary],
        @"weather": map(_weather, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation WeatherFeelsLike
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"day": @"day",
        @"night": @"night",
        @"eve": @"eve",
        @"morn": @"morn",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[WeatherFeelsLike alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = WeatherFeelsLike.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = WeatherFeelsLike.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:WeatherFeelsLike.properties.allValues];
}
@end

@implementation WeatherTemp
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"day": @"day",
        @"min": @"min",
        @"max": @"max",
        @"night": @"night",
        @"eve": @"eve",
        @"morn": @"morn",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[WeatherTemp alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = WeatherTemp.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = WeatherTemp.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:WeatherTemp.properties.allValues];
}
@end

@implementation WeatherMinutely
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"dt": @"dt",
        @"precipitation": @"precipitation",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[WeatherMinutely alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = WeatherMinutely.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = WeatherMinutely.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:WeatherMinutely.properties.allValues];
}
@end

NS_ASSUME_NONNULL_END
