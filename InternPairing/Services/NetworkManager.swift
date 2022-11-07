
import Foundation
import Network

class NetworkManager: ObservableObject {
    
    // TODO: General implementation?
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkManager")
    @Published var isConnected: Bool?
    
    init(){
        
        monitor.pathUpdateHandler = { path in
            
            
            if path.status != .satisfied {
                print("No Internet connection")
                
                self.isConnected = false
            }
            
            if path.status == .satisfied {
                print("You're successfully connected to the Internet")
                
                self.isConnected = true
            }
        }
        monitor.start(queue: queue)
    }
}
