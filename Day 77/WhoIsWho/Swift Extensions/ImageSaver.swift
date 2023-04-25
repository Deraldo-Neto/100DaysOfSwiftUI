//
//  ImageSaver.swift
//  WhoIsWho
//
//  Created by Deraldo on 10/01/23.
//

import UIKit
import MapKit
import Foundation

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage, id: UUID) {
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            let filename = FileManager.documentsDirectory.appendingPathComponent("\(id.uuidString).jpeg")
            try? jpegData.write(to: filename, options: [.atomic, .completeFileProtection])
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
