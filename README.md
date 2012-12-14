# importless [![Build Status](https://travis-ci.org/excellenteasy/importless.png?branch=master)](https://travis-ci.org/excellenteasy/importless)

Get .less/.css files from directory without @imports for automatic stylesheet dependency tracking.

## Getting Started
Install the module with: `npm install importless`

```javascript
var importless = require('importless'),
    files = importless.detectDependencies();
```

## License
Copyright (c) 2012 David Pfahler
Licensed under the MIT license.