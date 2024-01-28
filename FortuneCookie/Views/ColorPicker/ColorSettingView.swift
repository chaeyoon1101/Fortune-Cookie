//
//  ColorPickerView.swift
//  FortuneCookie
//
//  Created by 임채윤 on 1/28/24.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    var backgroundColor: Color
    var foregroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 88, height: 36)
            .background(Capsule().fill(backgroundColor))
            .foregroundColor(foregroundColor)
            .font(.system(size: 18, weight: .bold))
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
    Color.Background.
}

struct ColorSettingView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var selectedColor: Color
    
    @State var isColorPickerModalPresented = true
    
    var body: some View {
        if #available(iOS 16, *) {
            NavigationView {
                ZStack {
                    selectedColor
                        .ignoresSafeArea(.all)
                        .navigationBarTitle("Modal", displayMode: .inline)
                        .navigationBarItems(
                            leading: navigationBarLeadingButton,
                            trailing: navigationBarTrailingButton
                        )
                }
//                .sheet(isPresented: $isColorPickerModalPresented) {
//                    ColorPickerView(selectedColorIndex: 2)
//                        .presentationDetents([.height(100)])
//                        
//                }
            }
        } else {
            NavigationView {
                ZStack {
                    selectedColor
                        .ignoresSafeArea(.all)
                        .navigationBarTitle("Modal", displayMode: .inline)
                        .navigationBarItems(
                            leading: navigationBarLeadingButton,
                            trailing: navigationBarTrailingButton
                        )
                    
                }
            }
        }
        
    }
    
    private var navigationBarLeadingButton: some View {
        Button("취소") {
            presentationMode.wrappedValue.dismiss()
        }
        .buttonStyle(CapsuleButtonStyle(
                backgroundColor: .gray,
                foregroundColor: .black
            )
        )
    }
    
    private var navigationBarTrailingButton: some View {
        Button("저장") {
            presentationMode.wrappedValue.dismiss()
        }
        .buttonStyle(CapsuleButtonStyle(
                backgroundColor: .accentColor,
                foregroundColor: .white
            )
        )
    }
}

#Preview {
    ColorSettingView(selectedColor: .cyan)
}
