import CoreLocation

class GetLocation:NSObject, CLLocationManagerDelegate{
    
    private var locationManager:CLLocationManager = CLLocationManager()
    var coord: (Coord)->Void
    
    init(coord:@escaping (Coord)->Void) {
        self.coord = coord
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        print("location start")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last?.coordinate else {return}
        
        DispatchQueue.main.async {
            self.coord(Coord(lat: location.latitude, lon: location.longitude))
            self.locationManager.stopUpdatingLocation()
            print("location stop")
        }
        
        
    }
}

