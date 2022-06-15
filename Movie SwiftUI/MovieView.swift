//
//  MovieView.swift
//  Movie SwiftUI
//
//  Created by Morteza Kolivand on 15.06.2022.
//

import SwiftUI

struct MovieView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var movieVM = MovieViewModel()
    @State var showingPopup = false
    init(){
        movieVM.allMovies()
    }
    
    var body: some View{
        ScrollView(.vertical) {
            LazyVStack {
                HStack{
                GradientText()
                    Spacer()
                    VStack(alignment:.trailing){
                        Text("Sort by date")
                        Toggle("", isOn: $showingPopup).onChange(of: showingPopup) { value in
                            if showingPopup{
                                movieVM.sortByDate()
                            }else{
                               
                                movieVM.sortByWatchOrder()
                            }
                            
                        }
                    }
                }.padding()
                ForEach(0..<movieVM.movieList.count, id: \.self) { index in
                    
                    VStack {
                         
                        Text(movieVM.movieList[index].title).font(.system(size: 25, weight: .bold ))
                            Spacer()
                        Text(movieVM.movieList[index].releaseDate.split(separator: "T")[0] )
                        
                    }.frame(
                        minWidth: 0,
                        maxWidth: .infinity
                        
                    )
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.blue, lineWidth: 4)
                        )
                    Spacer()
                    
                }
            }.padding()
        }
    }
 }

struct GradientText: View {
    let text = Text("Avengers Movies")
        .font(.system(size: 40, weight: .bold, design: .rounded))
    
    var body: some View {
        text
            .foregroundColor(.clear)
            .overlay(
                LinearGradient(gradient: Gradient(colors: [.blue, .red, .orange]),
                               startPoint: .leading, endPoint: .trailing)
                    .mask(text))
    }
}

 

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView()
    }
}
