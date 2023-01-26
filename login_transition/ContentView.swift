//
//  ContentView.swift
//  login_transition
//
//  Created by Victor Miranda on 23/01/23.
//

import SwiftUI
import AVKit

private func Square(_ color: Color, _ sideLength: CGFloat = 0) -> some View {
    Rectangle()
        .fill(color)
        .frame(width: 400, height: sideLength)
}

struct ContentView: View {
    @State var showSecondView = false
    @State var height: Double = 0
    @State var offsetDiamond: Double = 650
    @State var username: String = ""
    @State var password: String = ""
    
    let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    
    @State private var diamondData: [DiamondData] = (0..<100).map { _ in DiamondData(scale: CGFloat.random(in: 0.5...2),offsetY: 450,offsetX: Double.random(in: -200...200),degrees:Double.random(in: -10...10), size: Double.random(in: 70...120)) }
    
    var body: some View {
        
        ZStack{
            VideoPlayer()
                .ignoresSafeArea()
                .aspectRatio(1/1, contentMode: ContentMode.fill)
                .zIndex(-2)
    
            VStack{
                Text("Sports")
                    .font(Font.custom("GREATESTGENERALDEMO-Regular", size: 24))
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 20, leading: .zero, bottom: .zero, trailing: .zero))
                    .opacity(showSecondView ? 0 : 1)
                    .animation(.easeInOut(duration: 1), value: showSecondView)
                
                Spacer()
                
                Text("""
                     "Sports" is a monthly magazine that covers the latest news and analysis on various sports.
                     """)
                .frame(minWidth: 20, maxWidth: 300)
                .font(.system(size:16))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: .zero, leading: .zero, bottom: 60, trailing: .zero))
                .opacity(showSecondView ? 0 : 1)
                .animation(.easeInOut(duration: 1), value: showSecondView)
                
               
                Button(action: {
                    showSecondView.toggle()
                    withAnimation{
                        self.height += 2500
                    }
                }, label: {
                    
                        Text("LOGIN")
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                            
                    
                })
                    .frame(width: 240, height: 60)
                    .background(.black)
                    .cornerRadius(16)
                    .padding(EdgeInsets(top: .zero, leading: .zero, bottom: 20, trailing: .zero))
                    .opacity(showSecondView ? 0 : 1)
                    .animation(.easeInOut(duration: 1), value: showSecondView)
                   
                    
                Button(action: {
                }){
                    Text("SIGNUP")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                }
                .padding(EdgeInsets(top: .zero, leading: .zero, bottom: 50, trailing: .zero))
                .opacity(showSecondView ? 0 : 1)
                .animation(.easeInOut(duration: 1), value: showSecondView)
            }
            .overlay{
                ZStack{
                    
                    Square(Color(red: 33/255, green: 33/255, blue: 33/255), height)
                        .offset(x:0, y: 650)
                        .animation(.easeInOut(duration: 4.3), value: height)
                        .zIndex(0)
                    if showSecondView {
                        
                        ForEach(1...20, id:  \.self) { index in
                            ZStack{
                                Diamond()
                                    .fill(Color(red: 33/255, green: 33/255, blue: 33/255))
                                    .frame(width: 120, height: 320)
                                Triangle()
                                    .fill(Color(red: 44.3/255, green: 45.5/255, blue: 45.5/255))
                                    .offset(x:0, y: -60)
                                    .frame(width: 100 - 70, height: 100 + 20)
                            }
                            .rotationEffect(.degrees(diamondData[index].degrees))
                            .scaleEffect(diamondData[index].scale)
                            .offset(x:diamondData[index].offsetX, y: offsetDiamond - 200)
                            .animation(.easeInOut(duration: 5), value: offsetDiamond)
                            .onReceive(timer){
                                _ in
                                withAnimation{
                                    self.offsetDiamond -= 10
                                    reset(self.offsetDiamond)
                                }
                            }
                        }
                        
                    }
                   
                    GeometryReader{proxy in
                        VStack(spacing: 150){
                            Text("Sports")
                                .font(Font.custom("GREATESTGENERALDEMO-Regular", size: 24))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 20, leading: .zero, bottom: .zero, trailing: .zero))
                                .opacity(showSecondView ? 1 : 0)
                                .animation(.easeInOut(duration: 10), value: showSecondView)
                                .offset(x: 0, y: proxy.size.height/2.87)
                            
                            ZStack{
                                Text("USERNAME")
                                    .foregroundColor(Color.gray.opacity(0.5))
                                    .offset(x: self.username.isEmpty ? -110 : -120,
                                            y: self.username.isEmpty ? proxy.size.height/3 : proxy.size.height/3 - 25)
                                    .transition(.slide)
                                    .transition(.scale)
                                    .opacity(showSecondView ? 1 : 0)
                                    .animation(.easeInOut(duration: 10), value: showSecondView)
                                TextField(
                                        "",
                                        text: $username
                                    )
                                .foregroundColor(.white)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(false)
                                .overlay(
                                    Rectangle()
                                        .frame(height: 2)
                                        .padding(.top, 35)
                                        .foregroundColor(.gray)
                                )
                                .padding(EdgeInsets(top: .zero, leading: 40, bottom: .zero, trailing: 40))
                                .opacity(showSecondView ? 1 : 0)
                                .animation(.easeOut(duration: 10), value: showSecondView)
                                .offset(x: 0, y: proxy.size.height/3)
                            }
                            
                            ZStack{
                                Text("PASSWORD")
                                    .foregroundColor(Color.gray.opacity(0.5))
                                    .offset(x: self.password.isEmpty ? -110 : -120,
                                            y: self.password.isEmpty ? proxy.size.height/3.40 : proxy.size.height/3.40 - 25)
                                    .transition(.slide)
                                    .transition(.scale)
                                    .opacity(showSecondView ? 1 : 0)
                                    .animation(.easeInOut(duration: 10), value: showSecondView)
                                SecureField("",
                                            text: $password)
                                .foregroundColor(.white)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(false)
                                .overlay(
                                    Rectangle()
                                        .frame(height: 2)
                                        .padding(.top, 35)
                                        .foregroundColor(.gray)
                                )
                                .padding(EdgeInsets(top: .zero, leading: 40, bottom: .zero, trailing: 40))
                                .opacity(showSecondView ? 1 : 0)
                                .animation(.easeInOut(duration: 10), value: showSecondView)
                                .offset(x: 0, y: proxy.size.height/3.40)
                            }
                            
                            
                            
                            
                            Button(action: {
                            }){
                                Text("CONTINUE")
                                    .foregroundColor(.white)
                                    .fontWeight(.heavy)
                            }
                            .frame(width: 240, height: 60)
                            .background(Color(red: 25.9/255, green: 25.5/255, blue: 23.9/255))
                            .cornerRadius(16)
                            .padding(EdgeInsets(top: .zero, leading: .zero, bottom: 20, trailing: .zero))
                            .opacity(showSecondView ? 1 : 0)
                            .animation(.easeInOut(duration: 10), value: showSecondView)
                            .offset(x: 0, y: proxy.size.height/3.50)
                        }
                        
                    }
                    
                }
            }
        
            
            
        }
        
        
    }
    
    func reset(_ offsetY: Double){
        self.diamondData = (0..<100).map{
            _ in DiamondData(scale: CGFloat.random(in: 0.5...2), offsetY: offsetY,offsetX: Double.random(in: -350...350),degrees:Double.random(in: -15...15), size: Double.random(in: 50...120))
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
