//
//  RPSTableView.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 26.06.2024.
//

import UIKit

final class RPSTableView: UITableView {
    
    //MARK: - Properties
    
    private var users = [Player]()
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        
    }
    
    
    init(users: [Player]) {
        self.users = users
        super.init(frame: .zero, style: .plain)
        
        configure()
        setDelegates()
        register(RPSTableViewCell.self,
                 forCellReuseIdentifier: RPSTableViewCell.idCell)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - DataSource

extension RPSTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.rowHeight = CGFloat(65)
        return tableView.rowHeight
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RPSTableViewCell.idCell, for: indexPath) as? RPSTableViewCell else {
            return UITableViewCell()
    }
        
        cell.configure(with: users[indexPath.row])
        
        return cell
    }
}


//MARK: - Delegate

extension RPSTableView: UITableViewDelegate {
    
}


//MARK: - Internal Methods

private extension RPSTableView {
    func configure() {
        backgroundColor = .lightGray
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setDelegates() {
        delegate = self
        dataSource = self
    }
}
