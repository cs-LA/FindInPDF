import Foundation
import SwiftUI
import WebKit


struct ContentView: View {
  
  @State private var searchString = "dolores"
  @State private var searchIsAtTop = false
  @State private var searchIsAtEnd = false
  
  
  var body: some View {
    
    VStack {
      HStack {
        Spacer()
        Text("HTML")
          .foregroundColor(.blue)
          .onTapGesture { loadHTML() }
        Spacer()
        Text("PDF")
          .foregroundColor(.blue)
          .onTapGesture { loadPDF() }
        Spacer()
      }
      
      searchInPageView()
      
      Browser()

    }
    .padding()
    .onAppear() { loadHTML() }
  }
  
  
  // MARK: ViewBuilders
  
  
  
  @ViewBuilder
  private func searchInPageView() -> some View {
    HStack {
      Image(systemName: "doc.text.magnifyingglass")
      
      Button(action: { searchInPage(forward: false) })
      {
        if searchIsAtTop { Image(systemName: "arrow.triangle.capsulepath").rotationEffect(.radians(.pi)) }
        else { Image(systemName: "lessthan") }
      }
      
      TextField("", text: $searchString)
        .onChange(of: searchString) { _ in
          searchIsAtTop = false
          searchIsAtEnd = false
        }
        .background(Color(.systemGray6))
        .overlay(
          RoundedRectangle(cornerRadius: 4)
            .stroke(Color(.systemGray), lineWidth: 1)
        )
      
      Button(action: { searchInPage(forward: true) })
      {
        if searchIsAtEnd { Image(systemName: "arrow.triangle.capsulepath") }
        else { Image(systemName: "greaterthan") }
      }
    }
    .padding()
    .background(Color(.systemGray3))
    .overlay(
      RoundedRectangle(cornerRadius: 4)
        .stroke(Color(.systemGray), lineWidth: 1)
    )
  }
  
  private func searchInPage(forward: Bool) {
    webView.select(nil)
    searchIsAtTop = false
    searchIsAtEnd = false
    
    let searchConfig = WKFindConfiguration()
    searchConfig.backwards = !forward
    searchConfig.caseSensitive = false
    searchConfig.wraps = false
    webView.find(searchString, configuration: searchConfig, completionHandler: { result in
      // https://stackoverflow.com/questions/64193691/ios-wkwebview-findstring-not-selecting-and-scrolling
      guard result.matchFound else {
        if forward { searchIsAtEnd = true }
        else { searchIsAtTop = true }
        return
      }
      webView.evaluateJavaScript("window.getSelection().getRangeAt(0).getBoundingClientRect().top") { offset, _ in
        guard let offset = offset as? CGFloat else { return }
        webView.scrollView.scrollRectToVisible(
          .init(x: 0, y: offset + webView.scrollView.contentOffset.y,
                width: 100, height: 100), animated: true)
      }
    })
  }
  
  func loadHTML() {
    webView.loadHTMLString(
      """
        <html>
          <head>
          <style>
            :root {
              color-scheme: light dark;
              --color-background: #ffffff;
              --color-text: #000000;
            }
            
            html {
              -webkit-text-size-adjust: 100%; /* Prevent font scaling in landscape while allowing user zoom */
              font-size: 64px;
            }
      
      
            body {
              padding-left: .5em;
              padding-right: 1.0em;
              font-family: 'Times New Roman', Times, serif;
              font-style: normal;
              font-size: 100%;
              line-height: 1.2;
              background-color: var(--color-background);
              color: var(--color-text);
            }
          </style>
          </head>
      
          <body>
            <p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p>
          </body>
        </html>
      """,
      baseURL: nil
    )
  }
  
  
  let pdfAsVector = "https://www.soundczech.cz/temp/lorem-ipsum.pdf"
  let pdfWithText = "https://unec.edu.az/application/uploads/2014/12/pdf-sample.pdf"

  func loadPDF() {
    webView.load(URLRequest(url: URL(string: pdfWithText)!))
  }
  
}
