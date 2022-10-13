//
//  ContentView.swift
//  test
//
//  Created by владислав Руднев on 27.09.2022.
//

import SwiftUI

struct Movie: Identifiable {
    
    var id: String { title }
    let title: String
    let rating: Int
    let imgString: String
    var bgString: String?
    
    static let scampleMovies = [
        
    Movie(title: "1.jpg", rating: 5, imgString: "1.jpg"),
    Movie(title: "2", rating: 5, imgString: "2"),
    Movie(title: "3", rating: 5, imgString: "3"),
    Movie(title: "4", rating: 5, imgString: "4"),
    Movie(title: "5", rating: 5, imgString: "5"),
    Movie(title: "6", rating: 5, imgString: "6"),
   
    
    
    
    ]
}



struct ContentView: View {
    
    let muves = Movie.scampleMovies
    
    @State private var offsetX: CGFloat = 0
    @State private var maxOffsetX: CGFloat = -1
    
    var body: some View {
        GeometryReader { readier in
            let screenSize = readier.size
            ZStack{
                backgraundCorsor(screnSize: screenSize)
               muviesCarusel(reader: readier)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        
    }
    
    func backgraundCorsor(screnSize: CGSize) -> some View {
        let bgWiedth: CGFloat = screnSize.width * CGFloat(muves.count)
        let scrollPrecentage = offsetX / maxOffsetX
        let clapedPracentage: CGFloat = 1 - max(0,min(scrollPrecentage, 1))
        let posX: CGFloat = (bgWiedth - screnSize.width) * clapedPracentage
        
       return HStack(spacing: 0){
           ForEach(muves.reversed()) { muves in
               Image(muves.imgString )
                    .resizable()
                    .scaledToFill()
                    .frame(width: screnSize.width)
                    .frame(maxHeight: .infinity)
                    .blur(radius: 1)
                    .scaleEffect(1.004)
                    .clipped()
                    .overlay(Color.black.opacity(0.45))
                    .ignoresSafeArea()
           }
            }
            .frame(width: bgWiedth)
            .position(x: bgWiedth / 2 - posX,
                      y: screnSize.height / 2 )
        
    }
    
    
    func muviesCarusel (reader: GeometryProxy) -> some View {
        let screenSize = reader.size
        let itameWight: CGFloat = screenSize.width * 0.8
        let paddingX: CGFloat = (screenSize.width - itameWight) / 2
        let spcing: CGFloat = 10
        return ScrollView(.horizontal) {
            HStack(spacing: 0){
                GeometryReader{ geo -> Color in
                    DispatchQueue.main.async {
                        offsetX = (geo.frame(in: .global).minX - paddingX) * -1
                        let scrollCenter = itameWight * CGFloat(muves.count) + spcing * CGFloat(muves.count - 1)
                        let maxOffsetX = scrollCenter + 2 * paddingX - screenSize.width
                        if self.maxOffsetX == -1 {
                            self.maxOffsetX = maxOffsetX
                        }
                      //  print(offsetX / maxOffsetX)
                    }
                    return Color.clear
                }
                .frame(width: 0)
                HStack(spacing: spcing){
                    ForEach(muves) { muvie in
                        muveItem(muvie: muvie, screenSize: screenSize, wight: itameWight)
                    }
                }
            }
          
            .padding(.horizontal, paddingX)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
