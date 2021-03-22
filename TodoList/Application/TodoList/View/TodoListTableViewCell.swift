import UIKit

class TodoListTableViewCell: UITableViewCell {

    @IBOutlet weak var checkboxButton: CheckBox!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var taskData: UserData? {
        didSet {
            guard let completed = taskData?.completed else { return }
            guard let description = taskData?.description else { return }
            guard let owner = taskData?.owner else { return }

            checkboxButton.isChecked = completed
            ownerLabel.text = owner
            descriptionLabel.text = description
        }
    }
}
