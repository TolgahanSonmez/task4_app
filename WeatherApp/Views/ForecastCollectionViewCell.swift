//
//  ForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Tolgahan Sonmez on 9.03.2023.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var labelDate: UILabel!
    
    public func configure(with viewModel: CityWeatherViewModel) {
        labelTemp.text = viewModel.temperatureString
        imageIcon.image = UIImage(named: viewModel.weatherCondion)
    }
}
