//
//  MeView.swift
//  HotProspects
//
//  Created by Deraldo on 27/02/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = "Anonymous"
    @State private var emailAddress = "you@yoursite.com"
    @State private var qrCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("Email address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                
                Image(uiImage: qrCode) //Ele gera a imagem pra gente ao mesmo tempo, de forma dinamica, mas observe que o swift estica a imagem para caber no frame 200/200, fazendo ela ficar borrada, pq a imagem é muito pequenininha
                    .resizable()
                    .interpolation(.none) //Com isso faz o qr code ficar bem melhor, tirando o blur, sem a interpolação
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        Button {
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: qrCode)
                        } label: {
                            Label("Save to Photos", systemImage: "square.and.arrow.down")
                        }
                    }
            }
            .navigationTitle("Your code")
            .onAppear(perform: updateCode) //Com isso eu falo para quando o usuário abrir a tela, eu chamar a função updateCode
            .onChange(of: name) { _ in updateCode() } //Aqui e em baixo eu falo que caso eu atualize o nome ou o email, eu chama a função updateCode
            .onChange(of: emailAddress) { _ in updateCode() }
        }
    }
    
    func updateCode() { //Fazendo essa função eu evito loops infinitos no meu código
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                //qrCode = UIImage(cgImage: cgimg) //Se eu deixar dessa maneira, fazendo com que o qrCode seja alterado aqui, eu faço um loop, por que o qrCode é um @State, isso faz com que toda vez que ele é atualizado ele gere novamente o Body, então quando ele chega aqui, ele altera o qrCode e roda novamente o código, então ele vai chegar aqui novamente, pq dentro da Image, ele chama por essa função novamente, fazendo um loop
                //return qrCode
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
