//
//  EditNoteViewController.swift
//  VideoGamesStore
//
//  Created by Burak on 20.01.2023.
//

import UIKit

class EditNoteViewController: UIViewController {
    
    private let textView: UITextView = {
       let textView = UITextView()
        textView.text = ""
        textView.layer.cornerRadius = 10
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.isEditable = true
        textView.textColor = UIColorConstants.redColor
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizationHelper.addNote.localized, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = UIColorConstants.redColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let listView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.backgroundColor = UIColor.white
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return table
    }()
    
    private let viewModel: EditNoteViewModel = EditNoteViewModel()
    
    var editNote: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = UIColorConstants.creamColor
        
        view.addSubview(textView)
        view.addSubview(addButton)
        view.addSubview(listView)
        listView.addSubview(tableView)
        
        addButton.addTarget(self, action: #selector(addNote), for: .touchDown)
        
    }
    
    func configure(gameId: Int){
        viewModel.gameId = gameId
        viewModel.getNotes()
    }
    
    @objc func addNote(){
        if(editNote != nil){
            viewModel.updateNote(note: editNote!, newNote: textView.text)
        }else{
            viewModel.addNote(note: textView.text)
        }
    }

    func changeButtonName(){
        self.addButton.setTitle(self.editNote != nil ?  LocalizationHelper.edit.localized : LocalizationHelper.addNote.localized, for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let textViewContraints = [
            textView.topAnchor.constraint(equalTo: view.topAnchor,constant: 30),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            textView.heightAnchor.constraint(equalToConstant: 70)
        ]
        NSLayoutConstraint.activate(textViewContraints)
        
        let addButtonContraints = [
            addButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20),
            addButton.widthAnchor.constraint(equalToConstant: 100),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(addButtonContraints)
        
        let listViewContraints = [
            listView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            listView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ]
        NSLayoutConstraint.activate(listViewContraints)
        
        tableView.frame = listView.bounds
    }
}

extension EditNoteViewController: EditNoteViewModelDelegate {
    func showAlert() {
        let alert = UIAlertController(title: LocalizationHelper.warning.localized, message: LocalizationHelper.noteCannotBeBlankOrLessThan3Letters.localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LocalizationHelper.ok.localized, style: .cancel))
        present(alert, animated: true)
    }
    
   
    func updateNoteList() {
            self.textView.text = ""
            self.editNote = nil
            changeButtonName()
            self.tableView.reloadData()
    }
    
    
}

extension EditNoteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.notes.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return LocalizationHelper.notes.localized
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = viewModel.notes[indexPath.row].note
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .normal, title: nil){ (action, sourceView, completionHandler) in
                self.viewModel.deleteNote(row: indexPath.row)
            }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = UIColorConstants.redColor
            
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editNote = viewModel.notes[indexPath.row].note
        textView.text = editNote
        changeButtonName()
    }
    
}
