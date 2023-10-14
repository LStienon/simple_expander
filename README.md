A very simple Expansion Tile widget

## Features
For a specific project I had, I wasn't satisfied with the buil-in Expansion Tile widget, nor with any I could find on pub dev, so I made my own !

Here are the options you can customize :
* header color
* tile color
* header title
* tile title
* tile subtitle
* header trailing widget
* tile trailing widget
* overall animation duration
* "overtile" duration animation
* base height (for header and tiles)
* base curvature (for both again)
* longpress on tiles function (allows to enter a popup menu function)

Look at this beauty : (I ain't buyest lmao)
![](https://github.com/LStienon/pom_public_images/blob/main/simple_expander.gif)

## Getting started
If you want to use simple_expander, you can either enter this command into your console :
```bash
flutter pub add simple_expander
```
Or add this line into your project's dependencies :
```yaml
dependencies:
  simple_expander: ^0.1.7
```

## Usage
```dart
const example = SimpleExpander(
    headerString: "Header title",
    tiles: moreValues.map((oneSimpleObject) => SimpleExpanderTile(
        title: oneSimpleObject.name,
        subtitle: oneSimpleObject.secondName,
        onTap: () async {
          log('onTap function for simple_expander_tile with id : ${oneSimpleObject.id}');
        }
    )).toList(),
);

// WITH "oneSimpleObject" BEING INSTANCES YOU LOOP OVER TO FEED YOUR TILES
```

## Additional information
Reality check : I'm still an amateur in the matter of creating flutter packages, and it shows. This package has flaws and if you use it, feel free to report them on the public github repo. It is not super customizable, and I might try to improve this in the future (maybe).

