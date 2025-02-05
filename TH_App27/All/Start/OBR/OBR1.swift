//
//  OBR1.swift
//  TH_App27
//
//  Created by IGOR on 03/02/2025.
//

import SwiftUI

struct OBR1: View {
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Image("R1")
                        .resizable()
                        .ignoresSafeArea()
                 
                    VStack {
                        
                        Spacer()
                        
                        VStack {
                            
                           Text("Add your recipes")
                                .foregroundColor(.black)
                                .font(.system(size: 28, weight: .regular))
                            
                            Spacer()
                            
                            NavigationLink(destination: {
                                
                                OBR2()
                                    .navigationBarBackButtonHidden()
                                
                            }, label: {
                                
                                Text("Next")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .regular))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(RoundedRectangle(cornerRadius: 12).fill(Color("prim3")))
                            })
                            .padding(.bottom, 30)
                        }
                        .padding()
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                        .background(Color("prim1"))
                    }
                }
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    OBR1()
}
