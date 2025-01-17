# disk-filler-release

This BOSH release provides a job for filling disk space on a persistent disk, which can be useful in different (performance) test scenarios that require simulation of a full disk.

## Usage

Upload the release to the BOSH director:

```sh
bosh upload-release --name=disk-filler --version=0.0.1 \
    git+https://github.com/s4heid/disk-filler-release
```

Deploy the release:

```yaml
bosh deploy -d disk-filler manifests/disk-filler.yml
```

Run the errand:

```sh
bosh -d disk-filler run-errand fill-disk
```

To verify that the disk is filled, you can use `bosh instances` to check the disk usage:

```sh
bosh -d disk-filler is --vitals --column=Instance --column="Persistent Disk Usage"
Using environment 'https://bosh.s4heid.internal:25555' as user 's4heid'

Task 190. Done

Deployment 'disk-filler'

Instance                                          Persistent
                                                  Disk Usage
disk-filler/0984cbed-3118-4920-ae61-780c7a4c148a  52% (0i%)

1 instances

Succeeded
```

## License

[Apache License](./LICENSE)