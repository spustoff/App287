//
//  TaskDetail.swift
//  App287
//
//  Created by Вячеслав on 12/16/23.
//

import SwiftUI

struct TaskDetail: View {

    let index: TaskModel
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text(index.name ?? "")
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
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack {
                        
                        HStack {
                            
                            Text("Status")
                                .foregroundColor(Color("primary"))
                                .font(.system(size: 18, weight: .semibold))
                            
                            Spacer()
                            
                            Text(index.status ?? "")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .regular))
                        }
                        .padding()
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            Text("Description")
                                .foregroundColor(Color("primary"))
                                .font(.system(size: 18, weight: .semibold))
                            
                            Text(index.text ?? "")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                                .background(RoundedRectangle(cornerRadius: 10).stroke(.white))
                        })
                        .padding()
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            Text("Comments")
                                .foregroundColor(Color("primary"))
                                .font(.system(size: 18, weight: .semibold))
                            
                            HStack {
                                
                                Text("Comment")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .medium))
                                
                                Spacer()
                                
                                Text(index.comment ?? "")
                                    .foregroundColor(.white)
                                    .font(.system(size: 13, weight: .regular))
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                        })
                        .padding()
                    }
                }
            }
        }
    }
}

//#Preview {
//    TaskDetail()
//}
