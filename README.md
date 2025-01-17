# disk-filler-release

This BOSH release provides a job for filling disk space on a persistent disk, which can be useful in different (performance) test scenarios that require simulation of a full disk.

## Usage

```sh
$ bosh upload-release --name=disk-filler --version=0.0.1 \
    git+https://github.com/s4heid/disk-filler-release
```

## License

[Apache License](./LICENSE)