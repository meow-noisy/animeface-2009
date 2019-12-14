# AnimeFace 2009

The face detector for anime/manga.
This is similar to [lbpcascade_animeface](https://github.com/nagadomi/lbpcascade_animeface), but it's more accurate and supports facial landmark detection.
I developed this library in 2008~2009.

Original website: http://anime.udp.jp/ (in Japanese)

![demo](https://user-images.githubusercontent.com/287255/43184397-6a8dd6ca-9023-11e8-8eaa-31a178680878.png)

Figure (c) namco


## my installation(on Linux Ubuntu)

1. Install [Linuxbrew](https://docs.brew.sh/Homebrew-on-Linux)
1. Install some packages
    - `brew install imagemagick@6`
    - `brew install pkg-config`
1. add below lines to your shell setting file, edit lines for your environment and update your shell 
```
linuxbrew_root="???"

export PATH="${linuxbrew_root}/opt/imagemagick@6/bin:$PATH"
export LDFLAGS="-L${linuxbrew_root}/opt/imagemagick@6/lib"
export CPPFLAGS="-I${linuxbrew_root}/opt/imagemagick@6/include"
export PKG_CONFIG_PATH="${linuxbrew_root}/opt/imagemagick@6/lib/pkgconfig"
export LD_LIBRARY_PATH="${linuxbrew_root}/Cellar/imagemagick@6/<**YOUR IMAGEMAGICK VERSION**>/lib:$LD_LIBRARY_PATH"  
```
4. `gem install rmagick`
1. `./build.sh`

ref1(Japanese): [RailsでRMagickを使う](https://qiita.com/yukiweaver/items/52c45f442b9d9d59367e)  
ref2(Japanese): [linuxbrewで入れるrmagickの設定](https://takkii.hatenablog.com/entry/2019/02/28/200143)


## original author's installation

Requirements
- Ruby
- ImageMagick
- gcc, make

### Ubuntu
```
sudo apt-get install libmagickwand-dev
sudo gem install rmagick
./build.sh
```

### Arch Linux
Install `imagemagick-full` and `ruby-rmagick` from [AUR](https://aur.archlinux.org/),
and then run `./build.sh`.

## Run sample code (Ruby)

```
cd animeface-ruby
ruby sample.rb <input image>
```
View at `${input_image}_out.png`

## Extract landmarks for a folder of images (Ruby)

First install Ruby package `progress_bar`. Then run:

```
cd animeface-ruby
ruby proc_folder.rb <input image folder> <output landmark file>
```

Each of the lines in the `<output landmark file>` is a JSON string corresponding to a file in `<input image folder>`.
View the output file for more details.

Alternatively, replace `proc_folder.rb` with `proc_folder_parallel.rb` leads to image processing in parallel.
This requires Ruby package `parallel` and `ruby-progressbar`

## Create new dataset with animeface-ruby

1. Prepare images first.
2. Extract face images with `animeface-ruby/face_collector.rb`
```
face_collector.rb --src <image dir> --dest <output dir> --threshold <0.0~1.0, default: 0.2> --margin <0.0~, default: 0.1>
```
3. Delete false positive images using windows explorer or something.
4. Make annotation data from the filename (filename is formatted as `${orignal_file_name_without_extension}_${x}_${y}_${width}_${height}.png`, see [example](./animeface-ruby/face2xml.rb))
