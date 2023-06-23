---
layout: post
title: "C言語練習環境の作成"
subtitle: "プログラミング練習環境の構築例"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
purpose: 
tags:

- C
- 環境構築
---



|概要||
|---|---|
|目的|C言語練習環境の作成|
|参考|- [Using C++ on Linux in VS Code](https://code.visualstudio.com/docs/cpp/config-linux)<br> - [VS Codeユーザーガイド](https://code.visualstudio.com/docs/editor/variables-reference)|

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [1. 前提環境](#1-%E5%89%8D%E6%8F%90%E7%92%B0%E5%A2%83)
- [2. プログラムの作成とコンパイル](#2-%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%A0%E3%81%AE%E4%BD%9C%E6%88%90%E3%81%A8%E3%82%B3%E3%83%B3%E3%83%91%E3%82%A4%E3%83%AB)
  - [コンパイルの例](#%E3%82%B3%E3%83%B3%E3%83%91%E3%82%A4%E3%83%AB%E3%81%AE%E4%BE%8B)
- [3. C言語 on Ubuntu in VS Code](#3-c%E8%A8%80%E8%AA%9E-on-ubuntu-in-vs-code)
  - [技術スタック](#%E6%8A%80%E8%A1%93%E3%82%B9%E3%82%BF%E3%83%83%E3%82%AF)
  - [VS Code workspaceを活用する](#vs-code-workspace%E3%82%92%E6%B4%BB%E7%94%A8%E3%81%99%E3%82%8B)
  - [Build halloworld.c](#build-halloworldc)
    - [`tasks.json`の設定項目](#tasksjson%E3%81%AE%E8%A8%AD%E5%AE%9A%E9%A0%85%E7%9B%AE)
  - [Debug helloworld.c](#debug-helloworldc)
  - [Code Runnerの設定](#code-runner%E3%81%AE%E8%A8%AD%E5%AE%9A)
    - [Configuration](#configuration)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. 前提環境

|項目|説明|
|---|---|
|OS|Ubuntu 20.04.1 LTS|
|コンパイラ|GCC|
|ビルド管理ツール|CMake|
|Debugger|GDB|
|Text Editor|Visual Studio Code|

## 2. プログラムの作成とコンパイル

プログラム作成から実行までの流れは以下のようになります：

1. エディタでプログラムを作成し、ソースファイルを保存する
2. ソースファイルをコンパイルし、オブジェクトファイルを作成する
3. オブジェクトファイルを実行する

プログラムのどこかに間違いがあると、コンパイル時に「構文エラー」というメッセージが返されるときがあります。多くのコンパイラはエラーだけでなく「警告」も表示します。コンパイルが通ったとしても警告が表示されるケースは多々あります。理想は警告フリーなソースコードを作成することですが、現実問題としてどの警告を修正するかの取捨選択が重要な作業となります。

### コンパイルの例

`./src/`ディレクトリに以下の簡単なプログラムを保存しました。

20210104_compile_test_0.c 
```c
#include <stdio.h>

int main(void)
{
    printf("Hallo World!");
    return 0;
}
```


20210104_compile_test_02.c 
```c
#include <stdio.h>

int main(void)
{
    printf("This ");
    printf("is ");
    printf("C program");

    return 0;
}
```

これらをGCCでコンパイルします。

```zsh
% gcc ./src/20210104_compile_test_01.c -o ./build/20210104_compile_test_01.o
% gcc ./src/20210104_compile_test_02.c -o ./build/20210104_compile_test_02.o
```

それぞれのファイルを実行すると以下のような結果が得られます。

```zsh
% ./build/20210104_compile_test_01.o 
Hallo World!        
% ./build/20210104_compile_test_02.o
This is C program%  
```

## 3. C言語 on Ubuntu in VS Code
### 技術スタック

|項目||
|---|---|
|開発環境|VS Code|
|C compiler|gcc|
|debugger|GDB|
|VS Code Extension: Intelisense, Debugger|C++ extension for VS Code|
|VS Code Extension: Running code|Code Runner|

### VS Code workspaceを活用する

まず、`C_LANGUAGE`というディレクトリを作成し、workspaceとして開きます。

```zsh
% mkdir C_LANGUAGE
% cd C_LANGUAGE
% code .
```

なお、C_LANGUAGEというディレクトリの構成は以下のようにします。

```
C_LANGUAGE
    ├ .vs_code: config filesが入っています
    ├ markdown: markdown files
    ├ src     : source codeを格納
    ├ build   : 実行ファイルを格納
    └ test    : test codeを格納
```

### Build halloworld.c

まず `halloworld.c` ファイルを作成します。

```c
#include <stdio.h>

int main(void)
{
    printf("Hallo World!");
    return 0;
}
```

このファイルをVS CodeからBuildすることを目指します。まずメインメニューから `Terminal > Configure Default Build Task.` を選択します。そして、compilerが複数出てくるので適切なものを選択します。すると`.vscode` folderにcompiler build settingsを記述した`tasks.json`というファイルが作成されます。

```json
{
	"version": "2.0.0",
	"tasks": [
		{
			"type": "cppbuild",
			"label": "C/C++: gcc build active file",
			"command": "/usr/bin/gcc",
			"args": [
				"-g",
				"${file}",
				"-o",
				"${workspaceFolder}/build/${fileBasenameNoExtension}"
			],
			"options": {
				"cwd": "${workspaceFolder}"
			},
			"problemMatcher": [
				"$gcc"
			],
			"group": {
				"kind": "build",
				"isDefault": true
			},
			"detail": "compiler: /usr/bin/gcc"
		}
	]
}
```

#### `tasks.json`の設定項目

|項目|説明|
|---|---|
|`command`|実行するプログラムを指定します。今回は、`"/usr/bin/gcc"`|
|`args`|gccに渡されるコマンドライン引数を指定します。|
|`${file}`|コンパイル対象のファイル|
|`${fileDirname}`|コンパイル対象のファイルと同じ名前の実行ファイルを作成します|
|`${workspaceFolder}`|/home/your-username/your-project|
|`${fileBasenameNoExtension}`|Extensionを指定|
|`"isDefault": true`|`Ctrl+Shift+B`でrunができるようになります|

### Debug helloworld.c

GDB debuggerをローンチするために必要な`launch.json`ファイルを設定します。まずメインメニューから` Run > Add Configuration`を選択し、`C++ (GDB/LLDB)`をクリックします。

するとVS Codeで`launch.json`ファイルが立ち上がります。

```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "(gdb) Launch",
            "type": "cppdbg",
            "request": "launch",
            "program": "${workspaceFolder}/build/${fileBasenameNoExtension}",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ]
        }
    ]
}
```

`program`はdebug対象となるファイルを指定します。デフォルトでは、C 拡張機能はソースコードにブレークポイントを追加せず、stopAtEntry の値は false に設定されています。stopAtEntry の値を true に変更すると、デバッグを開始するときにdebuggerがmain methodで停止します。Debugを実行したい場合はソースコードを開いた状態で`F5` クリックします。


### Code Runnerの設定

VS Codeで編集したC言語のソースコードをショートカット入力だけでTerminal上で実行したいのでVS Code ExtensionのCode Runnerをインストールします。ソースコードを開いた状態で`Ctrl+Alt+N`を入力するとTerminal上でコンパイルと実行を同時にすることができます。

#### Configuration

VS Code setting jsonでPATHを設定します。PATHを設定するにあたってのルールは以下を参照してください。

```raw
$workspaceRoot: The path of the folder opened in VS Code
$dir: The directory of the code file being run
$dirWithoutTrailingSlash: The directory of the code file being run without a trailing slash
$fullFileName: The full name of the code file being run
$fileName: The base name of the code file being run, that is the file without the directory
$fileNameWithoutExt: The base name of the code file being run without its extension
$driveLetter: The drive letter of the code file being run (Windows only)
$pythonPath: The path of Python interpreter (set by Python: Select Interpreter command)
```

これを参考にして、Workspace上に存在する`.vscode/`フォルダの下に`settings.json`をつくります。Globalで定義されている`settings.json`をベースに以下の行を追加します。

```raw
    "code-runner.clearPreviousOutput": true,
    "code-runner.runInTerminal": true,
    "code-runner.executorMap": {
        "c": "gcc $workspaceRoot/src/$fileName -o $workspaceRoot/build/$fileNameWithoutExt && $workspaceRoot/build/$fileNameWithoutExt"
    }
```
