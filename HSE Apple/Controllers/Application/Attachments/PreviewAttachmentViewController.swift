//
//  PreviewAttachmentViewController.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 13.03.2022.
//


import UIKit
import PDFKit
class PreviewAttachmentViewController : UIViewController {
    
    var attachment: URL!
    
    let pdfView: PDFView = {
        let pdfView = PDFView()
        return pdfView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (attachment.pathExtension == "pdf") {
            setupPdfView()
        }
        if attachment.pathExtension == "jpeg" || attachment.pathExtension == "png" {
            setupImageView()
        }
        
        view.backgroundColor = .secondarySystemBackground
        navigationItem.largeTitleDisplayMode = .never

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        attachment = nil
    }
    private func setupPdfView() {
        view.addSubview(pdfView)
        pdfView.frame = view.bounds
        if let document = PDFDocument(url: attachment) {
            pdfView.document = document
        }
        
    }
    private func loadImage() -> UIImage? {
        guard let data = try? Data(contentsOf: (attachment)!) else {
            return nil
        }
        return UIImage(data: data)
    }
    private func setupImageView() {
        view.addSubview(imageView)
        imageView.frame = view.bounds
        imageView.image = self.loadImage()
        imageView.contentMode = .scaleAspectFit
    }
}
