//
//  ProfitView.swift
//  App287
//
//  Created by Вячеслав on 12/16/23.
//

import SwiftUI

struct ProfitView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                VStack(alignment: .leading) {
                    
                    Text("Profit")
                        .foregroundColor(Color("primary"))
                        .font(.system(size: 23, weight: .semibold))
                    
                    Image("executors")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 80)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 25)
                    
                    NavigationLink(destination: {
                        
                        GraphView()
                            .navigationBarBackButtonHidden()
                        
                    }, label: {
                        
                        HStack {
                            
                            Text("EUR/USD")
                                .foregroundColor(Color("primary"))
                                .font(.system(size: 16, weight: .medium))
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .regular))
                        }
                    })
                }
                .padding()
                .background(Color("bg2").ignoresSafeArea())
                .frame(maxWidth: .infinity, alignment: .leading)
                
                if viewModel.staffs.isEmpty {
                    
                    Text("Add an employee in the 'Staff' tab")
                        .foregroundColor(.gray)
                        .font(.system(size: 16, weight: .regular))
                        .multilineTextAlignment(.center)
                        .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.staffs, id: \.self) { index in
                            
                                HStack {
                                    
                                    Image(systemName: "person.text.rectangle")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 18, weight: .regular))

                                    
                                    VStack(alignment: .leading, spacing: 6, content: {
                                        
                                        Text(index.name ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 18, weight: .semibold))
                                        
                                        Text(index.post ?? "")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 14, weight: .regular))
                                    })
                                    
                                    Spacer()
                                    
                                    Text((index.working_from ?? Date()).convertDate(format: "MMM d HH:mm"))
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                                .background(RoundedRectangle(cornerRadius: 10).stroke(.white))
                                .padding(.horizontal)
                            }
                        }
                        .padding(1)
                    }
                }
            }
        }
        .onAppear {
            
            viewModel.fetchStaff()
        }
    }
}

#Preview {
    ProfitView()
}
