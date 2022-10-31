import Foundation
import SwiftUI
import PhotosUI

class PhotoPicker: ObservableObject {
    enum ImageState {
        case empty, loading(Progress), success(Data), failure(Error)
    }
    
    var data: Data?

    @Published private(set) var imageState: ImageState = .empty

    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }

    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else { return }

                switch result {
                case .success(let image?):
                    self.imageState = .success(image)
                    self.data = image
                case .success(nil):
                    self.imageState = .empty
                case.failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }

}
