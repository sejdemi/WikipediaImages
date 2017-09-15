import UIKit

class WikipediaImageDisplayVC: UIViewController, UITextFieldDelegate, UITableViewDataSource {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        searchField.delegate = self
        searchField.addTarget(self, action: #selector(WikipediaImageDisplayVC.textDidChange(_:)), for: UIControlEvents.editingChanged)
    }


    func textDidChange(_ sender: UITextField) {
        WikipediaAPIClient.generateWikipediaImages(for: searchField.text ?? "") {
            (response) in

            DispatchQueue.main.async {
                self.tableView.reloadData()
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

        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! WikipediaImageViewCell
        let image = Image.imageArray[indexPath.row]
        
        if let url = URL(string: image.thumbnail) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in

                //"promise" forcing this piece of async code to be sync, so it happens in my for loop
                guard let data = data, error == nil else { return }

//                DispatchQueue.main.sync() {
                    cell.imageView?.image = UIImage(data: data)
                    //setting that data equal to data of the first image view
//                }
            }
            DispatchQueue.global(qos: .background).async {

                task.resume()
            }
        }
        return cell
}


}

