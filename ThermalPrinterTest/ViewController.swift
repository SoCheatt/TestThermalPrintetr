//
//  ViewController.swift
//  ThermalPrinterTest
//
//  Created by Mom Socheat on 06/07/2022.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    var arrayPeripehral = [CBPeripheral]()
    var connectedPeripheral: CBPeripheral?
    
    var manager:CBCentralManager!
    
    var bluetoothManger = BluetoothPrinterManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        manager = CBCentralManager(delegate: self, queue: nil)
//        manager.scanForPeripherals(withServices: nil, options: nil)
        
        print(bluetoothManger.nearbyPrinters)
    }

    @IBAction func didPressTestPrint(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: TestPrintViewController.identifier) as! TestPrintViewController
        vc.connectedPeripheral = connectedPeripheral
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayPeripehral.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arrayPeripehral[indexPath.row].name

        if let connectedPeripheral = connectedPeripheral {
            if arrayPeripehral[indexPath.row] == connectedPeripheral {
                cell.textLabel?.textColor = UIColor.blue
            } else {
                cell.textLabel?.textColor = .label
            }
        } else {
            cell.textLabel?.textColor = .label
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let connectedPeripheral = connectedPeripheral,
           connectedPeripheral == arrayPeripehral[indexPath.row] {

            manager.cancelPeripheralConnection(connectedPeripheral)
            self.connectedPeripheral = nil

            tableView.reloadData()

            return
        }

        manager.connect(arrayPeripehral[indexPath.row], options: nil)
//        connectedPeripheral?.delegate = self
        connectedPeripheral?.discoverServices(nil)

        tableView.reloadData()
    }
    
    
}

//extension ViewController: CBCentralManagerDelegate, CBPeripheralDelegate {
//    //MARK: - Bluetooth Functions
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        if central.state == .poweredOn {
//            central.scanForPeripherals(withServices: nil, options: nil);
//        } else {
//            print("Bluetooth'un çalışmıyor, lütfen düzelt");
//        }
//    }
//
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//
//        if peripheral.name == nil { return }
//
//        if !(arrayPeripehral.contains(where: {$0.identifier.uuidString == peripheral.identifier.uuidString})){
//            arrayPeripehral.append(peripheral)
//            tableView.reloadData()
//        }
//    }
//
//    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//        // Successfully connected. Store reference to peripheral if not already done.
//        self.connectedPeripheral = peripheral
//        print("Connected: ", self.connectedPeripheral?.name)
//        tableView.reloadData()
//    }
//
//    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
//        // Handle error
//        print("Connection fail")
//    }
//
//    func discoverCharacteristics(peripheral: CBPeripheral) {
//        guard let services = peripheral.services else {
//            return
//        }
//        for service in services {
//            peripheral.discoverCharacteristics(nil, for: service)
//        }
//    }
//
//    // In CBPeripheralDelegate class/extension
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
//        guard let services = peripheral.services else {
//            return
//        }
//        discoverCharacteristics(peripheral: peripheral)
//    }
//
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
//        guard let characteristics = service.characteristics else {
//            return
//        }
//
//        print(characteristics)
//        // Consider storing important characteristics internally for easy access and equivalency checks later.
//        // From here, can read/write to characteristics or subscribe to notifications as desired.
//    }
//}
//
