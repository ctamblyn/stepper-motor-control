# README

To build the documentation, you will need to install [`meson`][1], [`ninja`][2]
and [`typst`][3], and then run the following commands:

```bash
meson setup builddir
meson compile -C builddir
```

The compiled PDF output will be placed in the `builddir` directory.

**Note:** this build has been tested using version 1.11.1 of `meson`, version
1.11.1 of `ninja` and version 0.15.0 of `typst`.

[1]: https://mesonbuild.com/Getting-meson.html
[2]: https://github.com/ninja-build/ninja/wiki/Pre-built-Ninja-packages
[3]: https://github.com/typst/typst#installation 
