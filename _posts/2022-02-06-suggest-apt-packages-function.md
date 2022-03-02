---
layout: post
title: "Linux基礎知識：bash環境でのパッケージのサジェスト機能"
subtitle: "command-not-foundの実装の確認"
author: "Ryo"
header-img: "img/post-bg-rwd.jpg"
header-mask: 0.4
catelog: true
mathjax: true
purpose: 
tags:

- Linux
- apt
---

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-LVL413SV09"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-LVL413SV09');
</script>

**Table of Contents**
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [コマンドがないときのパッケージのサジェスト](#%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%8C%E3%81%AA%E3%81%84%E3%81%A8%E3%81%8D%E3%81%AE%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%AE%E3%82%B5%E3%82%B8%E3%82%A7%E3%82%B9%E3%83%88)
- [パッケージのサジェストの仕組み](#%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%AE%E3%82%B5%E3%82%B8%E3%82%A7%E3%82%B9%E3%83%88%E3%81%AE%E4%BB%95%E7%B5%84%E3%81%BF)
- [`/usr/lib/command-not-found`の正体](#usrlibcommand-not-found%E3%81%AE%E6%AD%A3%E4%BD%93)
  - [プログラム本体](#%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%A0%E6%9C%AC%E4%BD%93)
- [Ryo's Tech Blog 関連記事](#ryos-tech-blog-%E9%96%A2%E9%80%A3%E8%A8%98%E4%BA%8B)
- [References](#references)
- [Appendix](#appendix)
  - [bashの終了ステータス](#bash%E3%81%AE%E7%B5%82%E4%BA%86%E3%82%B9%E3%83%86%E3%83%BC%E3%82%BF%E3%82%B9)
  - [zshにおける`command_not_found_handle`](#zsh%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8Bcommand_not_found_handle)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## コマンドがないときのパッケージのサジェスト

bashでは、ユーザーが入力したコマンドが存在しない場合， エラーを表示するだけでなく、必要となりそうなパッケージを推測・提案してくれる機能があります. 

```bash
$ sl

Command 'sl' not found, but can be installed with:

sudo apt install sl

$ chinko
chinko: command not found

$ unko

Command 'unko' not found, did you mean:

  command 'nuko' from snap nuko (0.2.1)

See 'snap info <snapname>' for additional versions.
```

なお、zshでも同様の機能をもちいることができますが、`.zshrc`でちょっとした設定をしない限り以下のような出力になります(こちらのほうがシンプルで好き):

```zsh
% sl
zsh: command not found: sl
% chinko
zsh: command not found: chinko
% unko
zsh: command not found: unko
```

## パッケージのサジェストの仕組み

Bashには検索パスにコマンドが見つからない場合、command_not_found_handle関数を呼び出すという仕組みが存在します. 関数が存在する場合、元コマンドを引数に`command-not-found`という関数を回して、関連パッケージの検索とサジェストを実行します. 関数が定義されていない場合は、エラーメッセージの出力と終了ステータス127を返す仕組みとなっています. 

Ubuntuのbashパッケージが提供する`/etc/bash.bashrc`には最初から，command-not-foundがインストール済みならcommand_not_found_handleを定義するスクリプトが組み込まれています. 実際に確認してみると

```bash
# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/lib/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/share/command-not-found/command-not-found ]; then
		   /usr/share/command-not-found/command-not-found -- "$1"
                   return $?
		else
		   printf "%s: command not found\n" "$1" >&2
		   return 127
		fi
	}
fi
```

`/usr/lib/command-not-found`がパッケージサジェストの根幹をなしていることがわかります.

> if条件の中に表れる`-x`, `-o`の意味はなにか？

`-x`はファイルテスト演算子、`-o`はブール演算子のことを指しています. 代表的なものは以下：

---|---
`if [ -f path ]; then`|パスがファイルならばtrue
`if [ -d path ]; then`|パスがディレクトリならばtrue
`if [ -w file ]; then`|ファイルがwritableならばtrue
`if [ -r file ]; then`|ファイルがreadableならばtrue
`if [ -x file ]; then`|ファイルが実行可能ならばtrue
`if test [ ... ] -a [ ... ]; then`|２つの条件をANDでつなぐ
`if test [ ... ] -o [ ... ]; then`|２つの条件をORでつなぐ

これを踏まえると、

```zsh
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found]; then
    ...
```

`/usr/lib/command-not-found`または`/usr/share/command-not-found/command-not-found`のいずれかが実行可能ならば、という意味になります.


> `printf "%s: command not found\n" "$1" >&2`は何をやっているのか？

まず「標準入出力」の概念を確認します. プロセスが起動すると、データストリームの出入り口が３つ与えられます. これをそれぞれ「標準入力」「標準出力」「標準出力エラー」といいます. これら出入り口には番号が与えられており、

---|---
0|標準入力
1|標準出力
2|標準出力エラー

`printf "%s: command not found\n" "$1" >&2`は`printf "%s: command not found\n" "$1"`の出力結果をリダイレクトで`2`(つまり、標準出力エラー)に出力することを意味してます. なお、`&`は`>&`でワンセットで、標準出入力へのリダイレクトを意味します. なので`>&2`で初めて意味をなし、`>`と`2`のセットで標準出力を標準エラーにコピーするという意味となります.

なお、`>2`だけだと`2`という変数に出力結果をリダイレクトするという意味になってしまいます(=カレントディレクトリに2というファイルが生成されてしまいます).

## `/usr/lib/command-not-found`の正体
### プログラム本体

- プログラムはPythonスクリプト
- CommandNotFoundパッケージは[zyga/command-not-found](https://github.com/zyga/command-not-found)参照


```python
#!/usr/bin/python3
# (c) Zygmunt Krynicki 2005, 2006, 2007, 2008
# Licensed under GPL, see COPYING for the whole text

from __future__ import absolute_import, print_function


__version__ = "0.3"
BUG_REPORT_URL = "https://bugs.launchpad.net/command-not-found/+filebug"

try:
    import sys
    if sys.path and sys.path[0] == '/usr/lib':
        # Avoid ImportError noise due to odd installation location.
        sys.path.pop(0)
    if sys.version < '3':
        # We might end up being executed with Python 2 due to an old
        # /etc/bash.bashrc.
        import os
        if "COMMAND_NOT_FOUND_FORCE_PYTHON2" not in os.environ:
            os.execvp("/usr/bin/python3", [sys.argv[0]] + sys.argv)

    import gettext
    import locale
    from optparse import OptionParser

    from CommandNotFound.util import crash_guard
    from CommandNotFound import CommandNotFound
except KeyboardInterrupt:
    import sys
    sys.exit(127)


def enable_i18n():
    cnf = gettext.translation("command-not-found", fallback=True)
    kwargs = {}
    if sys.version < '3':
        kwargs["unicode"] = True
    cnf.install(**kwargs)
    try:
        locale.setlocale(locale.LC_ALL, '')
    except locale.Error:
        locale.setlocale(locale.LC_ALL, 'C')


def fix_sys_argv(encoding=None):
    """
    Fix sys.argv to have only unicode strings, not binary strings.
    This is required by various places where such argument might be
    automatically coerced to unicode string for formatting
    """
    if encoding is None:
        encoding = locale.getpreferredencoding()
    sys.argv = [arg.decode(encoding) for arg in sys.argv]


class LocaleOptionParser(OptionParser):
    """
    OptionParser is broken as its implementation of _get_encoding() uses
    sys.getdefaultencoding() which is ascii, what it should be using is
    locale.getpreferredencoding() which returns value based on LC_CTYPE (most
    likely) and allows for UTF-8 encoding to be used.
    """
    def _get_encoding(self, file):
        encoding = getattr(file, "encoding", None)
        if not encoding:
            encoding = locale.getpreferredencoding()
        return encoding


def main():
    enable_i18n()
    if sys.version < '3':
        fix_sys_argv()
    parser = LocaleOptionParser(
        version=__version__,
        usage=_("%prog [options] <command-name>"))
    parser.add_option('-d', '--data-dir', action='store',
                      default="/usr/share/command-not-found",
                      help=_("use this path to locate data fields"))
    parser.add_option('--ignore-installed', '--ignore-installed',
                      action='store_true',  default=False,
                      help=_("ignore local binaries and display the available packages"))
    parser.add_option('--no-failure-msg',
                      action='store_true', default=False,
                      help=_("don't print '<command-name>: command not found'"))
    (options, args) = parser.parse_args()
    if len(args) == 1:
        try:
            cnf = CommandNotFound.CommandNotFound(options.data_dir)
        except FileNotFoundError:
            print(_("Could not find command-not-found database. Run 'sudo apt update' to populate it."), file=sys.stderr)
            print(_("%s: command not found") % args[0], file=sys.stderr)
            return
        if not cnf.advise(args[0], options.ignore_installed) and not options.no_failure_msg:
            print(_("%s: command not found") % args[0], file=sys.stderr)

if __name__ == "__main__":
    crash_guard(main, BUG_REPORT_URL, __version__)

```






## Ryo's Tech Blog 関連記事

- [Ubuntu環境構築基礎知識：パッケージの管理](https://ryonakagami.github.io/2020/12/20/packages-manager-apt-command/)

## References

- [Ubuntu wiki > CommandNotFoundMagic](https://wiki.ubuntu.com/CommandNotFoundMagic)
- [zyga/command-not-found](https://github.com/zyga/command-not-found)

## Appendix
### bashの終了ステータス

コマンド終了時には「終了ステータス(exit-status)」と呼ばれるコマンドの成否を表す数値が特殊変数 `$?` に自動で設定されます. bashの終了ステータスの範囲は 0 から 255 で、0 は正常終了、それ以外は異常終了です. 予約済みの終了ステータス一覧は以下、

|終了ステータス|意味|
|---|---|
|1| 一般的なエラー|
|2| ビルトインコマンドの誤用|
|126| コマンドを実行できなかった（実行権限がなかった）|
|127| コマンドが見つからなかった|
|128| exit に不正な値を渡した（例えば浮動小数点数）|
|128+n| シグナル n で終了|
|255| 範囲外の終了ステータス |

### zshにおける`command_not_found_handle`

zshではコマンドが無い場合`command_not_found_handler`が呼び出される仕組みになっています.
コマンドが存在しない場合の出力を変更したい場合は、`.zshrc`で`command_not_found_handler`を定義します.

```
function command_not_found_handler() {
  echo "$1; not found";
  apt moo;
}
```

と`.zshrc`に書き込んで`sl`という存在しないコマンドを打ち込むと

```zsh
% sl
sl; not found
                 (__) 
                 (oo) 
           /------\/ 
          / |    ||   
         *  /\---/\ 
            ~~   ~~   
..."Have you mooed today?"...
```