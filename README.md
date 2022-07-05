<div align="center">

# asdf-v ![Test](https://github.com/jthegedus/asdf-v/workflows/Test/badge.svg) ![Lint](https://github.com/jthegedus/asdf-v/workflows/Lint/badge.svg)

[V](https://vlang.io) plugin for [asdf version manager](https://asdf-vm.com)
allowing you to pin `v` versions for each V project.

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

Are tracked in [lib/dependencies.txt](lib/dependencies.txt) and checked on
installation of plugin and `asdf install v *`. The core dependencies are:
`bash`, `curl`, `tar`.

# Install

Plugin:

```shell
asdf plugin add v https://github.com/jthegedus/asdf-v
```

V:

```shell
asdf install v latest
```

Set global version:

```shell
asdf global v latest
```

These commands also apply to `asdf local v <version>`.

# Contributing

Contributions of any kind welcome! See the
[contributing guide](CONTRIBUTING.md).

[Thanks goes to these contributors](https://github.com/jthegedus/asdf-v/graphs/contributors)!

# License

[MIT License](LICENSE) © [James Hegedus](https://github.com/jthegedus/)
