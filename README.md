# FinderGo

<div align = "center">
<img src="Images/Icon.png" width="150" height="150" />
<br>
<br>
</div>

# Description

- Icon http://emojione.com/
- Get the binary from https://github.com/onmyway133/FinderGo/releases
- Support macOS 10.12

## As a macOS Application

![](Images/go1.gif)

### Features

- Support `iTerm` for now

### How to use
- Right click on app to open, because this is not from AppStore
- Cmd+Drag app icon into Finder toolbar

## As a Finder Sync Extension

### Features

- [x] Go to Terminal
- [x] Go to iTerm
- [x] Go to Hyper

<div align = "center">
<img src="Images/screenshot2.png" />
<br>
<br>
</div>

### How to use

- Because of sandbox, we need to copy scripts from `FinderSyncExtension/Scripts` in project to `/Library/Application Scripts/com.fantageek.FinderGo.FinderSyncExtension` by running 

```sh
curl -fsSL https://raw.githubusercontent.com/onmyway133/FinderGo/master/install.sh | sh
```

- Check for `System Preferences` -> `Extensions` -> `Finder` to enable `FinderGo` if it is not enabled yet

![](Images/extension.png)

- Right click on Finder toolbar -> `Customize Toolbar`, then Cmd+Drag `FinderGo` onto toolbar

![](Images/toolbar.png)


## Author

Khoa Pham, onmyway133@gmail.com

## License

**FinderGo** is available under the MIT license. See the [LICENSE](https://github.com/onmyway133/FinderGo/blob/master/LICENSE.md) file for more info.
