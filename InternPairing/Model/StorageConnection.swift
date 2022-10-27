import FirebaseStorage

import Foundation

class StorageConnection: ObservableObject {
    private var storage = Storage.storage()
    
    func uploadImage(image: Data) {
        let storageReference = storage.reference()
        let imageReference = storageReference.child("images/1")
        
        
        let uploadTask = imageReference.putData(image, metadata: nil) {
            metadata, error in
            guard let metadata = metadata else { return }
            
            let size = metadata.size
            imageReference.downloadURL { (url, error) in
                guard let downloadURL = url else { return }
                
                print(downloadURL)
            }
            
        }
    }
}
