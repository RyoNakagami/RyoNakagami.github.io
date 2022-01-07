[Ryo Blog](https://ryonakagami.github.io)
================================

> がんばる

![](img/ryos-tech-blog-example.png)


[User Manual 👉](_doc/Manual.md)
--------------------------------------------------

### Getting Started

1. [Jekyll](https://jekyllrb.com/)ベースで構築しているため[Ruby](https://www.ruby-lang.org/en/) と [Bundler](https://bundler.io/)をinstallする必要があります. [Using Jekyll with Bundler](https://jekyllrb.com/tutorials/using-jekyll-with-bundler/)に従って環境構築推奨.

2. `Gemfile`の記述に従ってDependencyをinstall:

```sh
$ bundle install 
```

3. ローカルでウェブサイトをServeします (`localhost:4000` by default):

```sh
$ bundle exec jekyll serve  # alternatively, npm start
```

### How to git push

```
git push --set-upstream origin master
```

### Development (Build From Source)

- Jekyll Themeを修正するためには[Grunt](https://gruntjs.com/)が必要です.
- `Gruntfile.js`に修正が必要な作業が記載されています:
    - minifing JavaScript
    - compiling `.less` to `.css`
    - adding banners to keep the Apache 2.0 license intact, watching for changes, etc. 
- GitHub Pagesのレイアウトなどのコードは `_include/`や`_layouts/`に配置されています.
    - see [Liquid](https://github.com/Shopify/liquid/wiki) templates.
- syntax highlighterは[Rouge](http://rouge.jneen.net/)を用いています.
    - see [here](http://jwarby.github.io/jekyll-pygments-themes/languages/javascript.html))
    - 修正したい場合は`highlight.less`を参照


### Interesting to know more? Checkout the [full user manual](_doc/Manual.md)!


Other Resources
---------------

Ports
- [**Hexo**](https://github.com/Kaijun/hexo-theme-huxblog) by @kaijun
- [**React-SSR**](https://github.com/LucasIcarus/huxpro.github.io/tree/ssr) by @LucasIcarus
