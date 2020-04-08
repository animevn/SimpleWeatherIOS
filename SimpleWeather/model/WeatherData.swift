import Foundation

struct WeatherId:Codable{
    let id:Int
}

struct Main:Codable{
    let temp:Double
}

struct WeatherData:Codable{
    let name:String
    let weather:[WeatherId]
    let main:Main
}

struct Coord{
    let lat:Double
    let lon:Double
}
