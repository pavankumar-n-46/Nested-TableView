//
//  ViewController.swift
//  NestedTableView
//
//  Created by Pavan Kumar on 03/02/21.
//

import UIKit

class ViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(TableViewCellOne.self, forCellReuseIdentifier: TableViewCellOne.description())
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        tableView.separatorStyle = .none
    }
}

private extension ViewController {
    func commonInit() {
        setUI()
        setConstraints()
    }

    func setUI() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }

    func setConstraints() {
        tableView.edgesToSuperview(usingSafeArea: true)
    }
}

//MARK: Tableview delegates
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sample.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: TableViewCellOne.description(),
                                     for: indexPath) as? TableViewCellOne else { return UITableViewCell() }
        cell.configure(withModel: sample[indexPath.row])
        cell.helperDelegate = self
        return cell
    }
}

extension ViewController: HeplerDelegate {
    func heightChanged() {
        
        tableView.performBatchUpdates(nil)
    }

    func cellAdded() {

    }

    func cellDeleted() {

    }
}

extension UITableView {
    public override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentSize
    }

    public override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
}

extension CGFloat {
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}
