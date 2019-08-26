# PKAlertController
A custom alert controller where you can change the colour and font for the options

![preview](https://github.com/bestiosdeveloper/PKAlertController/blob/master/Demo.png)


## Usage

Code example for setup:

```swift
@IBAction func showOptionsButtonAction(_ sender: UIButton) {

func getPKAlertButtons(forTitles: [String], colors: [UIColor]) -> [PKAlertButton] {
guard forTitles.count == colors.count else {
fatalError("Please send the titles and colors equally")
}
var temp = [PKAlertButton]()
for (idx, title) in forTitles.enumerated() { 
temp.append(PKAlertButton(title: title, titleColor: colors[idx])) 
}
return temp
}

let titles = ["Email", "Share", "Remove from Favourites"]
let colors = [#colorLiteral(red: 0, green: 0.8, blue: 0.6, alpha: 1), #colorLiteral(red: 0, green: 0.8, blue: 0.6, alpha: 1), #colorLiteral(red: 1, green: 0.2, blue: 0.2, alpha: 1)]
let buttons = getPKAlertButtons(forTitles: titles, colors: colors)

let cancelButton = PKAlertButton(title: "Cancel", titleColor: #colorLiteral(red: 0, green: 0.7019607843, blue: 0.5254901961, alpha: 1))

_ = PKAlertController.default.presentActionSheet("What do you want to do with your \n favourite hotels?", message: nil, sourceView: self.view, alertButtons: buttons, cancelButton: cancelButton) { [weak self] _, index in

if index == 0 {
printDebug("Email")
} else if index == 1 {
printDebug("Share")
} else if index == 2 {
printDebug("Remove from Favourites")
}
}
}
```

## Licence

PKCategoryView is released under the MIT license.

