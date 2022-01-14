import SwiftUI
import UIKit

struct ImagePicker {
    @Binding var selectedImage: UIImage

    var sourceType: UIImagePickerController.SourceType = .photoLibrary
}

extension ImagePicker: UIViewControllerRepresentable {
    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        
        if !UIImagePickerController.isSourceTypeAvailable(sourceType) {
            pickerController.sourceType = .photoLibrary
        } else {
            pickerController.sourceType = sourceType
        }
        pickerController.delegate = context.coordinator
        return pickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
}
