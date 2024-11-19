//
//  ViewController.swift
//  20241110
//
//  Created by 雪村りおん on 2024/11/10.
//


import UIKit

class ViewController: UIViewController {
    
    // UI要素の宣言
    @IBOutlet weak var unitPriceLabel: UILabel!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var sideControl: UISegmentedControl! // 両面/片面のラジオボタン
    @IBOutlet weak var laborCostLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var addTableButton: UIButton! // 「＋」ボタン
    @IBOutlet weak var totalAmountLabel: UILabel! // 合計金額ラベル
    @IBOutlet weak var sizeButton: UIButton! // サイズ選択のボタン
    @IBOutlet weak var typeButton: UIButton! // 種類選択のボタン
    
    
    // サイズと種類のデータ
    let sizeOptions = ["普通障子", "雪見障子", "中連障子", "ランマ障子", "書院障子"]
    let typeOptionsForShoji: [String: [String]] = [
        "普通障子": ["無地", "タフトップ", "プラカ"],
        "雪見障子": ["無地", "タフトップ", "プラカ"],
        "中連障子": ["無地", "タフトップ", "プラカ"],
        "ランマ障子": ["無地", "タフトップ", "プラカ"],
        "書院障子": ["5枚組", "タフトップ(5枚組)", "3枚組", "タフトップ(3枚組)"]
    ]
    
    var selectedSize: String = "━"
    var selectedType: String = "━"
    
    // 料金リスト (シート3の情報に基づく)
    let priceList: [String: [String: Int]] = [
        "普通障子": ["無地": 2500, "タフトップ": 4500, "プラカ": 5000],
        "雪見障子": ["無地": 2500, "タフトップ": 4500, "プラカ": 5000],
        "中連障子": ["無地": 2500, "タフトップ": 4500, "プラカ": 5000],
        "ランマ障子": ["無地": 2500, "タフトップ": 4500, "プラカ": 5000],
        "書院障子": ["5枚組": 6000, "タフトップ(5枚組)": 8500, "3枚組": 4000, "タフトップ(3枚組)": 6000]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenus()
        updatePriceAndAmount()
    }
    
    // メニューをセットアップ
    func setupMenus() {
        // サイズメニューの作成
        let sizeMenu = UIMenu(title: "サイズを選択", children: sizeOptions.map { size in
            UIAction(title: size, handler: { _ in
                self.selectedSize = size
                self.sizeButton.setTitle(size, for: .normal)
                self.updateTypeMenu() // 種類メニューも更新する
                self.updatePriceAndAmount()
            })
        })
        sizeButton.menu = sizeMenu
        sizeButton.showsMenuAsPrimaryAction = true
        sizeButton.setTitle(selectedSize, for: .normal)
        
        // 種類メニューの初期設定
        updateTypeMenu()
    }
    
    // 種類メニューをサイズに基づいて更新
    func updateTypeMenu() {
        guard let types = typeOptionsForShoji[selectedSize] else { return }
        
        let typeMenu = UIMenu(title: "種類を選択", children: types.map { type in
            UIAction(title: type, handler: { _ in
                self.selectedType = type
                self.typeButton.setTitle(type, for: .normal)
                self.updatePriceAndAmount()
            })
        })
        typeButton.menu = typeMenu
        typeButton.showsMenuAsPrimaryAction = true
        typeButton.setTitle(selectedType, for: .normal)
    }

        // 枚数が変更されたときに呼ばれる
        @IBAction func quantityChanged(_ sender: UITextField) {
            updatePriceAndAmount()
        }

        // 両面/片面が変更されたときに呼ばれる
        @IBAction func sideChanged(_ sender: UISegmentedControl) {
            updatePriceAndAmount()
        }

        // 単価・手間賃・金額の更新メソッド
        func updatePriceAndAmount() {
          
            let unitPrice = priceList[selectedSize]?[selectedType] ?? 0
            unitPriceLabel.text = "\(unitPrice)"
            
            let quantity = Int(quantityTextField.text ?? "0") ?? 0
            let isDoubleSided = sideControl.selectedSegmentIndex == 1
            let laborCost = (isDoubleSided ? 1000 : 500) * quantity
            laborCostLabel.text = "\(laborCost)"
            
            let totalAmount = unitPrice * quantity + laborCost
            amountLabel.text = "\(totalAmount)"
            
            updateTotalAmount()
        }

        // 合計金額を更新
        func updateTotalAmount() {
            // ここでは一つの表しかないため、合計金額は現在の金額と同じ
            if let amountText = amountLabel.text, let total = Int(amountText.replacingOccurrences(of: "円", with: "")) {
                totalAmountLabel.text = "\(total)"
            }
        }

        // 「＋」ボタンを押したときに追加の表を作成
        @IBAction func addTableButtonTapped(_ sender: UIButton) {
            // 新しい料金表を追加する処理
            //　今後実装
            print("新しい料金表が追加されました。")
        }
        
    //削除機能

}
