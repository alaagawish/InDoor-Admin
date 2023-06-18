//
//  PriceRuleViewController.swift
//  InDoor-Admin
//
//  Created by Ahmed on 17/06/2023.
//

import UIKit
import Lottie

class PriceRuleViewController: UIViewController {
    
    @IBOutlet weak var doneAnimation: LottieAnimationView!
    @IBOutlet weak var minimumSubtotalTextField: UITextField!
    @IBOutlet weak var curtain: UIView!
    @IBOutlet weak var usageLimitTextField: UITextField!
    @IBOutlet weak var disountAmountTextField: UITextField!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var startDatePicler: UIDatePicker!
    @IBOutlet weak var titleTextFileld: UITextField!
    @IBOutlet weak var editingPanelView: UIView!
    var ruleBeingHandled: PriceRule!
    var selectedRuleIndex: Int!
    var rulesList:[PriceRule] = []
    var priceRuleViewModel = PriceRuleViewModel(network: ApiHandler())
    var networkIndicator = UIActivityIndicatorView()
    var editOrAdd = ""

    @IBOutlet weak var priceRulesTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNibCell()
        loadIndicator()
        prepareEditingPanel()
    }

    override func viewWillAppear(_ animated: Bool) {
        getPriceRules()
    }
    
    func setupNibCell(){
        let nib = UINib(nibName: PriceRuleConstants.cellClassName , bundle: nil)
        priceRulesTable.register(nib, forCellReuseIdentifier: PriceRuleConstants.cellName)
    }
    
    func loadIndicator(){
        networkIndicator = UIActivityIndicatorView(style: .large)
        networkIndicator.center = self.view.center
        self.view.addSubview(networkIndicator)
        networkIndicator.startAnimating()
    }
    
    func getPriceRules(){
        priceRuleViewModel.getAllPriceRules {[weak self] allRules in
            self?.rulesList = allRules
            self?.networkIndicator.stopAnimating()
            self?.priceRulesTable.reloadData()
        }
    }
    
    @IBAction func addPriceRule(_ sender: Any) {
        showEditingPanel()
        resetViews()
        editOrAdd = "add"
        ruleBeingHandled = PriceRule()
        var subtotal = PrerequisiteSubtotalRange()
        ruleBeingHandled = PriceRule(allocationMethod: "across" , customerSelection: "all" , oncePerCustomer: true, prerequisiteSubtotalRange: subtotal,targetSelection: "all", targetType: "line_item" )
    }
    
    func hideEditingPanel(){
        editingPanelView.isHidden = true
        curtain.isHidden = true
    }
    
    func showEditingPanel(){
        editingPanelView.isHidden = false
        curtain.isHidden = false
    }
}

extension PriceRuleViewController {
    class PriceRuleConstants{
        static let cellClassName = "PriceRuleTableViewCell"
        static let cellName = "priceRuleCell"
    }
}
