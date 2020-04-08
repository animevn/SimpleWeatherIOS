import CoreLocation

protocol LocationDelegate {
    func onLocationResult(coord:Coord)
    func onLocationError(error:Error?)
}

class GetLocation:NSObject, CLLocationManagerDelegate{
    
    private var locationManager:CLLocationManager = CLLocationManager()
    private var locationDelegate:LocationDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationDelegate?.onLocationError(error: error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last?.coordinate else {return}
        DispatchQueue.main.async {[weak self] in
            self?.locationDelegate?
                .onLocationResult(coord: Coord(lat: location.latitude, lon: location.longitude))
            self?.locationManager.stopUpdatingLocation()
        }
    }
}

