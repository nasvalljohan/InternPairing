import FirebaseStorage
import Foundation

class StorageManager: ObservableObject, Identifiable {
    internal var id = UUID()
    
    private var storage = Storage.storage()
    
    var stringUrl = ""
    
    func uploadImage(image: Data, completion: @escaping((String?) -> () )) {
        DispatchQueue.global(qos: .userInteractive).async {
            let storageReference = self.storage.reference()
            let imageReference = storageReference.child("\(self.id)") // Later UUID from user
            
            
            let _ = imageReference.putData(image, metadata: nil) {
                metadata, error in
                
                if let error = error {
                    print(error.localizedDescription)
                }
                
                if let metadata = metadata {
                    // Success
                    let _ = metadata.size
                    imageReference.downloadURL { (url, error) in
                        
                        guard let downloadURL = url else { return } // Check download
                        
                        completion(downloadURL.absoluteString)
                    }
                }
            }
        }
    }
}
