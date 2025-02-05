//
//  ExperimentsView.swift
//  TH_App27
//
//  Created by IGOR on 03/02/2025.
//

import SwiftUI

struct ExperimentsView: View {

    @StateObject var viewModel = ExperimentsViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Experiments")
                    .foregroundColor(.black)
                    .font(.system(size: 32, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                HStack {
                    
                    ForEach(viewModel.statusesForFilter, id: \.self) { index in
                    
                        Button(action: {
                            
                            viewModel.currStatusForFilter = index
                            
                        }, label: {
                            
                            Text(index)
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 30)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim2").opacity(viewModel.currStatusForFilter == index ? 1 : 0)))
                        })
                    }
                }
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim1")))
                .padding(.vertical)
                
                if viewModel.experiments.isEmpty {
                    
                    VStack(spacing: 14) {
                        
                        Text("Empty")
                            .foregroundColor(.black)
                            .font(.system(size: 22, weight: .bold))
                        
                        Text("You haven't added any experiments")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .regular))
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 14).fill(Color("prim1")))
                    
                    Spacer()
                    
                } else {
                    
                    if viewModel.currStatusForFilter == "All" {
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            LazyVStack {
                                
                                ForEach(viewModel.experiments, id: \.self) { index in
                                
                                    HStack {

                                        Image(index.exStatus ?? "")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 70)
                                        
                                        Text(index.exName ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 22, weight: .medium))

                                        Spacer()
                                        
                                        VStack {
                                            
                                            Button(action: {
                                                
                                                viewModel.selectedExperiment = index
                                                
                                                withAnimation(.spring()) {
                                                    
                                                    viewModel.isDelete = true
                                                }
                                                
                                            }, label: {
                                                
                                                Image(systemName: "trash")
                                                    .foregroundColor(.red)
                                                    .font(.system(size: 16, weight: .regular))
                                            })
                                            
                                            Spacer()
                                        }
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(RoundedRectangle(cornerRadius: 12).fill(Color("prim1")))
                                }
                            }
                        }
                        
                    } else {
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            LazyVStack {
                                
                                ForEach(viewModel.experiments.filter({($0.exStatus ?? "") == viewModel.currStatusForFilter}), id: \.self) { index in
                                
                                    HStack {

                                        Image(index.exStatus ?? "")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 70)
                                        
                                        Text(index.exName ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 22, weight: .medium))
                                        
                                        Spacer()
                                        
                                        VStack {
                                            
                                            Button(action: {
                                                
                                                viewModel.selectedExperiment = index
                                                
                                                withAnimation(.spring()) {
                                                    
                                                    viewModel.isDelete = true
                                                }
                                                
                                            }, label: {
                                                
                                                Image(systemName: "trash")
                                                    .foregroundColor(.red)
                                                    .font(.system(size: 16, weight: .regular))
                                            })
                                            
                                            Spacer()
                                        }
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(RoundedRectangle(cornerRadius: 12).fill(Color("prim1")))
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            
            VStack {
                
                Spacer()
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = true
                    }
                    
                }, label: {
                    
                    Text("New experiments +")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .regular))
                        .padding(8)
                        .padding(.horizontal, 9)
                        .background(RoundedRectangle(cornerRadius: 9).fill(Color("prim3")))
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
        }
        .onAppear {
            
            viewModel.fetchExperiments()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddExperiment(viewModel: viewModel)
        })
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isDelete ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                    }
                
                VStack(spacing: 15) {

                    Text("Delete \(viewModel.selectedExperiment?.exName ?? "")?")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .padding(.vertical)

                    Rectangle()
                        .fill(.black.opacity(0.2))
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                    
                    HStack {
                        
                        Button(action: {
                            
                            CoreDataStack.shared.deleteExperiment(withExName: viewModel.selectedExperiment?.exName ?? "", completion: {
                                
                                viewModel.fetchExperiments()
                            })
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Text("Delete")
                                .foregroundColor(.red)
                                .font(.system(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                            
                        })
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Text("Cancel")
                                .foregroundColor(.black)
                                .font(.system(size: 17, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                            
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg")))
                .padding()
                .offset(y: viewModel.isDelete ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

#Preview {
    ExperimentsView()
}
