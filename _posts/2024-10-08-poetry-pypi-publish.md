---
layout: post
title: "Pypiへpublishメモ"
subtitle: "Poetry"
author: "Ryo"
header-style: text
header-mask: 0.0
catelog: true
mathjax: false
mermaid: false
last_modified_at: 2024-10-08
tags:

- python
---

## How to publish your repository

Install Poetry: This command installs Poetry, a tool for dependency management and packaging in Python.
Configure PyPI Credentials: This step configures your PyPI credentials so that Poetry can authenticate with PyPI.
Build the Package: This command builds the source distribution and wheel for your package.
Publish the Package: This command publishes your package to PyPI.
Make sure your pyproject.toml file is correctly configured, as shown in your provided excerpt. This includes specifying the package name, version, description, authors, dependencies, and build system.
After running these commands, your package should be available on PyPI.

<strong > &#9654;&nbsp; Steps</strong>

1. Register to PyPI.
2. Register the PyPI token in Poetry.
3. Commit the latest version to the main branch and add a tag.
4. Publish.

```zsh
# Configure PyPI credentials
poetry config pypi-token.pypi <your-pypi-token>

# commit
git commit -m "PUB: v.1.4.0"  

# add tag
git tag v1.4.0

# push
git push

# Publish the package
poetry publish --build
```

<strong > &#9654;&nbsp; Is it okay to add the `dist` folder to .gitignore, which is created when running the `poetry publish --build` command?</strong>

the `poetry publish --build` command creates the `dist` folder. Here's why:

1. Build Process: When you run `poetry publish --build`, Poetry first builds your package. This involves creating distribution archives (e.g., source distribution `.tar.gz` and wheel `.whl` files) for your project.
2. Output Location: These distribution files are placed in the `dist` folder by default. This folder is where Poetry stores the built artifacts before they are uploaded to PyPI.

The `dist` folder is essentially a temporary storage location for the built package files. 
Since these files can be regenerated by running the build command again, it is common practice to add the `dist` folder to your `.gitignore` file to avoid cluttering your repository with build artifacts.