//
//  CityDayWeatherViewCell.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 21/03/2020.
//

import UIKit

class CityDayWeatherViewCell: UITableViewCell, ViewIdentifiable {
    
    @IBOutlet weak var labelDate:UILabel!
    @IBOutlet weak var labelTemperature1:UILabel!
    @IBOutlet weak var labelTemperature2:UILabel!
    @IBOutlet weak var labelTemperature3:UILabel!
    
    private var dayForecast:DayForecast?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func bindWith(Forecast dayForecast:DayForecast){
        self.dayForecast = dayForecast
        
        //MARK: Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dayForecast.date){
            if Calendar.current.isDateInToday(date){
                labelDate.text = "Today"
            }else if Calendar.current.isDateInTomorrow(date){
                labelDate.text = "Tomorrow"
            }else{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE"
                let dayInWeek = dateFormatter.string(from: date)
                labelDate.text = dayInWeek
            }
        }
        
        //MARK: Time 1
        if !displayTemperatureAt(Index: 0, for: labelTemperature1){
            labelTemperature1.text = nil
        }
        //MARK: Time 2
        if !displayTemperatureAt(Index: 1, for: labelTemperature2){
            labelTemperature2.text = nil
        }
        //MARK: Time 3
        if !displayTemperatureAt(Index: 2, for: labelTemperature3){
            labelTemperature3.text = nil
        }
    }
    
    //Safe check and display label
    private func displayTemperatureAt(Index index:Int, for label:UILabel)-> Bool{
        guard let forcasts = dayForecast?.forcasts, index < forcasts.count  else { return false}
        let forcast = forcasts[index]
        label.text = temperatureFormatOf(froecast: forcast)
        return true
    }
    
    
    private func temperatureFormatOf(froecast:Forecast) -> String{
        let time = froecast.datetime?.toTime ?? ""
        return """
        \(froecast.temperature.temp?.temperatureCelsius ?? "")
        \(time)
        """
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        labelDate.text = nil
        labelTemperature1.text = nil
        labelTemperature2.text = nil
        labelTemperature3.text = nil
    }
}


private extension String{
    
    var toTime:String{
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let dateTime = dateTimeFormatter.date(from: self) else { return "" }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: dateTime)
    }
}
