//
//  GraphView.swift
//  App287
//
//  Created by Вячеслав on 12/16/23.
//

import SwiftUI

struct GraphView: View {
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("EUR/USD")
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .medium))
                    
                    HStack {
                        
                        Button(action: {
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .regular))
                                
                                Text("Back")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .regular))
                            }
                        })
                        
                        Spacer()
                    }
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 15, content: {
                    
                    Text("Currency value")
                        .foregroundColor(.gray)
                        .font(.system(size: 15, weight: .medium))
                    
                    HStack(alignment: .bottom, spacing: 10, content: {
                        
                        Text("$\(String(format: "%2.2f", 46.05))")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                        
                        Text("+\(Int.random(in: 1...23))%")
                            .foregroundColor(.green)
                            .font(.system(size: 13, weight: .regular))
                        
                        Spacer()
                    })
                })
                .padding()
                
                Image("graph")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        Text("Back")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.red))
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        Text("Apply")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.green))
                    })
                }
                .padding()
            }
        }
    }
}

#Preview {
    GraphView()
}
