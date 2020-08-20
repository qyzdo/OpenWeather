//
//  DayWeatherTableViewCell.m
//  OpenWeather
//
//  Created by Oskar Figiel on 19/08/2020.
//

#import "DayWeatherTableViewCell.h"

@implementation DayWeatherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.contentView.backgroundColor = UIColor.systemBackgroundColor;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.weatherImage = [[UIImageView alloc] init];
        self.weatherImage.translatesAutoresizingMaskIntoConstraints = false;
        self.weatherImage.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:self.weatherImage];
        [self.weatherImage.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:7].active = true;
        [self.weatherImage.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = true;
        [self.weatherImage.heightAnchor constraintEqualToConstant:40].active = true;
        
        self.dayNameLabel = [[UILabel alloc] init];
        self.dayNameLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        [self.contentView addSubview:self.dayNameLabel];
        
        [self.dayNameLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:15].active = true;
        [self.dayNameLabel.rightAnchor constraintEqualToAnchor:self.weatherImage.leftAnchor constant:15].active = true;
        [self.dayNameLabel.widthAnchor constraintEqualToConstant:90].active = true;

        [self.dayNameLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-15].active = true;
        
        self.minTemperatureLabel = [[UILabel alloc] init];
        self.minTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.minTemperatureLabel.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:self.minTemperatureLabel];
        [self.minTemperatureLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:15].active = true;
        [self.minTemperatureLabel.leftAnchor constraintEqualToAnchor:self.weatherImage.rightAnchor constant:-15].active = true;

        self.maxTemperatureLabel = [[UILabel alloc] init];
        self.maxTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.maxTemperatureLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        
        [self.contentView addSubview:self.maxTemperatureLabel];
        [self.maxTemperatureLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:15].active = true;
        [self.maxTemperatureLabel.leftAnchor constraintEqualToAnchor:self.minTemperatureLabel.rightAnchor constant:15].active = true;

    }
    return self;
}

@end
