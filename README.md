# wavflac.sh
A bash script that uses ffmpeg to bulk-convert wav files in a given directory to flac (or vice versa). Works with WSL by converting Windows paths to Linux paths.

## Example:

```bash
wavflac.sh ./
```

## Flags

```
* | -d | --dir  : directory containing files to convert
    -o | --out  : output format ('flac' or 'wav'; default 'flac')
    -w | --win  : convert Windows-style paths (for WSL)
    -h | --help : show this help message
```
