
import WatchKit
import Foundation
import CoreLocation


class InterfaceController: WKInterfaceController{

    @IBOutlet var mapView: WKInterfaceMap!
    @IBOutlet var lblLatitude: WKInterfaceLabel!
    @IBOutlet var lbllongitude: WKInterfaceLabel!
    var lat : Double = 0.0
    var long : Double = 0.0
    
    //MARK:- Lifecycle -
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        
        WatchConnector.shared.listenToReplyMessageBlock({ (message) -> WCMessageType in
            self.lat = message["lat"] as! Double
            self.long = message["long"] as! Double
            
            let mylocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.lat, self.long)
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: mylocation, span: span)
            self.mapView.setRegion(region)
            self.mapView.addAnnotation(mylocation, with: .red)
            
            return ["subscription":false]
        }, withIdentifier: "sendCurrentLocation")
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    //MARK:- Button Action -
    @IBAction func btnGetCurrentLocationClicked() {
        self.lblLatitude.setText("\(self.lat)")
        self.lbllongitude.setText("\(self.long)")
    }
}
