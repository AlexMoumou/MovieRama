<p align="center">
<img src="MovieRama/Assets.xcassets/movierama-3.imageset/IMG_2868.jpg" width="500" border="10"/>
</p>

# MovieRama
MovieRama is yet another movie catalog app where users can check the movies of the week, search for movies and view details about them.

## Architecture

MovieRamas architecture is based on the [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html).

MVVM is used for the presentation layer.
It uses [ObservableObject](https://developer.apple.com/documentation/combine/observableobject) as a @Published wrapped property, so changes are published whenever a dispatched action produces new data after being reduced. (Could use a single State object but this generally can cause a lot of rebuilds in prod app)

SwiftUI is used for the MovieDetailsView and UIKit with xibs for the main MoviesView.

Combine is used for the communication between the rest of the layers.

Im showcasing atleast a bit of eery testing method as well.
