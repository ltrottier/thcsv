# A simple CSV library for Torch #

A simple CSV library for reading / writing Torch [tensor](https://github.com/torch/torch7/blob/master/doc/tensor.md#tensor) objects.

#### Installation ####
From a terminal:
```bash
luarocks install thcsv
```
then:
```lua
thcsv = require 'thcsv'
```

#### How To Read CSV ####

```lua
output = thcsv.read(csvFile, [separator = ',', skipFirst = false])
```
Reads the content of file `csvFile` and store it into `output`. The `output` tensor will have a size of `nRows x nCols`. For CSV files with a header containing a list of field names, you must call the function with `skipFirst = true`. Values are comma-separated by default (separator can be specified using `separator`)

#### How To Write CSV ####

```lua
thcsv.write(csvFile, input, [separator = ', ', header = {}])
```
Write the content of `input` into file `csvFile`, where `input` is a `nRows x nCols` tensor. Additionally, provide a table of field names `header = {id1, id2, ...}` to add a header to the CSV file. Values are comma-separated by default (separator can be specified using `separator`)

#### Example ####
```lua
thcsv = require 'thcsv'
thcsv.write('eye.csv', torch.eye(5))
output = thcsv.read('eye.csv')
output
 1  0  0  0  0
 0  1  0  0  0
 0  0  1  0  0
 0  0  0  1  0
 0  0  0  0  1
[torch.DoubleTensor of size 5x5]
```


