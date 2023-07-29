//
//  ContentView.swift
//  SpaceXProject
//
//  Created by Jan Kubín on 28.07.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State private var sortBy: SortOption = .name 
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.spaceXLaunch, id: \.self) { space in
                    NavigationLink(destination: DetailView(launch: space)) {
                        LaunchRowView(space: space)
                    }
                }
            }
            .navigationTitle("SpaceX")
            .toolbar {
                Menu {
                    ForEach(SortOption.allCases, id: \.self) { option in
                        Button(option.rawValue) {
                            sortBy = option
                            viewModel.sort(by: sortBy)
                        }
                    }
                } label: {
                    Label("Sort", systemImage: "arrow.up.arrow.down")
                }
            }
            .onAppear {
                viewModel.fetch()
            }
        }
    }
}

enum SortOption: String, CaseIterable {
    case name = "Name"
    case flightNumber = "Flight Number"
    case date = "Date"
}

struct LaunchRowView: View {
    let space: Response
    
    var body: some View {
        HStack {
            if let small = space.links.patch?.small {
                            AsyncImage(url: URL(string: small)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            .frame(width: 40, height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
            VStack(alignment: .leading) {
                Text(space.name)
                    .font(.headline.bold())
                Text("Flight number: \(space.flightNumber)")
                    .font(.subheadline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
