import Foundation
import PDFKit
import SwiftUI


struct PDFViewUI: UIViewRepresentable {
  
  let pdfDocument: PDFDocument
  let pdfView = PDFView()
  
  init(_ pdfDoc: PDFDocument) {
    self.pdfDocument = pdfDoc
  }
  
  func makeUIView(context: Context) -> PDFView {
    pdfView.document = pdfDocument
    pdfView.autoScales = true
    return pdfView
  }
  
  func updateUIView(_ pdfView: PDFView, context: Context) {
    pdfView.document = pdfDocument
  }
  
}
