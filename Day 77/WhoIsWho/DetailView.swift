//
//  DetailView.swift
//  WhoIsWho
//
//  Created by Deraldo on 17/01/23.
//

import SwiftUI
import MapKit

struct DetailView: View {
    let who: Who
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var locations: [Location]
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    imageWho(who: who)?
                        .resizable()
                        .clipShape(Circle())
                        .padding()
                        .frame(width: 250, height: 250)
                }
                
                VStack {
                    Text(who.name ?? "Unknown Name")
                        .font(.headline)
                }
            }
        }
        
        ZStack {
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: who.locationArray.first!.latitude, longitude: who.locationArray.first!.longitude), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))), annotationItems: locations) { location in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
            }
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding()
            
        }
    }
    
    init(who: Who, locations: [Location]) {
        self.who = who
        self.locations = locations
    }
    
    func imageWho(who: Who) -> Image? {
        if let data = try? Data(contentsOf: FileManager.documentsDirectory.appendingPathComponent("\(who.id!.uuidString).jpeg")),
           let image = UIImage(data: data) {
            return Image(uiImage: image)
            
        } else {
            return nil
        }
    }
}
