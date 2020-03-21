//
//  CityWeatherViewCell.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 21/03/2020.
//

import UIKit


//TODO: Bind with CellViewModel

class CityWeatherViewCell: UITableViewCell, ViewIdentifiable {
    
    @IBOutlet weak private var labelCityName:UILabel!
    @IBOutlet weak private var labelDescription:UILabel!
    @IBOutlet weak private var labelMinMax:UILabel!
    @IBOutlet weak private var labelWind:UILabel!
    @IBOutlet weak private var labelTemperature:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    
    func bindWithForecast(_ forecast:Forecast){
        labelCityName.text = forecast.cityName
        labelDescription.text = forecast.weather.first?.description?.capitalized
        let min = forecast.temperature.min ?? 0
        let max = forecast.temperature.max ?? 0
        labelMinMax.text = "Max: \(max.temperatureCelsius) Min \(min.temperatureCelsius)"
        
        labelTemperature.text = forecast.temperature.temp?.temperatureCelsius
        
        labelWind.text = """
        Wind
        \(forecast.wind.speed ?? 0)
        """
    }
    
}

extension Double{
    var temperatureCelsius:String{
        let measurement = Measurement(value: self, unit: UnitTemperature.celsius)
        
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .temperatureWithoutUnit
        
        return measurementFormatter.string(from: measurement)
    }
}
