# photos_sync

A Flutter app to sync photos to/from a remote server.

## About

This app has two modes: uploader and downloader, and runs on Android, iOS and macOS.

The *uploader* can choose photos from their device to sync

<table>
    <tr>
        <td><img src="docs/images/01.png" /></td>
        <td><img src="docs/images/02.png" /></td>
    </tr>
</table>

while the *downloader* syncs these photos to `~/Downloads/PhotoSync`.

<table>
    <tr>
        <td><img src="docs/images/03.png" /></td>
        <td><img src="docs/images/04.png" /></td>
    </tr>
</table>

Note: by default, mobile is considered the uploader, while desktop is the downloader.

## Getting Started

If you would like to build the app yourself, then you simply need:

- Flutter >= 1.20 (master branch)
- Dart >= 2.9
- Xcode >= 11.5
- Android SDK >= 29.0.4
- macOS >= 10.15

Also you need to create a Firebase project and [add it](https://firebase.google.com/docs/flutter/setup) to this Flutter project.

## Contributing

The project isn't actively looking for contributors, however feel free to contact James here on GitHub or [Twitter](https://twitter.com/defuncart).

## Credits

Concept, Design and Programming by James Leahy.
