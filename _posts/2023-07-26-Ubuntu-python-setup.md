---
layout: post
title: "Quick and simple setup with pyenv and poetry"
subtitle: "Ubuntu Python 分析環境の構築 1/N"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: true
last_modified_at: 2023-07-28
tags:

- Ubuntu 22.04 LTS
- Python
- Poetry

---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [この記事のスコープ](#%E3%81%93%E3%81%AE%E8%A8%98%E4%BA%8B%E3%81%AE%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%97)
- [Usage](#usage)
- [Set-up](#set-up)
  - [Preprocess for Ubuntu](#preprocess-for-ubuntu)
  - [Install pyenv](#install-pyenv)
  - [Install the plugins: pyenv-update/pyenv-virtualenv](#install-the-plugins-pyenv-updatepyenv-virtualenv)
  - [Install Poetry](#install-poetry)
  - [Tab completionの有効化](#tab-completion%E3%81%AE%E6%9C%89%E5%8A%B9%E5%8C%96)
  - [Basic Poetry config setup](#basic-poetry-config-setup)
- [Maintenance](#maintenance)
- [How to use `poetry` in your project](#how-to-use-poetry-in-your-project)
  - [Package install: `poetry add`](#package-install-poetry-add)
    - [`poetry add` with version constraints](#poetry-add-with-version-constraints)
    - [`poetry add` directly from GitHub Repository](#poetry-add-directly-from-github-repository)
    - [`editable mode`でのインストール](#editable-mode%E3%81%A7%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
  - [Pythonコマンドの実行](#python%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AE%E5%AE%9F%E8%A1%8C)
- [Tips](#tips)
  - [zsh promptに仮想環境状態を表示する](#zsh-prompt%E3%81%AB%E4%BB%AE%E6%83%B3%E7%92%B0%E5%A2%83%E7%8A%B6%E6%85%8B%E3%82%92%E8%A1%A8%E7%A4%BA%E3%81%99%E3%82%8B)
  - [List up pyenv-based python version](#list-up-pyenv-based-python-version)
  - [poetry install when there is no project module](#poetry-install-when-there-is-no-project-module)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## この記事のスコープ

Ubuntu 22.04.2 LTSにて分析用Python環境を以下の方針で構築

- pyenv: Python version管理
- poetry: 分析用仮想環境の作成


**想定環境**

|OS|	CPU|
|---|---|
|Ubuntu 20.04 LTS| 	Intel Core i7-9700 CPU 3.00 GHz|
|Ubuntu 22.04.2 LTS| 	AMD Ryzen 9 7950X 16-Core Processor|

**Pyenv and Poetry Version**

```zsh
% pyenv --version
pyenv 2.3.23-2-gac5efed3

% poetry --version
Poetry (version 1.5.1)
```


## Usage

パッケージ開発で`Poetry`は用いられますが, ここでは分析用Python環境の構築の際に用いる `Poetry + pyenv`の組み合わせを想定しています. 

- 分析で用いたいPython Versionを`pyenv`でインストール
- 分析環境, パッケージ依存関係, プロジェクトのパッケージ化を`Poetry`で管理


```mermaid
---
title: Python Env Set-up Flow
---
classDiagram
  direction LR

%%--- Entityの定義

    class mkdir{
        mkdir <--local path-->
        git init & set-up .gitignore
        git remote add origin <--github path-->
        git commit & push
    }


    class pyenv{
        pyenv install --list
        pyenv install <--python version-->
        pyenv local <--python version-->
        \n
    }

    class poetry{
    poetry init
    poetry install --no-root
    poetry add <--packages-->
    poetry run python, poetry run pytest
    }

%%--- Entity Relationの定義

mkdir --> pyenv
pyenv --> poetry
```

## Set-up
### Preprocess for Ubuntu

Ubuntu環境でpyenvをインストール場合, Python関連パッケージのBuildに必要なツールを事前にインストールしておくことが推奨されます. 

```zsh
ModuleNotFoundError: No module named '_ctypes'
```

インストールは成功したが, いざ使用しようと思った際に`pip`関係で上記のエラーが発生する場合があります. 上記の場合は, Cで書かれたライブラリを Pythonから利用するための使用する`ctypes `モジュールが存在しないエラーですが, `libffi`がインストールされていない状態でPythonをインストールしてしまったことが原因となります.

ですので, 以下のパッケージを事前にインストールしときましょう.

```zsh
% sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev
```


### Install pyenv

今回は, `$HOME`直下に`.pyenv`というdirectoryを作り, そこに`pyenv`を`git`経由でインストールしています. 

```zsh
% tree -L 1   
.
├── Desktop
├── Documents
├── Downloads
├── ...
└── .pyenv
```

インストール手順は簡単で

- pyenv repository を`git clone`する
- `pyenv`のpathを通す
- `pyenv init --path`をシェル立ち上げ時に実行する設定をする

```zsh
## pyenv install
% mkdir ~/.pyenv
% git clone https://github.com/pyenv/pyenv.git ~/.pyenv
```

次に, `.zshenv`(`.zshrc`でもok, bashを使っているならば`.bashrc`など)の設定を行う:

```zsh
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
```

### Install the plugins: pyenv-update/pyenv-virtualenv

pyenvにはpluginがあり今回は２つの`pyenv-update`, `pyenv-virtualenv`をインストールします.

|ツール|説明|
|---|---|
|`pyenv-update`|pyenvとそのpluginsのupdateツール|
|`pyenv-virtualenv`|仮想環境作成ツール|

- 後者は基本的には`Poetry`を利用する予定なのであまり必要ないですが, 様々な環境で簡易的に使いまわしたいという場合を想定してインストールしておきます
- 前者は, python-listの更新など絶対に必要

<div style="display: inline-block; background: #D3D3D3;; border: 1px solid #D3D3D3; padding: 3px 5px;color:black"><span >Install plugins</span>
</div>

<div style="border: 1px solid #D3D3D3; font-size: 100%; padding: 5px;">

**pyenv-update**

```zsh
% git clone https://github.com/pyenv/pyenv-update.git $(pyenv root)/plugins/pyenv-update
```

**pyenv-virtualenv**

```zsh
% git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
% echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshenv
```


</div>

### Install Poetry

Installコマンドは公式ドキュメントに従い以下. なお, `pip`経由でインストールする方法がたまに紹介されていますがそれは非推奨です.

```zsh
## pipxでのinstall
% pipx install poetry

## curlでのinstall
% curl -sSL https://install.python-poetry.org | python3 -
```

Poetryをupdateしたい場合は

```zsh
% poetry self update
```

### Tab completionの有効化

poetryコマンドの補完機能を利用したい場合は,

1. `poetry completions zsh` で出力されるスクリプトをシェルの仕様に従ったファイル保存し
2. シェルにPathを通す. 

自分の場合は, `zsh`を使用しているので

```zsh
poetry completions zsh > ~/.zsh.d/.zfunc/_poetry
```

その後, `.zshrc`に以下のラインを追記しています

```zsh
# zsh completion
fpath+=~/.zsh.d/.zfunc
```

### Basic Poetry config setup

Poetryのconfig directoryはデフォルトでは以下で管理されてます

- Linux: `~/.config/pypoetry`
- MacOS: `~/Library/Application Support/pypoetry`
- Windows: `%APPDATA%\pypoetry`

config file自体は上記のディレクトリの`config.toml`に記載されます.
config setup内容は以下のコマンドで確認できます

```zsh
% poetry config --list
cache-dir = "/home/hoshino_kirby/.cache/pypoetry"
experimental.system-git-client = true
installer.max-workers = null
installer.modern-installation = true
installer.no-binary = null
installer.parallel = true
keyring.enabled = true
solver.lazy-wheel = true
virtualenvs.create = true
virtualenvs.in-project = true
virtualenvs.options.always-copy = false
virtualenvs.options.no-pip = false
virtualenvs.options.no-setuptools = false
virtualenvs.options.system-site-packages = false
virtualenvs.path = "{cache-dir}/virtualenvs"  # /home/hoshino_kirby/.cache/pypoetry/virtualenvs
virtualenvs.prefer-active-python = true
virtualenvs.prompt = "{project_name}-py{python_version}"
warnings.export = true
```

設定項目のうち明示的に今回指定しているのは以下です:

|項目|設定値|説明|
|---|---|---|
|`experimental.system-git-client`|true|`True`でsystem git client backendを利用. `False`だと古い`dulwich`を利用.|
|`virtualenvs.create`|true|Create a new virtual environment if one doesn’t already exist.|
|`virtualenvs.in-project`|true|Create the virtualenv inside the project’s root directory.|
|`virtualenvs.prefer-active-python`|true|Use currently activated Python version to create a new virtual environment. `pyenv`との組み合わせで必要. |

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 5px;color:#FFFFFF"><span >設定方法</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 5px;">

```zsh
## setting
% poetry config experimental.system-git-client true 
% poetry config virtualenvs.in-project true
% poetry config virtualenvs.create true
% poetry config virtualenvs.prefer-active-python true

## use --unset option if you want to unset
% poetry config virtualenvs.path --unset
```

</div>

<br>

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 5px;color:#FFFFFF"><span >Local specificに設定する場合</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 5px;">


とあるレポジトリ特有の設定をしたい場合は `--local` オプションを付与してconfig設定をします. 例として,

```zsh
% poetry config virtualenvs.create false --local
```

local configurationは`poetry.toml`というファイルの中に記載されます. `.gitignore`で
gitの管理から外しておくことが推奨です.

</div>


## Maintenance

poetryとpyenvのupdateは定期的に実行したいので, shell scriptに僕の場合はまとめました.

```bash
#!/bin/bash
## name: python_update
## Update the python env
## Author: RyoNak
## Revised: 2023-07-28
## REQUIREMENT: pyenv, virtualenv, poetry

set -e

# Functions
function usage {
  cat <<EOM
NAME
    $(basename "$0") - update pyenv and its plugins, and poetry. 

        pyenv update;
        poetry self update;

DESCRIPTION
    <pyenv and its plugins>
    pyenv
        https://github.com/pyenv/pyenv

    pyenv-update
        https://github.com/pyenv/pyenv-update

    pyenv-virtualenv
        https://github.com/pyenv/pyenv-virtualenv

    <poetry>
    poetry
        https://python-poetry.org/docs/
    
OPTIONS
  -h, --help
    Display help

EOM

  exit 0
}


# Main
if [[ $1 == '-h' || $1 == '--help' ]]; then
    usage
else
    pyenv update;
    poetry self update;
fi
```

## How to use `poetry` in your project
### Package install: `poetry add`

パッケージをインストールするときは, `poetry add` commandを用います. 
以下のようにバージョン制約を指定いない場合, poetryは利用可能なパッケージバージョンに基づいて適したものを選びます.

```zsh
% poetry add requests pendulum
```

#### `poetry add` with version constraints

Version成約をつける場合は以下のように指定します:

```zsh
# Allow >=2.0.5, <3.0.0 versions
poetry add pendulum@^2.0.5

# Allow >=2.0.5, <2.1.0 versions
poetry add pendulum@~2.0.5

# Allow >=2.0.5 versions, without upper bound
poetry add "pendulum>=2.0.5"

# Allow only 2.0.5 version
poetry add pendulum==2.0.5

# get the latest version
poetry add pendulum@latest
```

#### `poetry add` directly from GitHub Repository

GitHubのレポジトリからpackageをインストールしたい場合は以下のようなコマンドを用います

```zsh
## via https protocol
% poetry add git+https://github.com/sdispater/pendulum.git

# install a package from the develop branch
% poetry add git+https://github.com/sdispater/pendulum.git#develop

# install a package based on a specific tag(2.0.5)
poetry add git+ssh://github.com/sdispater/pendulum.git#2.0.5
```

#### `editable mode`でのインストール

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Def: editable mode</ins></p>

- `editable mode`とはコードが編集可能な状態でパッケージをインストールするオプションのこと
- `editable mode`` でインストールされたパッケージのコードに変更を加えると, 再インストールをしなくてもそのまま実行環境に反映される

</div>


```zsh
% poetry add --editable <package>
```

で`editable mode`でのインストールがpoetryではできます. 
ローカルにファイルのあるパッケージをpluginとして利用するが, バグの可能性も考えて編集モードでインストールしたい場合に便利です.

### Pythonコマンドの実行

Poetryで作成した仮想環境のPythonでfileを実行したい場合, 

- `poetry shell`で仮想環境をコール, 呼びたした仮想環境内部でPythonコマンドを実行
- `poetry run`コマンドを頭につけて, Pythonコマンドを実行

の２つがあります

```zsh
## 仮想環境を呼び出して実行
% poetry shell
(.venv) $ python main.py

## poetry runで実行
% poetry run python main.py
```

## Tips
### zsh promptに仮想環境状態を表示する

留意点として, 事前に`virtualenv`のpluginを加えておく必要があります.
まず, custom fucntionを`.zshrc`に以下のように定義します.

```zsh
# Python virtual env
function virtualenv_info { 
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}
```

つぎにinteractive shellのpromptに表示するため, `pro,pt_setup()`に`$(virtualenv_info)`を加えます.

```zsh
prompt_setup() {
    prompt_color1=${1:-'cyan'}
    prompt_color2=${2:-'cyan'}

    base_prompt="%F{$prompt_color1}%n@%m%f %F{$prompt_color2}%B%~%b%f "
    git_prompt='$(__posh_git_echo)'
    post_prompt=$'\n'"$(virtualenv_info)%# "

    PROMPT=$base_prompt$git_prompt$post_prompt
}
```

### List up pyenv-based python version

```zsh
% pyenv install --list | grep -P "^\s{1,}\d{1,}\.\d{1,}\.\d{1,}"
```

- `grep -P`: Pearl regular expressionを用いて検索
- `pyenv-list`などシェルスクリプト定義しておくと便利

### poetry install when there is no project module

<div style='padding-left: 2em; padding-right: 2em; border-radius: 0em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem</ins></p>

```zsh
% poetry install
...
<path-to-working-directory>/ <project-name> does not contain any element
```

</div>


`poetry new`, or `poetry init` コマンドで生成される`pyproject.toml`には以下のラインがデフォルトで記載されます:

```toml
[tool.poetry]
packages = [{include = "<project-name>"}]
```

package開発用のderectoryの場合ならば`<project-name>`の名前を持つdirectoryが存在するケースが多いと思いますが, 単に分析用に仮想環境を作成した場合はない場合があります.

このような状況のときに, `poetry install`コマンドを実行すると, 存在しない`<project-name>`directoryをpoetryが探してしまい以下のようなwarning messageがでてきます:

```zsh
% poetry install
...
<path-to-working-directory>/ <project-name> does not contain any element
```

<div style="display: inline-block; background: #6495ED;; border: 1px solid #6495ED; padding: 3px 5px;color:#FFFFFF"><span >Solution</span>
</div>

<div style="border: 1px solid #6495ED; font-size: 100%; padding: 5px;">

`pyporject.toml`から`packages = [{include = "<project-name>"}]`を削除することでWarning messageの対応は可能ですが, 以下のコマンドでroot projectをinstallしないことをpoetryに伝えることでもwarningを回避することができます:

```zsh
% poetry install --no-root
```

</div>


References
-----------

- [GitHub > pyenv: pyenv source code respository](https://github.com/pyenv/pyenv)
- [GitHub > pyenv-virtualenv: pyenv-virtualenv plugin source code respository](https://github.com/pyenv/pyenv-virtualenv)
- [Poetry](https://python-poetry.org/)
- [stackoverflow > Poetry install on an existing project Error "does not contain any element"](https://stackoverflow.com/questions/75397736/poetry-install-on-an-existing-project-error-does-not-contain-any-element)
- [stckoverflow > virtualenv name not show in zsh prompt](https://stackoverflow.com/questions/38928717/virtualenv-name-not-show-in-zsh-prompt)
