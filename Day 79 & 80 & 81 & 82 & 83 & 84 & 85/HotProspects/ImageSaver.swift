//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Deraldo on 27/10/22.
//

import UIKit
//Utilizado para conseguir salvar a imagem
class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil) //Pega uma imagem (no caso self pq é a própria imagem), use a função saveCompleted
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
