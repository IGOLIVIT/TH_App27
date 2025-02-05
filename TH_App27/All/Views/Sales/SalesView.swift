//
//  SalesView.swift
//  TH_App27
//
//  Created by IGOR on 03/02/2025.
//

import SwiftUI

struct SalesView: View {

    @StateObject var viewModel = SalesViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Sales")
                    .foregroundColor(.black)
                    .font(.system(size: 32, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 30)

                VStack(alignment: .leading, spacing: 15) {
                    
                    HStack {
                        
                        Text("Totoal sold")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                        
                        Spacer()
                        
                        Text("Revenue")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                    }
                    
                    HStack {
                        
                        Text("\(viewModel.TotalSold)")
                            .foregroundColor(.black)
                            .font(.system(size: 22, weight: .semibold))

                        Spacer()
                        
                        Text("$\(viewModel.Revenue)")
                            .foregroundColor(.black)
                            .font(.system(size: 22, weight: .semibold))
                    }
                    
                    HStack {
                        
                        Text("Hostiry")
                            .foregroundColor(.black)
                            .font(.system(size: 22, weight: .semibold))

                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = true
                            }
                            
                        }, label: {
                            
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                                .font(.system(size: 22, weight: .semibold))
                        })
                    }
                    
                    if viewModel.sales.isEmpty {
                        
                        Text("It's empty here. Add a new entry")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .regular))
                        
                    } else {
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            LazyVStack {
                                
                                ForEach(viewModel.sales, id: \.self) { index in
                                
                                    VStack(spacing: 14) {
                                        
                                        HStack {
                                            
                                            Text(index.saName ?? "")
                                                .foregroundColor(.black)
                                                .font(.system(size: 20, weight: .medium))
                                            
                                            Spacer()
                                            
                                            Text("$\(index.saRev ?? "")")
                                                .foregroundColor(.black)
                                                .font(.system(size: 18, weight: .regular))
                                        }
                                        
                                        HStack {
                                            
                                            Text("\(index.saQuan ?? "") Portions sold")
                                                .foregroundColor(.black)
                                                .font(.system(size: 16, weight: .regular))
                                            
                                            Spacer()
                                            
                                            Text((index.saDate ?? Date()).convertDate(format: "MMM, dd YYYY"))
                                                .foregroundColor(.black)
                                                .font(.system(size: 16, weight: .medium))
                                        }
                                    }
                                    
                                    Rectangle()
                                        .fill(Color.black)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 1)
                                        .padding(.vertical, 5)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 20).fill(.white))
                        }
                    }
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 5).fill(Color("prim1")))
                
                Spacer()
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchSales()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddSale(viewModel: viewModel)
        })
    }
}

#Preview {
    SalesView()
}
