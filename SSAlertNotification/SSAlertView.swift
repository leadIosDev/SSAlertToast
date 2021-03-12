//
//  SSAlertView.swift
//  SSAlertNotification
//
//  Created by shashank on 12/03/21.
//

import SwiftUI

enum SSAlertViewStyle {
    case success, error, info, warning, custom(_ icon: Image, _ backgroundColor: Color, _ textColor: Color)
}

enum SSAlertPosition {
    case top, bottom
}

struct SSAlertData {
    var style: SSAlertViewStyle = .info
    var message: String
    var position: SSAlertPosition = .top
    var toastTime: TimeInterval = 3
}

struct SSAlertView: ViewModifier {
    @Binding var show: Bool
    var data: SSAlertData
    @State private var animateView: Bool = false
    @State var timer: Timer?
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if show {
                VStack {
                    if data.position == .bottom {
                        Spacer()
                    }
                    HStack(alignment: .center) {
                        self.icon
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 3)
                        
                        Text(data.message)
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(self.textColor)
                            .lineLimit(3)
                            .shadow(color: Color.black.opacity(0.2), radius: 1, x: 2, y: 2)
                        
                        Spacer()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(self.viewBackGroundColor)
                            .shadow(color: Color.black.opacity(0.5), radius: 3, x: 0, y: 3)
                           
                    )
                    .offset(y: self.animateView ? 0: data.position == .top ? -500: 500)
                    if data.position == .top {
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .onTapGesture {
                    self.dismissView()
                }
                .onAppear() {
                    withAnimation(Animation.spring()) {
                        self.animateView = true
                    }
                    if data.toastTime != 0 {
                        self.timer = Timer.scheduledTimer(withTimeInterval:  data.toastTime, repeats: false) { (_) in
                            self.dismissView()
                        }
                    }
                }
            }
            
        }
    }
    
    private func dismissView() {
        self.timer?.invalidate()
        self.timer = nil
        withAnimation {
            self.animateView = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.show = false
        }
    }
    
    var viewBackGroundColor: Color {
        switch data.style {
        case .success:
            return .green
        case .error:
            return .red
        case .info:
            return .blue
        case .warning:
            return .orange
        case .custom(_, let backgroundColor, _):
            return backgroundColor
        }
    }
    
    var textColor: Color {
        switch data.style {
        case .custom(_, _, let forgroundColor):
            return forgroundColor
        default:
            return .white
        }
    }
    
    var icon: Image {
        switch data.style {
        case .success:
            return Image(systemName: "checkmark.circle.fill")
        case .error:
            return Image(systemName: "xmark.circle.fill")
        case .info:
            return Image(systemName: "info.circle.fill")
        case .warning:
            return Image(systemName: "hand.raised.fill")
        case .custom(let icon, _, _):
            return icon
        }
    }
}

struct SSAlertView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
           
    }
}

extension View {
    func showToast(show: Binding<Bool>, data: SSAlertData) -> some View {
        self.modifier(SSAlertView(show: show, data: data))
    }
}
