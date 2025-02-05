//
//  LoadingView.swift
//  TH_App27
//
//  Created by IGOR on 03/02/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
            }
            
            VStack {
                
                Spacer()
                
                ProgressView()
                    .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    LoadingView()
}
