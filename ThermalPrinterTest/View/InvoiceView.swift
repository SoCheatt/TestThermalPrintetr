//
//  InvoiceView.swift
//  ThermalPrinterTest
//
//  Created by Mom Socheat on 06/07/2022.
//

import UIKit

class InvoiceView: UIView {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.contentInset = .zero
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.register(UINib(nibName: InvoiceHeaderCell.identifier, bundle: nil), forCellReuseIdentifier: InvoiceHeaderCell.identifier)
            tableView.register(UINib(nibName: InvoiceBodyCell.identifier, bundle: nil), forCellReuseIdentifier: InvoiceBodyCell.identifier)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        view.backgroundColor = .clear
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "InvoiceView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}


extension InvoiceView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: InvoiceHeaderCell.identifier) as! InvoiceHeaderCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InvoiceBodyCell.identifier) as! InvoiceBodyCell
        
        print("Height: ", self.frame.height)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        1
    }
    
    
}
