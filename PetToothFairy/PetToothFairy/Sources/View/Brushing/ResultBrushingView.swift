//
//  BrushingResultView.swift
//  PetToothFairy
//
//  Created by 임주민 on 12/9/24.
//

import SwiftUI

struct ResultBrushingView: View {
  @State var brushingResponse: BrushingResponse
  
  var body: some View {
    VStack {
      UpperTitleView(title: "오늘의 양치질")
      HighlightContentView(mostResponse: brushingResponse.reports[0], seq: brushingResponse.seq)
        .frame(height: 200)
      ListContentView(reports: brushingResponse.reports)
        .padding(.top, 10)
      Spacer()
    }
    .background(Color.backgroundColor)
  }
}

struct HighlightContentView: View {
  var mostResponse: Report
  var seq: Int
  
  var body: some View {
    ZStack {
      BoxView()
      ScrollView {
        VStack {
          HeaderView(title: "🤔 가장 신경 써야 할 부위 Top 1", fontSize: 19)
          Spacer()
          HStack {
            Image(LocationUtils.getImageNameForReceivedValue(locationText: mostResponse.name))
              .resizable()
              .scaledToFit()
              .frame(width: 100, height: 100)
              .scaleEffect(1.8)
              .padding(.top, 10)
            VStack(alignment: .leading) {
              Group {
                Text(mostResponse.name)
                  .fontWeight(.bold)
                + Text(" 부분이\n충분히 닦이지 않았어요!")
              }.padding(.leading, 35)
                .padding(.top, 10)
              ProgressBarView(value: mostResponse.percent)
                .tint(.blue)
                .padding(.leading, 15)
                .padding(.horizontal, 20)
            }
            .frame(width: 200)
            .font(.system(size: 16))
          }
          Spacer()
          HighlightFooterView(seq: seq)
        }
        .padding(.horizontal, 20)
      }
    }
  }
}

struct ListContentView: View {
  var reports: [Report]
  
  private func colorForDescription(description: String) -> Color {
    switch description {
    case "적절해요.":
      return .green
    case "미흡해요.":
      return .pink
    case "주의해요.":
      return .orange
    default:
      return .gray
    }
  }
  
  var body: some View {
    ZStack {
      BoxView()
      VStack(alignment: .leading, spacing: 10) {
        HeaderView(title: "📝 전체 양치질 보고서", fontSize: 19)
        ScrollView {
          ForEach(reports, id: \ .name) { report in
            HStack {
              Text(report.name)
                .font(.system(size: 12))
                .frame(width: 140, alignment: .leading)
              ProgressBarView(value: report.percent)
                .tint(.blue)
              Text(report.description)
                .font(.system(size: 12))
                .bold()
                .foregroundStyle(colorForDescription(description: report.description))
            }
            .padding(.horizontal, 10)
          }
        }
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 10)
    }
  }
}

struct ProgressBarView: View {
  var value: Double
  
  var body: some View {
    HStack {
      ProgressView(value: value, total: 100)
        .progressViewStyle(LinearProgressViewStyle())
        .frame(height: 30)
        .padding(.horizontal, 5)
    }
  }
}

struct BoxView: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 15)
      .fill(.white)
      .frame(width: UIScreen.main.bounds.width - 32)
      .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 0)
  }
}

struct HeaderView: View {
  var title: String
  var fontSize: CGFloat
  
  var body: some View {
    HStack {
      Text(title)
        .bold()
        .font(.system(size: fontSize))
        .padding(.top, 5)
      Spacer()
    }
    .padding(.top, 10)
  }
}

struct HighlightFooterView: View {
  var seq: Int
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 8)
        .fill(.gray)
        .frame(height: 20)
        .padding(.horizontal)
      Text("\(seq)일 연속 양치 완료! 계속 유지해보세요😀")
        .foregroundStyle(.white)
        .bold()
        .font(.system(size: 15))
    }
    .padding(.top, 10)
  }
}

