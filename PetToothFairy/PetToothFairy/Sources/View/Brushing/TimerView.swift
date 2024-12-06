//
//  TimerView.swift
//  PetToothFairy
//
//  Created by 임주민 on 12/6/24.
//

import SwiftUI

struct TimerView: View {
  @State private var timeRemaining = 120
  @State private var isActive = true
  @State private var timer: Timer?
  @State private var circleScale: CGFloat = 130
  @State private var scale: CGFloat = 1.0
  
  let totalTime = 120
  let lineWidth: CGFloat = 9
  let fontColor: Color = .white
  
  var body: some View {
    VStack {
      ZStack {
        Circle()
          .stroke(lineWidth: 1)
          .foregroundColor(Color.white.opacity(0.3))
          .frame(width: circleScale+25)
          .shadow(color: Color.purple.opacity(0.6), radius: 30, x: 0, y: 0)
          .scaleEffect(scale)
          .animation(
            Animation.easeInOut(duration: 1)
              .repeatForever(autoreverses: true), value: scale)
        Group {
          Group{
            Circle()
              .stroke(lineWidth: lineWidth)
              .foregroundColor(Color.white.opacity(0.2))
              .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
            
            Circle()
              .trim(from: 0, to: CGFloat(timeRemaining) / CGFloat(totalTime))
              .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
              .foregroundStyle(LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
              ))
              .rotationEffect(.degrees(-90))
              .animation(.linear(duration: 1), value: timeRemaining)
          }.shadow(color: .white, radius: 3, x: 0, y: 0)
          VStack{
            Text("남은 시간")
              .font(.system(size: 15))
              .foregroundColor(fontColor.opacity(0.9))
              .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 0)
            Text(timeFormatted(timeRemaining))
              .font(.system(size: 40))
              .foregroundColor(fontColor)
              .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
          }
          
        }
        .frame(width: circleScale, height: circleScale, alignment: .center)
        .padding()
      }
    }
    .onAppear {
      startTimer()
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
        withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
          scale = 1.07
        }
      }
    }
    .onDisappear {
      stopTimer()
    }
  }
  

  private func startTimer() {
    isActive = true
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
      if timeRemaining > 0 {
        timeRemaining -= 1
      } else {
        stopTimer()
      }
    }
  }
  
  private func stopTimer() {
    isActive = false
    timer?.invalidate()
  }
  
  private func timeFormatted(_ time: Int) -> String {
    let minutes = time / 60
    let seconds = time % 60
    return String(format: "%02d:%02d", minutes, seconds)
  }
}

struct TimerView_Previews: PreviewProvider {
  static var previews: some View {
    TimerView()
      .background(.blue)
  }
}
