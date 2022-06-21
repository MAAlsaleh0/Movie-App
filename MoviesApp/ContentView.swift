//
//  ContentView.swift
//  MoviesApp
//
//  Created by Mohammed Alsaleh on 21/11/1443 AH.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @StateObject var vm = ViewModel()
    @State var data : Result?
    @Namespace var namespace
    var body: some View {
        ZStack {
            Color("BG").ignoresSafeArea()
            VStack {
                HStack {
                    Text("Movies")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        
                    },label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.title)
                            .foregroundColor(.black)
                    })
                }.padding()
                Divider()
                if self.vm.data != nil {
                    Text("Trends")
                        .font(.title2)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.horizontal)
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack {
                            ForEach(vm.data!.results.filter({$0.originalTitle != nil}) , id: \.id) { data in
                                GeometryReader { geomatry in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color("BG"))
                                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                                        VStack {
                                            KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(data.posterPath)")!)
                                                .resizable()
                                                .cornerRadius(15)
                                                .matchedGeometryEffect(id: data.posterPath, in: namespace)
                                            VStack(alignment: .leading) {
                                                Text(data.originalTitle!)
                                                    .font(.title2)
                                                    .fontWeight(.semibold)
                                                HStack(spacing: 5) {
                                                    Image(systemName: "star.fill")
                                                        .foregroundColor(.orange)
                                                    Text(data.voteAverage.description)
                                                    Spacer()
                                                }.font(.title3)
                                                
                                            }.padding()
                                        }
                                    }
                                    .rotation3DEffect(Angle(degrees: Double(geomatry.frame(in: .global).minX - 40) / -20), axis: (x: 0, y: 10, z: 0))
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                            self.data = data
                                        }
                                    }
                                }.frame(width: UIScreen.main.bounds.width - 70 , height: 500).padding(30)
                                
                            }
                        }
                    }
                } else {
                    Text("No data")
                }
                Spacer()
            }
            if data != nil {
                ZStack {
                    Color("BG")
                    ScrollView {
                        KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(data!.posterPath)")!)
                            .resizable()
                            .matchedGeometryEffect(id: data!.posterPath, in: namespace)
                        VStack(alignment: .leading) {
                            Text(data!.originalTitle!)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .matchedGeometryEffect(id: "title", in: namespace)
                            HStack(spacing: 5) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                                    .matchedGeometryEffect(id: "star", in: namespace)
                                Text(data!.voteAverage.description)
                                    .matchedGeometryEffect(id: "voteAverage", in: namespace)
                                Spacer()
                            }.font(.title3)
                            Text(data!.overview)
                        }.padding()
                    }.edgesIgnoringSafeArea(.top).onTapGesture {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                            self.data = nil
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
