//
//  HourWeatherCollectionViewCell.h
//  OpenWeather
//
//  Created by Oskar Figiel on 21/08/2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HourWeatherCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *weatherImage;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;

@end

NS_ASSUME_NONNULL_END
