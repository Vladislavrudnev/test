//
//  muveItem.swift
//  test
//
//  Created by владислав Руднев on 28.09.2022.
//

import SwiftUI

struct muveItem: View {
    
    let muvie: Movie
    let screenSize: CGSize
    let wight: CGFloat
    
    var body: some View {
        GeometryReader{ reader in
            
            let midX = reader.frame(in: .global).midX
            let distance = abs(screenSize.width / 2 - midX)
            let damping: CGFloat = 3
            let percentage = abs(distance / (screenSize.width / 2) / damping - 1)
            
            VStack{
                
                Image(muvie.imgString)
                    .resizable()
                    .scaledToFit()
                    .frame(width: wight)
                    .clipShape(RoundedRectangle(cornerRadius: 13))
                    .shadow(color: .black.opacity(0.6), radius: 14,  y: 10)
                
                Text(muvie.title)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                HStack(spacing: 5){
                    ForEach(1..<6){ i in
                        Image(systemName: i <= muvie.rating ? "star.fill" : "star")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                        
                        
                    }
                    
                }
            }
            .frame(maxHeight: .infinity)
            .scaleEffect(percentage)
        }
        .frame(width: wight)
        .frame(maxHeight: .infinity)
        //.background(Color.red)
    }
}

struct muveItem_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
