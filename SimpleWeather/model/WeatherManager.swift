import Foundation

struct WeatherManager{
    
    var location:GetLocation?
    
    mutating func update(update:@escaping (WeatherModel)->Void){
        location = GetLocation{coord in
            GetWeather().getWeather(coord: coord){weatherModel in
                DispatchQueue.main.async {
                    update(weatherModel)
                }
            }
        }
    }
    
    mutating func update(url:String, update:@escaping (WeatherModel)->Void){
        GetWeather().getWeather(city: url){weatherModel in
            DispatchQueue.main.async {
                update(weatherModel)
            }
        }
    }
}
