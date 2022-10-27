import FirebaseStorage

import Foundation

class StorageConnection: ObservableObject, Identifiable {
    internal var id = UUID()
    
    private var storage = Storage.storage()
    
    var stringUrl = ""
    
    func uploadImage(image: Data) {
        let storageReference = storage.reference()
        let imageReference = storageReference.child("\(self.id)") // Later UUID from user
        
        
        let uploadTask = imageReference.putData(image, metadata: nil) {
            metadata, error in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let metadata = metadata {
                // Success
                let size = metadata.size
                imageReference.downloadURL { (url, error) in
                    
                    guard let downloadURL = url else { return } // Check download
                    
                    self.stringUrl = "\(downloadURL)"
                }
            }
        }
    }
}
