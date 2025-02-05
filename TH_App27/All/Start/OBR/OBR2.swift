//
//  OBR2.swift
//  TH_App27
//
//  Created by IGOR on 03/02/2025.
//

import SwiftUI

struct OBR2: View {
    
    @AppStorage("status") var status: Bool = false
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Image("R2")
                        .resizable()
                        .ignoresSafeArea()
                 
                    VStack {
                        
                        Spacer()
                        
                        VStack {
                            
                           Text("Record your experiments")
                                .foregroundColor(.black)
                                .font(.system(size: 28, weight: .regular))
                            
                            Spacer()
                            
                            Button(action: {
                                
                                status = true
                                
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
    OBR2()
}
