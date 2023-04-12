//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Simbolon, Meli on 4/12/23.
//

import SwiftUI
import MapKit

let data = [
    Item(name: "K-Bop", desc: "Korean street food is our specialty. Pair any menu item with a refreshing bubble tea.", lat: 29.884716928823025, long: -97.94175903914879, imageName: "rest1"),
    Item(name: "Kobe Steak House & Sushi", desc: "The place to go to for unlimited sushi. Gather here with family and friends for outstanding hibachi.", lat: 29.887212154928676, long: -97.92158765634821, imageName: "rest2"),
    Item(name: "Phở Tran88", desc: "San Marcos's 2021 Love Downtown Awards Winner for Outstanding New Business. Family-owned, serving quality Vietnamese cuisine.", lat: 29.883661774929447, long: -97.93977408788406, imageName: "rest3"),
    Item(name: "Thai Thai Cafe", desc: "A brand-new restaurant in town. As it's located across the street from the huge H-E-B, stop by before your grocery run.", lat: 29.886489517068178, long: -97.9247614735477, imageName: "rest4"),
    Item(name: "Xian Sushi & Noodle", desc: "This fine eatery serves hand-pulled Chinese noodles. Premium teas and signature sushi rolls are just a few of the restaurant's specialties.", lat: 29.88647192538372, long: -97.92111232380353, imageName: "rest5")
   
]

struct Item: Identifiable {
        let id = UUID()
        let name: String
        let desc: String
        let lat: Double
        let long: Double
        let imageName: String
    }

struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.883661774929447, longitude: -97.93977408788406), span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.05))
    var body: some View {
        
        
        
        
        NavigationView {
            VStack {
                List(data, id: \.name) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                    Map(coordinateRegion: $region, annotationItems: data) { item in
                                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                        Image(systemName: "mappin.circle.fill")
                                            .foregroundColor(.red)
                                            .font(.title)
                                            .overlay(
                                                Text(item.name)
                                                    .font(.subheadline)
                                                    .foregroundColor(.black)
                                                    .fixedSize(horizontal: true, vertical: false)
                                                    .offset(y: 25)
                                            )
                                    }
                                }
                                .frame(height: 300)
                                .padding(.bottom, -30)
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Asian Restaurants in San Marcos")
            }
        }
    }
    
    struct DetailView: View {
        @State private var region: MKCoordinateRegion
              
              init(item: Item) {
                  self.item = item
                  _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
              }
        let item: Item
        
        var body: some View {
            VStack {
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 200)
                Text("Description: \(item.desc)")
                    .font(.subheadline)
                    .padding(10)
            }
            .navigationTitle(item.name)
            Spacer()
            Map(coordinateRegion: $region, annotationItems: [item]) { item in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                            .overlay(
                                Text(item.name)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .fixedSize(horizontal: true, vertical: false)
                                    .offset(y: 25)
                            )
                    }
                }
                    .frame(height: 300)
                    .padding(.bottom, -30)
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

