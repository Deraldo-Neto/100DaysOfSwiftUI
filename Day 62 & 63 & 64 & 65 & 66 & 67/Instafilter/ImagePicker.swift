//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Deraldo on 24/10/22.
//

import PhotosUI
import SwiftUI
//DA PRA USAR ESSA STRUCT EM QUALQUER PROJETO
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        //PHPicker serve para detectar quando uma imagem foi clicada
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) { //PHPickerViewController nos da a opção de cancelar e o array de resultados é quando pro exemplo escolhemos uma ou várias imagens.
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) { //conseguimos carregar algum tipo de objeto?
                provider.loadObject(ofClass: UIImage.self) { image, _ in //tentamos carregar o objeto
                    self.parent.image = image as? UIImage
                }
            }//conseguiu nos devolver uma imagem
        }
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController { //Pegamos as imagens da nossa galeria
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator //Use o coordinator como um PHPicker
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator { //faz a comunicação entre o UIKit e o SwiftUI, quando a gente clica em alguma imagem ou no cancel, a gente conta pro coordinator o que aconteceu
        Coordinator(self) //Passo a minha estrutura de imagem para a coordenada
    }
}
