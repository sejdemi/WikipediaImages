import UIKit

class WikipediaImageDisplayVC: UIViewController, UITextFieldDelegate, UITableViewDataSource {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()


        searchField.delegate = self
        searchField.addTarget(self, action: #selector(WikipediaImageDisplayVC.textDidChange(_:)), for: UIControlEvents.editingChanged)
    }


    func textDidChange(_ sender: UITextField) {
        WikipediaAPIClient.generateWikipediaImages(for: searchField.text ?? "") { (response) in
            DispatchQueue.main.async {
                print("it worked")
            }
        }
    }

    // MARK: - Data Source

    //we only need one section, there are no separate categories of images
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //we can either return the count of the images in the image array, or hard code it to 50, either way it is the same result
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }


}

