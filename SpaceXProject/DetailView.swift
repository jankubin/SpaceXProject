//
//  DetailView.swift
//  SpaceXProject
//
//  Created by Jan Kubín on 28.07.2023.
//

import SwiftUI

struct DetailView: View {
    
    let launch: Response
    
    var body: some View {
        VStack{
            if let large = launch.links.patch.large {
                AsyncImage(url: URL(string: large)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .scaledToFit()
                .frame(height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            Text(launch.name)
                .font(.title)
                .padding([.bottom, .top])
            Text("Flight number: \(launch.flightNumber)")
                .font(.headline)
                .padding(.bottom)
            Text("Date: \(launch.dateLocal)")
                .font(.headline)
                .padding(.bottom)
            Text(launch.details ?? "")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        // For the preview, you can create a sample launch to pass as a parameter
        let sampleLaunch = Response(
            name: "Sample Name",
            details: "Sample Details",
            dateLocal: "Some date",
            flightNumber: 123,
            links: Links(
                patch: Patch(small: "sample_url", large: "sample_url")
            )
        )
        DetailView(launch: sampleLaunch)
    }
}

