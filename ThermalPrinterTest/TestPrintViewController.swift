//
//  TestPrintViewController.swift
//  ThermalPrinterTest
//
//  Created by Mom Socheat on 06/07/2022.
//

import UIKit
//import Printer
import CoreBluetooth

class TestPrintViewController: UIViewController {

    static let identifier: String = "TestPrintViewController"

    @IBOutlet weak var tfNode: UITextField!
    var bluetoothPrinterManager : BluetoothPrinterManager?
    
    let invoiceView = InvoiceView()

    var connectedPeripheral: CBPeripheral!

    override func viewDidLoad() {
        super.viewDidLoad()
//        let invoiceView = InvoiceView()
//        invoiceView.frame = CGRect(x: 0, y: 0, width: 128, height: 118)
//
//        view.addSubview(invoiceView)
//        view.bringSubviewToFront(invoiceView)
//        imageView.image = invoiceView.asImage()
    }

    @IBAction func didPressSecondPrint(_ sender: Any) {
        let text = tfNode.text ?? "GBS Tech"
        
        var ticket = Ticket(
            .image(generateInvoice())
        )

        ticket.feedLinesOnHead = 0
        ticket.feedLinesOnTail = 0
        
        if bluetoothPrinterManager?.canPrint == true {
            bluetoothPrinterManager?.print(ticket, encoding: .utf8)
        }
    }
    
    @IBAction func didPressPrint(sender: UIButton) {
        let text = tfNode.text ?? "GBS Tech"
        
        var ticket = Ticket(
            .text(Text(text))
        )

        ticket.feedLinesOnHead = 0
        ticket.feedLinesOnTail = 0

        if bluetoothPrinterManager?.canPrint == true {
            bluetoothPrinterManager?.print(ticket, encoding: .utf8)
        }
    }
    
    func generateInvoice() -> UIImage {
        invoiceView.frame = CGRect(x: 0, y: 0, width: 128, height: 98)
        return invoiceView.asImage()
    }

}

extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
//    var snapshot: UIImage? {
//            UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
//            if UIGraphicsGetCurrentContext() != nil {
//                drawHierarchy(in: bounds, afterScreenUpdates: true)
//                let screenshot = UIGraphicsGetImageFromCurrentImageContext()
//                UIGraphicsEndImageContext()
//                return screenshot
//            }
//            return nil
//        }
}
